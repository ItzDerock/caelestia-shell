pragma Singleton

import QtQuick
import Quickshell
import Caelestia.Config
import qs.services

Singleton {
    id: root

    readonly property var windows: Hypr.toplevels.values

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
}
