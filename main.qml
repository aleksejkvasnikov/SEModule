import QtQuick 2.11
import QtQuick.Controls 2.4
import Qt.labs.platform 1.0 as Lab
import QtQuick.Layouts 1.11
ApplicationWindow {
    property color firstColor
    property color secondColor
    property int currentID: 1;
    id: window
    flags: Qt.FramelessWindowHint|Qt.Window
    visible: true
    width: 740
    height: 530
    title: qsTr("3D SE box") + " v1.2" + rootItem.emptyString
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
           // stackView.push("modeling.qml")
        }
        running: true
    }
    Dialog {
     //   visible: true
        id: messageDial
        x: window.width * 0.3
        y: window.height * 0.3
        width: window.width * 0.4
        height:  window.height * 0.4
        modal: true
        focus: true
        title: qsTr("Предупреждение!")+ rootItem.emptyString
        standardButtons: Dialog.Ok | Dialog.Cancel
        Label {
            text: qsTr("\tПревышен лимит итераций. \nЗапуск вычислений может привести к ошибке в работе программы.")+ rootItem.emptyString
        }
        onAccepted: {
            stackView.push("HomeForm.qml")
            nextbut.visible = false
            too1lButton2d.visible = true
            currentID++;
        }
        onRejected: console.log("Cancel clicked")

    }
    Popup {
        id: rect
        width: window.width
        height: window.height
        contentItem: Row {
            anchors.fill: parent
            Text {
                id: text1s
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                text: "3D SE Box"
                font.family: "Arial"
                font.pointSize: 50
                color: "yellow"
            }
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "TALGAT team (talgat.org)"
                font.family: "Arial"
                font.pointSize: 20
                color: "yellow"
                anchors.topMargin: window.height / 3
                anchors.top: text1s.bottom
            }
        }
        background: Rectangle {
                implicitWidth: window.width
                implicitHeight: window.height
                color: 'black'
                border.color: "#444"
            }
        visible: opacity > 0
    }

    SequentialAnimation {
        running: true
        PauseAnimation {
            duration: 2000 // Wait for 4000ms
        }
        NumberAnimation {
            target: rect
            property: 'opacity'
            to: 0
            duration: 1000 // Then fade away for 1000ms
        }
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
            text: qsTr("О программе - SE box v1.2") + rootItem.emptyString
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
            text: qsTr("email: aleksejkvasnikov@gmail.com\n Благодарности: Simon Raguin, Thomas Chevrie\n\n https://github.com/aleksejkvasnikov/SEModule")
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
        //    text: stackView.depth > 1 ? "\u2A37" : "\u2630"
            text: "\u25C0"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                if (currentID == 2) {
                    stackView.push("modeling.qml")
                    currentID--;
                }
                else if (currentID == 3) {
                    stackView.push("calculating.qml")
                    too1lButton2d.visible = false
                    currentID--;
                    nextbut.visible = true
                    //stackView.pop()
                    //drawer.open()
                }
                else if (currentID == 4) {
                    stackView.push("HomeForm.qml")
                    currentID--;
                    //stackView.pop()
                    //drawer.open()
                }
            }
        }
        Button {
            id: aboutButton
            x: 153
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
            x: 46
            y: 0
            width: 39
            height: 40
            text: "⚙"
            anchors.rightMargin: 0
            anchors.right: window.right
            // anchors.rightMargin: -639
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked:
            {
                if(currentID !=4){
                    currentID++;
                    stackView.push("settings.qml")
                }
            }
        }
        ToolButton {
            x: 123
            y: 0
            width: 39
            height: 40
            id: too1lButton
            text: "\u25B6"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                if (currentID == 1) {
                    stackView.push("calculating.qml")
                    currentID++;
                }
                else if (currentID == 2) {
                    stackView.push("HomeForm.qml")
                    too1lButton2d.visible = true
                    nextbut.visible = false
                    currentID++;
                    //stackView.pop()
                    //drawer.open()
                }
            }
        }
        ToolButton {
            x: 183
            y: 0
            width: 39
            height: 40
            visible:false
            id: too1lButton2d
            text: "2D"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                if (currentID == 3) {
                    stackView.push("results.qml")
                    currentID++;
                }
            }
        }
        ToolButton {
            x: 85
            y: 0
            width: 39
            height: 40
            id: too1lButtonsaveload
            text: "☰"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                if (currentID == 3) {
                   // stackView.push("results.qml")
                    currentID++;
                }
            }
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
    Lab.FileDialog {
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
                onClicked: {
                    menu.open()
                }
                Menu {
                    id: menu
                    y: file.height
                    width: window.width/5
                    MenuItem {
                        text: qsTr("Новый") + rootItem.emptyString
                        onClicked: {
                             modList.removeallItems();
                        }
                    }
                    MenuItem {
                        text: qsTr("Открыть") + rootItem.emptyString

                    }
                    MenuItem {
                        text: qsTr("Сохранить") + rootItem.emptyString
                        onClicked: {
                            folderDialog.open()
                        }
                    }
                }

                contentItem: Text {
                    rightPadding: file.spacing
                    text: file.text
                    font: file.font
                    // color: file.enabled ? (file.down ? "#17a81a" : "#21be2b") : "#bdbebf"
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

    footer:

        Column {
        Row{
            spacing: 3
            anchors.right: parent.right;
            anchors.rightMargin: 10
            Button{
                visible:{
                 if (currentID==1) false;
                 else true;
                }

                text: {
                    if (currentID==3)  qsTr("Задать параметры") + rootItem.emptyString;
                    else qsTr("Задать геометрию") + rootItem.emptyString;
                }
                onClicked:
                {
                    if (currentID == 3) {
                        stackView.push("calculating.qml")
                        nextbut.visible = true
                        too1lButton2d.visible = false
                        currentID--;
                    }
                    else if (currentID == 2) {
                        stackView.push("modeling.qml")
                        nextbut.visible = true
                        currentID--;

                    }

                }
            }

            Button{
                id: nextbut
                text:{
                 if (currentID==1)  qsTr("Задать параметры") + rootItem.emptyString;
                 else qsTr("Вычислить") + rootItem.emptyString;
                }
                onClicked:
                {
                    if (currentID == 1) {
                        stackView.push("calculating.qml")
                        currentID++;
                    }
                    else if (currentID == 2) {
                        console.log(colorSlider.color)
                        if(colorSlider.color == "#ff0000") {
                            messageDial.open();
                        }
                            else {
                            stackView.push("HomeForm.qml")
                            nextbut.visible = false
                            too1lButton2d.visible = true
                            currentID++;
                        }
                        //stackView.pop()
                        //drawer.open()
                    }
                }
            }
        }
        Text {
            text: {
                if (modList.funcVal===0) qsTr("Ожидаемое время выполнения (с): ") + ((100/modList.pstepVal) * modList.nPointsVal) / 1000000  +  rootItem.emptyString;
                else if (modList.funcVal===1) qsTr("Ожидаемое время выполнения (с): ") + (1000*(100/modList.pstepVal) * modList.nPointsVal) / 2000000 +  rootItem.emptyString;
                else if (modList.funcVal===2)  qsTr("Ожидаемое время выполнения (с): ") + (2*(100/modList.pstepVal) * modList.nPointsVal) / 1000000 +  rootItem.emptyString;
                else if (modList.funcVal===3) qsTr("Ожидаемое время выполнения (с): ") + (3*(100/modList.pstepVal) * modList.nPointsVal) / 1000000 + rootItem.emptyString;
                else if (modList.funcVal===4) qsTr("Ожидаемое время выполнения (с): ") + (3*(100/modList.pstepVal) * modList.nPointsVal) / 1000000 +  rootItem.emptyString;
                else if (modList.funcVal===5) qsTr("Ожидаемое время выполнения (с): ") + ((100/modList.pstepVal) * modList.nPointsVal) / 1000000  +  rootItem.emptyString;
                else if (modList.funcVal===6) qsTr("Ожидаемое время выполнения (с): ") + (3*(100/modList.pstepVal) * modList.nPointsVal) / 1000000 +  rootItem.emptyString;
                else if (modList.funcVal===7) qsTr("Ожидаемое время выполнения (с): ") + (10*(100/modList.pstepVal) * modList.nPointsVal) / 1000000  +  rootItem.emptyString;
                else if (modList.funcVal===8) qsTr("Ожидаемое время выполнения (с): ") + (14*(100/modList.pstepVal) * modList.nPointsVal) / 1000000   +  rootItem.emptyString;
                else if (modList.funcVal===9) qsTr("Ожидаемое время выполнения (с): ") + (10*(100/modList.pstepVal) * modList.nPointsVal) / 1000000   +  rootItem.emptyString;
            }
        }
        Text {
            text:  qsTr("Объем требуемой памяти (МБ): ") + Math.round(((((100/modList.pstepVal) * modList.nPointsVal)*3*8)/1024)/1024 + (((100/modList.pstepVal) * modList.nPointsVal)*3)/1024 + 50) + rootItem.emptyString
        }
        Row{
        Text {
            text:  qsTr("Сложность вычислений: ") +  rootItem.emptyString
        }
        ProgressBar {
            id: control
            value: {
                if (modList.funcVal===0) ((100/modList.pstepVal) * modList.nPointsVal) / 10000000 +  rootItem.emptyString;
                else if (modList.funcVal===1) (1000*(100/modList.pstepVal) * modList.nPointsVal) / 20000000  +  rootItem.emptyString;
                else if (modList.funcVal===2) (2*(100/modList.pstepVal) * modList.nPointsVal) / 10000000  +  rootItem.emptyString;
                else if (modList.funcVal===3) (3*(100/modList.pstepVal) * modList.nPointsVal) / 10000000 +  rootItem.emptyString;
                else if (modList.funcVal===4) (3*(100/modList.pstepVal) * modList.nPointsVal) / 10000000 +  rootItem.emptyString;
                else if (modList.funcVal===5) ((100/modList.pstepVal) * modList.nPointsVal) / 10000000 +  rootItem.emptyString;
                else if (modList.funcVal===6) (3*(100/modList.pstepVal) * modList.nPointsVal) / 10000000  +  rootItem.emptyString;
                else if (modList.funcVal===7) (10*(100/modList.pstepVal) * modList.nPointsVal) / 10000000  +  rootItem.emptyString;
                else if (modList.funcVal===8) (14*(100/modList.pstepVal) * modList.nPointsVal) / 10000000   +  rootItem.emptyString;
                else if (modList.funcVal===9) (10*(100/modList.pstepVal) * modList.nPointsVal) / 10000000   +  rootItem.emptyString;

            }
            padding: 2

            background: Rectangle {
                implicitWidth: window.width
                implicitHeight: 6
                color: "#e6e6e6"
                radius: 3
            }

            contentItem: Item {
                implicitWidth: window.width * 0.7
                implicitHeight: 4

                Rectangle {
                    id: colorSlider
                    width: control.visualPosition * parent.width
                    height: parent.height
                    radius: 2
                    color: {
                        if (control.value>0.7) "red"; else if (control.value<=0.6 && control.value>0.4 ) "yellow"; else "green"
                    }
                }
            }
        }
        }
    }
    StackView {
        id: stackView
          initialItem: "modeling.qml"
      //  initialItem: "HomeForm.qml"
        anchors.fill: parent

    }

}
