//@ pragma UseQApplication
//@ pragma IconTheme breeze-dark

import Quickshell

import qs.modules

ShellRoot {
    LeftBar {
        id: leftBar

        onInstantiated: () => {
            topBarLoader.loading = true;
        }
    }
    LazyLoader {
        id: topBarLoader
        TopBar {}
    }
    Lockscreen {}
    NotificationPopup {}
    NotificationCenterPanel {}
}
