#import "common.h"

int main(int argc, char **argv, char **envp) {
    @autoreleasepool {
        setuid(501);
        setgid(501);
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:PREF_PATH];
        NSMutableDictionary *mutableDict = dict ? [dict mutableCopy] : [NSMutableDictionary dictionary];

        [mutableDict removeObjectForKey:KEY];
        [mutableDict writeToFile:PREF_PATH atomically:YES];

        killProcessByName("Preferences");
    }
    return 0;
}
