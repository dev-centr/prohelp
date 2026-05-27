module app;

import std.stdio;
import prohelp.intercept;

void main(string[] args) {
    // Intercept help triggers (takes first pass on cli arguments)
    if (intercept(args)) return;

    // Default message when run without help parameters
    writeln("prohelp: Progressive & Professional Help CLI Prototyping Tool");
    writeln("=============================================================");
    writeln("This tool parses and previews 'help.sdl' configurations in the current directory.");
    writeln();
    writeln("Usage:");
    writeln("  prohelp ?                     Run progressive Text Mode in system locale");
    writeln("  prohelp ?:i                   Run Interactive TUI Viewport in system locale");
    writeln("  prohelp ?:de                  Run progressive Text Mode in German");
    writeln("  prohelp ?:es,i                Run Interactive TUI Viewport in Spanish");
    writeln("  prohelp ?:?                   List available languages in help.sdl");
    writeln();
    writeln("Navigation Examples:");
    writeln("  prohelp ? operations          Drill directly to operations section");
    writeln("  prohelp ? operations *        Dump all subsections under operations recursively");
    writeln();
    writeln("Ensure a 'help.sdl' file is present in the current execution folder to test.");
}
