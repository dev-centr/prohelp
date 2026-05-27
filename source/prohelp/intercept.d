module prohelp.intercept;

import std.stdio;
import std.string;
import std.conv;
import std.array;
import std.algorithm;
import std.file;
import prohelp.parser;
import prohelp.renderer;
import prohelp.locale;
import prohelp.pager;

// First-pass CLI Argument Interceptor
public bool intercept(string[] args) {
    if (args.length < 2) return false;

    string trigger = args[1].toLower();
    
    // Core help triggers
    bool matched = false;
    string configSuffix = "";

    // Parse triggers matching help, ?, --help, -h, etc.
    string[] baseTriggers = ["?", "help", "--help", "-h", "--?"];
    foreach (t; baseTriggers) {
        if (trigger == t) {
            matched = true;
            break;
        } else if (trigger.startsWith(t ~ ":")) {
            matched = true;
            configSuffix = trigger[t.length + 1 .. $];
            break;
        }
    }

    if (!matched) return false;

    // Load help.sdl schema
    string schemaPath = "help.sdl";
    if (!exists(schemaPath)) {
        stderr.writeln("prohelp error: Mandatory schema file '" ~ schemaPath ~ "' was not found in the current directory.");
        return true; // We matched a help token, exit application with failure warning
    }

    Command cmd;
    try {
        cmd = parseHelpSDL(schemaPath);
    } catch (Exception e) {
        stderr.writeln(e.msg);
        return true;
    }

    // Default locale detection
    string localeCode = getSystemLocale();
    bool useTUI = false;

    // Parse comma-separated config suffixes: ?,de,i or ?:i
    if (configSuffix.length > 0) {
        string[] options = configSuffix.split(",");
        foreach (opt; options) {
            opt = opt.strip().toLower();
            if (opt == "i" || opt == "interactive" || opt == "viewport" || opt == "tui") {
                useTUI = true;
            } else if (opt == "text" || opt == "txt" || opt == "static") {
                useTUI = false;
            } else if (opt == "?") {
                // List available locales and exit
                writeln("Available translations in help.sdl:");
                writeln("  - en (Default English)");
                foreach (lang; cmd.locales.keys) {
                    writeln("  - " ~ lang);
                }
                return true;
            } else {
                // Treat as target locale key
                localeCode = opt;
            }
        }
    }

    // Parse trailing navigation tokens e.g. operations creation *
    string[] path;
    bool dumpSubtree = false;

    for (size_t i = 2; i < args.length; i++) {
        string token = args[i].strip();
        if (token == "*" || token == "all") {
            dumpSubtree = true;
        } else {
            path ~= token;
        }
    }

    // Locale switching through double-interception tip
    if (path.length == 1 && path[0] == "?") {
        writeln("Available languages in help.sdl:");
        writeln("  - en (English / Fallback)");
        foreach (lang; cmd.locales.keys) {
            writeln("  - " ~ lang);
        }
        return true;
    }

    // Verify active locale exists in the command locales (otherwise fall back)
    if (localeCode != "en" && (localeCode in cmd.locales) is null) {
        // Fall back silently
        localeCode = "en";
    }

    // Resolve target section node
    Section targetSection;
    if (path.length == 0) {
        // Root node
        auto rootSec = new Section();
        rootSec.name = cmd.name;
        rootSec.summary = cmd.summary;
        rootSec.content = cmd.description;
        rootSec.subsections = cmd.sections;
        targetSection = rootSec;
    } else {
        targetSection = cmd.findSection(path);
        if (targetSection is null) {
            writefln("prohelp error: Category path '%s' not found.", path.join(" > "));
            return true;
        }
    }

    // Route execution based on TUI preference and interactive TTY
    if (useTUI && isStdoutTTY()) {
        launchInteractiveTUI(cmd, path, localeCode);
    } else {
        // Text Mode rendering
        bool color = isStdoutTTY(); // strip ANSI color codes if piped or redirected

        if (dumpSubtree) {
            printSubtreeRecursive(cmd, targetSection, path, localeCode, color);
        } else {
            string box = renderSectionBox(cmd, targetSection, path, localeCode, color);
            write(box);
            stdout.flush();
        }
    }

    return true;
}

// Recursively prints the visual boxes of a section and all its children
private void printSubtreeRecursive(Command cmd, Section sec, string[] path, string localeCode, bool enableColor) {
    string box = renderSectionBox(cmd, sec, path, localeCode, enableColor);
    write(box);
    stdout.flush();

    foreach (sub; sec.subsections) {
        printSubtreeRecursive(cmd, sub, path ~ sub.name, localeCode, enableColor);
    }
}
