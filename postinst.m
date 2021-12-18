#import <UIKit/UIKit.h>
#include <spawn.h>

#define PREF_PATH @"/private/var/containers/Shared/SystemGroup/systemgroup.com.apple.configurationprofiles/Library/ConfigurationProfiles/CloudConfigurationDetails.plist"
#define KEY @"IsSupervised"

static void easy_spawn(const char* args[]) {
    // Example usage: easy_spawn((const char *[]){"/usr/bin/killall", "backboardd", NULL});
    pid_t pid;
    int status;
    posix_spawn(&pid, args[0], NULL, NULL, (char* const*)args, NULL);
    waitpid(pid, &status, WEXITED);
}

int main(int argc, char **argv, char **envp) {
    @autoreleasepool {
        setuid(501);
        setgid(501);
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:PREF_PATH];
        NSMutableDictionary *mutableDict = dict ? [dict mutableCopy] : [NSMutableDictionary dictionary];

        [mutableDict setValue:@YES forKey:KEY];
        [mutableDict writeToFile:PREF_PATH atomically:YES];

        easy_spawn((const char *[]){"/usr/bin/killall", "Preferences", NULL});
    }
    return 0;
}
