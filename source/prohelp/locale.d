module prohelp.locale;

import std.string;
import std.process;
import std.algorithm;

version(Windows) {
    import core.sys.windows.windows;
    
    // Explicit Win32 binding to GetUserDefaultLocaleName for safety in D compilers
    extern(Windows) int GetUserDefaultLocaleName(wchar* lpLocaleName, int cchLocaleName);
}

public string getSystemLocale() {
    string locale = "en";

    version(Windows) {
        wchar[85] buffer;
        int len = GetUserDefaultLocaleName(buffer.ptr, 85);
        if (len > 1) {
            import std.utf : toUTF8;
            // slice to length minus the null terminator
            string full = toUTF8(buffer[0 .. len - 1]);
            locale = full.strip().toLower().replace("_", "-");
        }
    } else {
        // POSIX standard locale checks
        string lang = environment.get("LC_ALL", 
            environment.get("LC_MESSAGES", 
            environment.get("LANG", "")));
            
        if (lang.length > 0) {
            // Strip any charset encodings e.g., de_DE.UTF-8 -> de_DE
            ptrdiff_t dotIdx = lang.indexOf('.');
            if (dotIdx != -1) {
                lang = lang[0 .. dotIdx];
            }
            // Strip modifier suffixes e.g., en_US@euro -> en_US
            ptrdiff_t atIdx = lang.indexOf('@');
            if (atIdx != -1) {
                lang = lang[0 .. atIdx];
            }
            locale = lang.replace("_", "-").toLower();
        }
    }

    return locale;
}
