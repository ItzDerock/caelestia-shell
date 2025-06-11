import "root:/widgets"
import "root:/services"
import "root:/config"
import QtQuick

Item {
    id: root

    anchors.top: parent.top
    anchors.bottom: parent.bottom
    implicitWidth: DashboardConfig.sizes.dateTimeWidth

    StyledText {
        id: hours

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: (root.height - (hours.implicitHeight + mins.implicitHeight + mins.anchors.topMargin + date.implicitHeight + date.anchors.topMargin)) / 2

        horizontalAlignment: Text.AlignHCenter
        text: Time.format("HH")
        color: Colours.palette.m3secondary
        font.pointSize: Appearance.font.size.extraLarge
        font.weight: 500
    }

    StyledText {
        id: mins

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: hours.bottom
        anchors.topMargin: -font.pointSize * 0.45

        horizontalAlignment: Text.AlignHCenter
        text: Time.format("mm")
        color: Colours.palette.m3secondary
        font.pointSize: Appearance.font.size.extraLarge
        font.weight: 500
    }

    StyledText {
        id: date

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: mins.bottom
        anchors.topMargin: Appearance.spacing.normal

        horizontalAlignment: Text.AlignHCenter
        text: Time.format("ddd, d")
        color: Colours.palette.m3tertiary
        font.pointSize: Appearance.font.size.normal
        font.weight: 500
    }
}
