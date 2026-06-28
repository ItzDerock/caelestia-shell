pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Caelestia.Config
import qs.services

Singleton {
    id: root

    // Hypr.toplevels can retain stale entries that are no longer real windows
    // (e.g. transient XWayland helper windows like "Default IME" or
    // ".NET-BroadcastEventWindow"). Cross-check against a live `hyprctl clients`
    // query so only currently-open windows are listed.
    property var validAddresses: new Set()

    readonly property var windows: Hypr.toplevels.values.filter(t => validAddresses.has(t.address))

    function refresh(): void {
        clientsProc.running = true;
    }

    function query(search: string): list<var> {
        const prefix = `${GlobalConfig.launcher.actionPrefix}windows `;
        const q = search.slice(prefix.length).toLowerCase().trim();
        const wins = windows;

        if (!q)
            return [...wins];

        return wins.filter(t =>
            (t.title ?? "").toLowerCase().includes(q) ||
            (t.lastIpcObject.class ?? "").toLowerCase().includes(q)
        );
    }

    Component.onCompleted: refresh()

    Connections {
        target: Hyprland

        function onRawEvent(event: HyprlandEvent): void {
            const n = event.name;
            if (n === "openwindow" || n === "closewindow")
                root.refresh();
        }
    }

    Process {
        id: clientsProc

        command: ["hyprctl", "clients", "-j"]

        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    const clients = JSON.parse(text);
                    root.validAddresses = new Set(clients.map(c => (c.address ?? "").replace(/^0x/, "")));
                } catch (e) {
                    // Leave the previous set intact on parse failure
                }
            }
        }
    }
}
