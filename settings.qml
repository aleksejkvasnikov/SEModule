import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3

Page {
    id: page2
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
        FontDialog {
            id: fontDialog
            title: qsTr("Выберите шрифт") + rootItem.emptyString
            font: Qt.font({ family: "Arial", pointSize: 24, weight: Font.Normal })
            onAccepted: {
                console.log("You chose: " + fontDialog.font)
                window.font = fontDialog.font
                //Qt.quit()
            }
            onRejected: {
                console.log("Canceled")
               // Qt.quit()
            }
           // Component.onCompleted: visible = true
        }

        RowLayout {
            anchors.topMargin: 10
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            Button {

                id: control
                text: qsTr("Шрифт") + rootItem.emptyString
                Layout.fillWidth: true
                contentItem: Text {
                    text: control.text
                    font: control.font
                    opacity: enabled ? 1.0 : 0.3
                    color: control.down ? "#17a81a" : "#000"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }
                onClicked: {
                    fontDialog.visible = true;
                }

                background: Rectangle {
                    implicitWidth: window.width/10
                    implicitHeight: window.width/20
                    opacity: enabled ? 1 : 0.3
                    border.color: control.down ? "#17a81a" : "#000"
                    border.width: 1
                    radius: 2
                }
            }
            Image {
                source: "en.svg"
                Layout.preferredWidth: window.width/17
                Layout.preferredHeight: window.width/17
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                       // console.log(modList.locale)
                        rootItem.selectLanguage("en_US")
                        rootItem.selectLocale("en_US")
                        rootItem.fontVal = 1
                       // modList.locale= "en_US"
                      //  modList.updatelocale("en_US")
                       // modList.locale= "en_US"
                    }
                }
            }
            Image {
                source: "ru.svg"
                Layout.preferredWidth: window.width/17
                Layout.preferredHeight: window.width/17
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                     //   console.log(modList.locale)
                        rootItem.selectLanguage("ru_RU")
                        rootItem.selectLocale("ru_RU")
                        rootItem.fontVal = 0
                     //   modList.updatelocale("ru_RU")
                     //   modList.locale= "ru_RU"
                    }
                }
            }

            Image {
                source: "ru.svg"
                Layout.preferredWidth: window.width/17
                Layout.preferredHeight: window.width/17
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                     //   console.log(modList.locale)
                        rootItem.selectLanguage("fr_FR")
                        rootItem.selectLocale("fr_FR")
                        rootItem.fontVal = 0
                     //   modList.updatelocale("ru_RU")
                     //   modList.locale= "ru_RU"
                    }
                }
            }

            /*
            Image {
                source: "fr.svg"
                Layout.preferredWidth: window.width/17
                Layout.preferredHeight: window.width/17
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                     //   console.log(modList.locale)
                        rootItem.selectLanguage("fr_FR")
                        rootItem.selectLocale("fr_FR")
                        rootItem.fontVal = 0
                     //   modList.updatelocale("ru_RU")
                     //   modList.locale= "ru_RU"
                    }
                }
            }*/

            /*
            Image {
             id: image
             source: "fr.jpg"
             Layout.preferredWidth: window.width/17
             Layout.preferredHeight: window.width/17
             MouseArea {
                 anchors.fill: parent
                 onClicked: {
                  //   console.log(modList.locale)
                     rootItem.selectLanguage("fr_FR")
                     rootItem.selectLocale("fr_FR")
                     rootItem.fontVal = 0
                  //   modList.updatelocale("ru_RU")
                  //   modList.locale= "ru_RU"
                            }
                }
            } */
        }
    }
}
