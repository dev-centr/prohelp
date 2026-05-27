module prohelp.parser;

import std.stdio;
import std.string;
import std.conv;
import std.array;
import std.algorithm;
import sdlang;

public class Option {
    string[] flags;
    string description;
    string dominance = "medium"; // "high", "medium", "low"
}

public class Section {
    string name;
    string summary;
    string content;
    bool inlineExpand = false;
    Section[] subsections;
    Option[] options;

    // Line budget calculation based on simulated Text Mode output format
    int calculateLineCount(int level) {
        // Unicode box borders and visual headers:
        // Top border + Title: 1 line
        // Description/Summary: 2 lines
        // Spacer: 1 line
        int count = 4;

        if (content.length > 0) {
            count += 2; // Content + spacer
        }

        if (subsections.length > 0) {
            count += 2; // Header + spacer
            count += subsections.length;
        }

        if (options.length > 0) {
            auto high = options.filter!(o => o.dominance == "high").array;
            auto med = options.filter!(o => o.dominance == "medium").array;
            auto low = options.filter!(o => o.dominance == "low").array;

            if (high.length > 0) {
                count += 2; // priority header + spacer
                count += high.length;
            }
            if (med.length > 0) {
                count += 2; // priority header + spacer
                count += med.length;
            }
            if (low.length > 0) {
                count += 2; // priority header + spacer
                count += low.length;
            }
        }

        // Bottom border line: 1
        count += 1;
        return count;
    }
}

public class LocaleInfo {
    string summary;
    string description;
}

public class Command {
    string name;
    string summary;
    string description;
    LocaleInfo[string] locales; // locale -> info
    Section[] sections;

    // Recursive search through section path
    Section findSection(string[] path) {
        if (path.length == 0) return null;
        return findSectionRecursive(sections, path);
    }

    private Section findSectionRecursive(Section[] list, string[] path) {
        if (path.length == 0) return null;
        foreach (sec; list) {
            if (sec.name == path[0]) {
                if (path.length == 1) return sec;
                return findSectionRecursive(sec.subsections, path[1..$]);
            }
        }
        return null;
    }
}

// Main parser function that reads help.sdl
public Command parseHelpSDL(string filename) {
    Tag root;
    try {
        root = parseFile(filename);
    } catch (Exception e) {
        throw new Exception("prohelp schema parse error in '" ~ filename ~ "': " ~ e.msg);
    }

    Tag cmdTag = root.getTag("command");
    if (cmdTag is null) {
        throw new Exception("prohelp schema error: Root 'command' tag is missing in '" ~ filename ~ "'");
    }

    if (cmdTag.values.length == 0 || cmdTag.values[0].peek!string() is null) {
        throw new Exception("prohelp schema error: 'command' tag must have a name value (string)");
    }

    auto cmd = new Command();
    cmd.name = cmdTag.values[0].get!string();

    foreach (child; cmdTag.tags) {
        if (child.name == "summary") {
            cmd.summary = child.values[0].get!string();
        } else if (child.name == "description") {
            cmd.description = child.values[0].get!string();
        } else if (child.name == "locale") {
            parseLocale(child, cmd);
        } else if (child.name == "section") {
            auto sec = new Section();
            parseSection(child, sec, 0);
            cmd.sections ~= sec;
        }
    }

    // Check sliding-scale line budgets for Level 0
    // (Calculated approximately: we print standard root level metadata)
    int rootLines = 6 + cast(int)cmd.sections.length;
    if (rootLines > 20) {
        stderr.writeln("prohelp warning: Level 0 root help page layout exceeds the 20-line single-screen budget (" ~ 
            rootLines.to!string ~ " lines calculated). Consider merging categories or making sections inline.");
    }

    return cmd;
}

private void parseLocale(Tag locTag, Command cmd) {
    if (locTag.values.length == 0 || locTag.values[0].peek!string() is null) return;
    string lang = locTag.values[0].get!string().toLower();
    
    auto info = new LocaleInfo();
    foreach (child; locTag.tags) {
        if (child.name == "summary") {
            info.summary = child.values[0].get!string();
        } else if (child.name == "description") {
            info.description = child.values[0].get!string();
        }
    }
    cmd.locales[lang] = info;
}

private void parseSection(Tag secTag, Section sec, int level) {
    if (secTag.values.length == 0 || secTag.values[0].peek!string() is null) {
        throw new Exception("prohelp schema error: 'section' tag must specify a string name.");
    }
    sec.name = secTag.values[0].get!string();

    foreach (child; secTag.tags) {
        if (child.name == "summary") {
            sec.summary = child.values[0].get!string();
        } else if (child.name == "content") {
            sec.content = child.values[0].get!string();
        } else if (child.name == "inline") {
            sec.inlineExpand = child.values[0].get!bool();
        } else if (child.name == "section") {
            auto sub = new Section();
            parseSection(child, sub, level + 1);
            sec.subsections ~= sub;
        } else if (child.name == "option") {
            sec.options ~= parseOption(child, "medium");
        } else if (child.name == "dominance") {
            if (child.values.length > 0 && child.values[0].peek!string() !is null) {
                string dom = child.values[0].get!string();
                foreach (optTag; child.tags) {
                    if (optTag.name == "option") {
                        sec.options ~= parseOption(optTag, dom);
                    }
                }
            }
        }
    }

    // Validate progressive line budgets for deeper sections
    int calculatedLines = sec.calculateLineCount(level + 1);
    int budget = (level == 0) ? 40 : 60;
    if (calculatedLines > budget) {
        stderr.writeln("prohelp warning: Section '" ~ sec.name ~ "' (Level " ~ 
            (level + 1).to!string ~ ") exceeds its " ~ budget.to!string ~ 
            "-line budget (" ~ calculatedLines.to!string ~ " lines calculated). Please organize into deeper subsections.");
    }
}

private Option parseOption(Tag optTag, string dominance) {
    auto opt = new Option();
    opt.dominance = dominance;

    if (optTag.values.length > 1) {
        for (size_t i = 0; i < optTag.values.length - 1; i++) {
            if (optTag.values[i].peek!string() !is null) {
                opt.flags ~= optTag.values[i].get!string();
            }
        }
        if (optTag.values[$ - 1].peek!string() !is null) {
            opt.description = optTag.values[$ - 1].get!string();
        }
    } else if (optTag.values.length == 1) {
        if (optTag.values[0].peek!string() !is null) {
            opt.description = optTag.values[0].get!string();
        }
    }
    return opt;
}
