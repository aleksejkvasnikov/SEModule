import QtQuick 2.11
import QtQuick.Controls 2.4
import Qt.labs.platform 1.0
import QtQuick.Layouts 1.11
ApplicationWindow {
    property color firstColor
    property color secondColor
    id: window
    flags: Qt.FramelessWindowHint|Qt.Window
    visible: true
    width: 740
    height: 530
    title: qsTr("3D SE box") + " v1.1" + rootItem.emptyString
    /*SystemTrayIcon {
        visible: true
        iconSource: "ru.svg"
        menu: Menu {
            MenuItem {
                text: qsTr("Open")
                onTriggered:    {
                    window.show()
                    window.raise()
                }
            }
            MenuItem {
                text: qsTr("Quit")
                onTriggered: Qt.quit()
            }
        }
    } */
    Timer {
        interval: 2000 // triggers every 5000 ms
        onTriggered: {
            window.flags = Qt.Window
            toolBar.visible = true
            stackView.push("calculating.qml")
        }
        running: true
    }

    Popup {
        id: popup
        x: window.width * 0.3
        y: window.height * 0.3
        width: window.width * 0.4
        height:  window.height * 0.4
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
        onClosed: {
            image.visible = false;
        }

        Text {
            id: text1
            text: qsTr("О программе") + rootItem.emptyString
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: window.top
            anchors.topMargin: 0
            font.pixelSize: 12
        }

        Button {
            id: button
            width: 200
            height: 29
            text: qsTr("Свидетельство о регистрации") + rootItem.emptyString
            anchors.topMargin: 25
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            onClicked: {
                image.visible = true
            }
        }

        Text {
            id: text2
            text: qsTr("email: aleksejkvasnikov@gmail.com")
            anchors.top: parent.top
            anchors.topMargin: 80
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 12
        }

        Image {
            id: image
            width: window.width* 0.5
          //  height: 100
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.left: parent.left
            visible: false
            fillMode: Image.PreserveAspectFit
            source: "document.PNG"
        }
    }
    header: ToolBar {
        id: toolBar
        visible: false
        contentHeight: toolButton.implicitHeight
        ToolButton {
            id: toolButton
            text: stackView.depth > 1 ? "\u25C0" : "\u2630"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
                    //drawer.open()
                } else {
                    drawer.open()
                }
            }
        }
        Button {
            id: aboutButton
            x: 46
            y: 0
            width: 39
            height: 40
            text: "?"
            anchors.rightMargin: 0
            anchors.right: window.right
            // anchors.rightMargin: -639
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: popup.open()
        }
        Label {
            text: stackView.currentItem.title
            anchors.centerIn: parent
        }
        Button {
            id: settingButton
            x: 85
            y: 0
            width: 39
            height: 40
            text: "⚙"
            anchors.rightMargin: 0
            anchors.right: window.right
            // anchors.rightMargin: -639
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: stackView.push("settings.qml")
        }
        Label {
            text: stackView.currentItem.title
            anchors.centerIn: parent
        }
    }
   /* MenuBar {
        id: menuBar

        Menu {
            id: fileMenu
            title: qsTr("Файл") + rootItem.emptyString
            MenuItem {
                       text: qsTr("Сохранить") + rootItem.emptyString
                       onTriggered: autoIndentSelection()
                   }

                   MenuItem {
                       text: qsTr("Загрузить") + rootItem.emptyString
                       onTriggered: rewrapParagraph()
                   }
        }
       Menu {
            id: helpMenu
            title: qsTr("Помощь") + rootItem.emptyString
            MenuItem {
                text: qsTr("О программе") + rootItem.emptyString
                onTriggered: popup.open()
            }
            // ...
        }
    }*/
   /* Menu {
        id: contextMenu
        MenuItem { text: qsTr("Новый файл") + rootItem.emptyString }
        MenuItem { text: qsTr("Сохранить") + rootItem.emptyString }
        MenuItem { text: qsTr("Загрузить") + rootItem.emptyString }
    } */
    FileDialog {
        id: folderDialog
        //currentFolder: viewer.folder
        folder: StandardPaths.standardLocations(StandardPaths.DesktopLocation)[0]
        title: qsTr("Please choose a file") + rootItem.emptyString
        onAccepted: {
            console.log("You chose: " + folderDialog.file)
            var path = folderDialog.file.toString();
            // remove prefixed "file:///"
            path= path.replace(/^(file:\/{3})|(qrc:\/{2})|(http:\/{2})/,"");
            // unescape html codes like '%23' for '#'
            modList.save(decodeURIComponent(path))
            folderDialog.close()
        }
        onRejected: {
            console.log("Canceled")
            folderDialog.close()
        }
    }

    Drawer {
        id: drawer
        edge: Qt.TopEdge
        width: window.width
        height: window.height * 0.1

        Row {
            anchors.fill: parent

           ItemDelegate {
                id: file
                width: window.width/5
                text: qsTr("Файл") + rootItem.emptyString
                //text: qsTr("Файл")
                height: parent.height
                /*
                onClicked: {
                    folderDialog.open()
                   // contextMenu.open()
                    //modList.save()
                    // stackView.push("Page1Form.ui.qml")
                    // drawer.close()
                }*/

                ComboBox {
                    //name: qsTr("Файл")
                    width: window.width/5 - 5
                    model: [ "Banana", "Apple" ]
                    height: parent.height - 5
                    x: 3
                    y: 3
                    onCurrentIndexChanged: console.debug(cbItems.get(currentIndex).text)
                }
                /*
                contentItem: Text {
                    rightPadding: file.spacing
                    text: file.text
                    font: file.font
                    // color: file.enabled ? (file.down ? "#17a81a" : "#21be2b") : "#bdbebf"
                    elide: Text.ElideRight
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }*/
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40
                    opacity: enabled ? 1 : 0.3
                    // border.color: file.enabled ? (file.down ? "#17a81a" : "#21be2b") : "#bdbebf"
                    border.width: 1
                    // color: file.down ? "#dddedf" : "#eeeeee"

                    Rectangle {
                        width: parent.width
                        height: 1
                        //   color: file.down ? "#17a81a" : "#21be2b"
                        anchors.bottom: parent.bottom
                    }
                }
            }
            ItemDelegate {
                id: modeling
                width: window.width/5
                text: qsTr("Моделирование") + rootItem.emptyString
                height: parent.height
                onClicked: {
                    stackView.push("modeling.qml")
                    drawer.close()
                }
                contentItem: Text {
                    rightPadding: modeling.spacing
                    text: modeling.text
                    font: modeling.font
                    //  color: modeling.enabled ? (modeling.down ? "#17a81a" : "#21be2b") : "#bdbebf"
                    elide: Text.ElideRight
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40
                    opacity: enabled ? 1 : 0.3
                    //  border.color: file.enabled ? (file.down ? "#17a81a" : "#21be2b") : "#bdbebf"
                    border.width: 1
                    //  color: modeling.down ? "#dddedf" : "#eeeeee"

                    Rectangle {
                        width: parent.width
                        height: 1
                        //    color: modeling.down ? "#17a81a" : "#21be2b"
                        anchors.bottom: parent.bottom
                    }
                }
            }

            ItemDelegate {
                id: calculations
                width: window.width/5
                text: qsTr("Вычисление") + rootItem.emptyString
                height: parent.height
                onClicked: {
                    stackView.push("calculating.qml")
                    drawer.close()
                }
                contentItem: Text {
                    rightPadding: calculations.spacing
                    text: calculations.text
                    font: calculations.font
                    // color: calculations.enabled ? (calculations.down ? "#17a81a" : "#21be2b") : "#bdbebf"
                    elide: Text.ElideRight
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40
                    opacity: enabled ? 1 : 0.3
                    //  border.color: file.enabled ? (file.down ? "#17a81a" : "#21be2b") : "#bdbebf"
                    border.width: 1
                    //  color: calculations.down ? "#dddedf" : "#eeeeee"

                    Rectangle {
                        width: parent.width
                        height: 1
                        //   color: calculations.down ? "#17a81a" : "#21be2b"
                        anchors.bottom: parent.bottom
                    }
                }
            }
            ItemDelegate {
                id: results
                width: window.width/5
                text: qsTr("Результаты") + rootItem.emptyString
                height: parent.height
                onClicked: {
                    stackView.push("results.qml")
                    drawer.close()
                }
                contentItem: Text {
                    rightPadding: results.spacing
                    text: results.text
                    font: results.font
                    //  color: modeling.enabled ? (modeling.down ? "#17a81a" : "#21be2b") : "#bdbebf"
                    elide: Text.ElideRight
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40
                    opacity: enabled ? 1 : 0.3
                    //  border.color: file.enabled ? (file.down ? "#17a81a" : "#21be2b") : "#bdbebf"
                    border.width: 1
                    //  color: modeling.down ? "#dddedf" : "#eeeeee"

                    Rectangle {
                        width: parent.width
                        height: 1
                        //    color: modeling.down ? "#17a81a" : "#21be2b"
                        anchors.bottom: parent.bottom
                    }
                }
            }
            ItemDelegate {
                id: settings
                width: window.width/5
                text: qsTr("Настройки") + rootItem.emptyString
                height: parent.height
                onClicked: {
                    stackView.push("settings.qml")
                    drawer.close()
                }
                contentItem: Text {
                    rightPadding: settings.spacing
                    text: settings.text
                    font: settings.font
                    // color: settings.enabled ? (settings.down ? "#17a81a" : "#21be2b") : "#bdbebf"
                    elide: Text.ElideRight
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40
                    opacity: enabled ? 1 : 0.3
                    // border.color: file.enabled ? (file.down ? "#17a81a" : "#21be2b") : "#bdbebf"
                    border.width: 1
                    //   color: settings.down ? "#dddedf" : "#eeeeee"

                    Rectangle {
                        width: parent.width
                        height: 1
                        //    color: settings.down ? "#17a81a" : "#21be2b"
                        anchors.bottom: parent.bottom
                    }
                }
            }

        }
    }

    StackView {
        id: stackView
        initialItem: "HomeForm.qml"
        anchors.fill: parent
    }

}
