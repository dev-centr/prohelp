module app;

import std.array;
import std.algorithm;
import std.string;
import std.stdio;
import prohelp.config;
import prohelp.intercept;

version (ProhelpExecutable) {
    private enum embeddedHelpSdl = import("help.sdl");
}

private bool isSchemaPath(string arg) {
    return arg.endsWith(".sdl");
}

private bool isHelpTrigger(string arg) {
    string lower = arg.toLower();
    string[] triggers = ["?", "help", "--help", "-h", "--?"];
    foreach (trigger; triggers) {
        if (lower == trigger || lower.startsWith(trigger ~ ":")) {
            return true;
        }
    }
    return false;
}

private InterceptConfig parseCliConfig(ref string[] args) {
    InterceptConfig config;

    while (args.length > 0) {
        if (args[0] == "--schema" || args[0] == "-f") {
            if (args.length < 2) {
                stderr.writeln("prohelp error: Missing path after '" ~ args[0] ~ "'.");
                return InterceptConfig.init;
            }
            config = InterceptConfig.fromFile(args[1]);
            args = args[2 .. $];
            continue;
        }

        if (args[0] == "--") {
            args = args[1 .. $];
            break;
        }

        if (isSchemaPath(args[0])) {
            config = InterceptConfig.fromFile(args[0]);
            args = args[1 .. $];
            continue;
        }

        break;
    }

    if (!config.isConfigured) {
        version (ProhelpExecutable) {
            config = InterceptConfig.fromContent(embeddedHelpSdl, "help.sdl");
        } else {
            config = InterceptConfig.cwdDefault();
        }
    }

    return config;
}

void main(string[] argv) {
    string[] args = argv.dup;
    string program = args.length > 0 ? args[0] : "prohelp";

    string[] tail = args.length > 1 ? args[1 .. $].dup : [];
    InterceptConfig config = parseCliConfig(tail);

    if (!config.isConfigured && tail.length > 0 && (tail[0] == "--schema" || tail[0] == "-f")) {
        return;
    }

    if (!config.isConfigured) {
        stderr.writeln("prohelp error: No help schema available.");
        return;
    }

    string[] helpArgs;
    if (tail.length == 0) {
        helpArgs = [program, "?"];
    } else if (isHelpTrigger(tail[0])) {
        helpArgs = [program] ~ tail;
    } else {
        stderr.writeln("prohelp error: Unrecognized arguments.");
        stderr.writeln("Run 'prohelp ?' for built-in help, or preview another command with:");
        stderr.writeln("  prohelp path/to/help.sdl ?");
        return;
    }

    intercept(helpArgs, config);
}
