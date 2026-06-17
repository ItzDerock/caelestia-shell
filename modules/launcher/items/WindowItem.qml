import QtQuick
import Quickshell
import Quickshell.Widgets
import Caelestia.Config
import qs.components
import qs.services

Item {
    id: root

    required property var modelData
    required property DrawerVisibilities visibilities

    implicitHeight: Tokens.sizes.launcher.itemHeight

    anchors.left: parent?.left
    anchors.right: parent?.right

    function onClicked(): void {
        const addr = root.modelData?.address;
        Hypr.dispatch(Hypr.usingLua
            ? `hl.dsp.focus({ window = "address:0x${addr}" })`
            : `focuswindow address:0x${addr}`);
        root.visibilities.launcher = false;
    }

    StateLayer {
        radius: Tokens.rounding.large
        onClicked: root.onClicked()
    }

    Item {
        anchors.fill: parent
        anchors.leftMargin: Tokens.padding.medium
        anchors.rightMargin: Tokens.padding.medium
        anchors.margins: Tokens.padding.small

        IconImage {
            id: icon

            asynchronous: true
            source: Quickshell.iconPath(root.modelData?.lastIpcObject?.class ?? "", "image-missing")
            implicitSize: parent.height * 0.8

            anchors.verticalCenter: parent.verticalCenter
        }

        Column {
            anchors.left: icon.right
            anchors.leftMargin: Tokens.spacing.medium
            anchors.verticalCenter: parent.verticalCenter

            width: parent.width - icon.implicitSize - Tokens.spacing.medium
            spacing: 0

            StyledText {
                text: root.modelData?.title ?? ""
                font: Tokens.font.body.medium
                elide: Text.ElideRight
                width: parent.width
            }

            StyledText {
                readonly property var ws: root.modelData?.workspace
                readonly property string monitorName: ws?.lastIpcObject?.monitor ?? ""

                text: ws ? `Workspace ${ws.id} on ${monitorName}` : ""
                font: Tokens.font.body.small
                color: Colours.palette.m3outline
                elide: Text.ElideRight
                width: parent.width
            }
        }
    }
}
