import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3

Page {
    id: pageselection
    width: 600
    height: 400
    spacing: -6
    transformOrigin: Item.TopLeft

    title: qsTr("Настройки") + rootItem.emptyString
    Rectangle {
        id: rectangle
        x: 15
        y: 14
        width: window.width-30
        height: window.height/3
        color: "#cfcfcf"
        radius: 0
        border.width: 1

        RowLayout {
            anchors.topMargin: 10
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter

         }



    }
}
