module prohelp.config;

import prohelp.parser;

/// Schema source for a single intercept invocation.
public struct InterceptConfig {
    string schemaPath = "";
    string schemaContent = "";
    string schemaLabel = "help.sdl";

    @property bool isConfigured() const {
        return schemaPath.length > 0 || schemaContent.length > 0;
    }

    static InterceptConfig fromFile(string path) {
        InterceptConfig config;
        config.schemaPath = path;
        config.schemaLabel = path;
        return config;
    }

    static InterceptConfig fromContent(string content, string label = "help.sdl") {
        InterceptConfig config;
        config.schemaContent = content;
        config.schemaLabel = label;
        return config;
    }

    /// Host-application default: `help.sdl` in the working directory.
    static InterceptConfig cwdDefault() {
        return fromFile("help.sdl");
    }
}

public Command loadCommand(const InterceptConfig config) {
    if (config.schemaContent.length > 0) {
        return parseHelpSDLContent(config.schemaContent, config.schemaLabel);
    }

    string path = config.schemaPath.length > 0 ? config.schemaPath : "help.sdl";
    return parseHelpSDL(path);
}
