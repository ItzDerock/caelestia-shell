#!/usr/bin/env bash 

source ~/.nix-profile/etc/profile.d/hm-session-vars.sh

export RULE_DBUS='quickshell.dbus.properties.warning = false;quickshell.dbus.dbusmenu.warning = false'  # System tray dbus property errors
export RULE_NOTIFS='quickshell.service.notifications.warning = false'  # Notification server warnings on reload
export RULE_SNI='quickshell.service.sni.host.warning = false'  # StatusNotifierItem warnings on reload
export RULE_PROCESS='QProcess: Destroyed while process'  # Long running processes on reload

qs -p $(dirname "$0") --log-rules "$RULE_DBUS;$RULE_NOTIFS;$RULE_SNI"
