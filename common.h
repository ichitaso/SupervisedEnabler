#import <UIKit/UIKit.h>
#import <sys/sysctl.h>
#import <signal.h>

#define PREF_PATH @"/private/var/containers/Shared/SystemGroup/systemgroup.com.apple.configurationprofiles/Library/ConfigurationProfiles/CloudConfigurationDetails.plist"
#define KEY @"IsSupervised"

static void killProcessByName(const char *processName) {
    int mib[4] = {CTL_KERN, KERN_PROC, KERN_PROC_ALL, 0};
    size_t size;
    
    if (sysctl(mib, 4, NULL, &size, NULL, 0) < 0) return;
    
    struct kinfo_proc *procs = malloc(size);
    if (!procs) return;
    
    if (sysctl(mib, 4, procs, &size, NULL, 0) == 0) {
        int count = (int)(size / sizeof(struct kinfo_proc));
        for (int i = 0; i < count; i++) {
            if (strcmp(procs[i].kp_proc.p_comm, processName) == 0) {
                pid_t pid = procs[i].kp_proc.p_pid;
                kill(pid, SIGKILL); // or SIGTERM
            }
        }
    }
    free(procs);
}
