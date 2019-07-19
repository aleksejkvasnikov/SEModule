import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
//import QtQuick.Dialogs 1.3
import Qt.labs.platform 1.0
import QtQuick 2.0
import QtCanvas3D 1.0

Page {
    id: page
    //width: 600
    //height: 400
    width: window.width
    height: window.height
    spacing: -6
    transformOrigin: Item.TopLeft

    title: qsTr("Вычисление") + rootItem.emptyString

    Rectangle {
        id: rectangle
        x: 15
        y: 14
        width: window.width-30
        height: (window.height > 600) ? window.height/2.5 : 250

        color: "#cfcfcf"
        radius: 0
        border.width: 1
    }

    RowLayout {
        x: 30
        y: 70
        width: 300
        height: 30

        TextField {
            id: fMin
            Layout.fillWidth: true
            width: parent.width /3
            height: parent.height
            text: modList.fMinVal
            onEditingFinished:
            {
                modList.fMinVal = fMin.text
            }
        }

        TextField {
            id: fMax
            Layout.fillWidth: true
            width: parent.width /3
            height: parent.height
            text: modList.fMaxVal
            onEditingFinished:
            {
                modList.fMaxVal = fMax.text
            }
        }
        TextField {
            id: nPoints
            Layout.fillWidth: true
            width: parent.width /3
            height: parent.height
            text: modList.nPointsVal
            onEditingFinished:
            {
                modList.nPointsVal = nPoints.text
                rootItem.updateStrings()
            }
        }
    }

    RowLayout {
        visible: if(modList.selType === 3) false; else true
        id: justRow
        x: 30
        y: 139
        width: 300
        height: 30
        TextField {
            id: nVal
            Layout.fillWidth: true
            width: parent.width /2
            height: parent.height
            text: modList.nVal
            onEditingFinished:
            {
                modList.nVal = nVal.text
            }
        }

        TextField {
            id: mVal
            Layout.fillWidth: true
            width: parent.width /2
            height: parent.height
            text: modList.mVal
            onEditingFinished:
            {
                modList.mVal = mVal.text
            }
        }
    }
    CheckBox{
        id: fileCheck
        x:235
        text: qsTr("Загрузка из файла") + rootItem.emptyString
        y:189
        checked: modList.fileBool
        onClicked:
        {
            modList.fileBool = fileCheck.checked
            if(fileButton.visible==true) fileButton.visible=false;
            else fileButton.visible=true;
            if(comboBox.visible==true) comboBox.visible=false;
            else comboBox.visible=true;
            if(text10.visible==true) text10.visible=false;
            else text10.visible=true;
        }
    }

    Button{
         id: fileButton
         visible:if(modList.fileBool===false) false; else true;
         x:30
         y:189
         text: qsTr("Выбрать файл") + rootItem.emptyString
         onClicked: fileDialog.open();//
     }
    ComboBox {
        x:150
        y:189
        id: comboBox2
        model: [ "Гц", "МГц", "ГГц" ]
        currentIndex: modList.funcValS
        width: 80
        onCurrentIndexChanged: {
            modList.funcValS = currentIndex;
        }
    }
    FileDialog {
        id: fileDialog
        title: qsTr("Выберите файл") + rootItem.emptyString
        folder: shortcuts.home
        onAccepted: {
            console.log("You chose: " + fileDialog.file)
            var path = fileDialog.file.toString();
            // remove prefixed "file:///"
            path= path.replace(/^(file:\/{3})|(qrc:\/{2})|(http:\/{2})/,"");
            // unescape html codes like '%23' for '#'
            modList.file = decodeURIComponent(path);
            fileDialog.close()
        }
        onRejected: {
            console.log("Canceled")
            fileDialog.close()
        }
       // visible: false
    }
    Text {
        id: text1
        x: 30
        y: 22
        width: 73
        height: 27
        text: qsTr("Источник") + rootItem.emptyString
        font: window.font
    }

    Text {
        id: text2
        x: 374
        y: 25
        anchors.right: parent.right
        anchors.rightMargin: 150
        text: qsTr("Точка наблюдения") + rootItem.emptyString
        font: window.font
    }

    Text {
        id: text3
        x: 132
        y: 50
        text: qsTr("F max") + rootItem.emptyString
        font: window.font
    }

    Text {
        id: text4
        x: 30
        y: 50
        text: qsTr("F min") + rootItem.emptyString
        font: window.font
    }

    Text {
        id: text5
        x: 234
        y: 50
        text: qsTr("Кол-во точек") + rootItem.emptyString
        font: window.font
    }

    Text {
         visible: if(modList.selType === 3) false; else true
        id: text6
        x: 30
        y: 119
        text: qsTr("n")
        font: window.font
    }


    Text {
         visible: if(modList.selType === 3) false; else true
        id: text7
        x: 184
        y: 119
        text: qsTr("m")
        font: window.font
    }

    RowLayout {
        id: rowLayout2
        x: 374
        y: 70
        width: 200
        height: 30
        anchors.right: parent.right
        anchors.rightMargin: 50
        TextField {
            id: pVal
            Layout.fillWidth: true
            width: parent.width /2
            height: parent.height
            text: modList.pVal
            onEditingFinished:
            {
                modList.pVal = pVal.text
            }
        }

        TextField {
            id: pstepVal
            Layout.fillWidth: true
            width: parent.width /2
            height: parent.height
            text: modList.pstepVal
            onEditingFinished:
            {
                modList.pstepVal = pstepVal.text
                rootItem.updateStrings()
            }
        }
    }
    RowLayout {
        id: rowLayout3
        x: 374
        y: 139
        width: 200
        height: 30
        anchors.right: parent.right
        anchors.rightMargin: 50
//[ "Robinson et al.", "Shi et al.", "Po'ad et al.", "Po'ad Plus", "Po'ad multiple", "AKC Standart",
//        "AKC Integral", "Ren et al.", "Dehkhoda et al.", "Nie et al.", "S method", "NIE et al. (waveguide diagrams)", "WAMG et al."]
        ComboBox {
            Layout.fillWidth: true
            id: comboBox
            visible: if(modList.fileBool===false) true; else false;
            model: if(modList.selType === 1){
                       ["Robinson et al.", "Shi et al.", "Po'ad et al.", "Komnatnov M.E.", "Nie et al. (waveguide diagrams)"]
                   }
            else if(modList.selType === 2){
                                   ["Ren et al.", "Dehkhoda et al.", "Nie et al."]
                               }
            else if(modList.selType === 3){
                                   ["Wang et al."]
                               }
            height: parent.height
            currentIndex: modList.funcVal
            width: parent.width
            onCurrentIndexChanged: {
                if(modList.selType === 1){
                                       modList.funcVal = currentIndex;
                                   }
                            else if(modList.selType === 2){
                                                   modList.funcVal = currentIndex+5;
                                               }
                            else if(modList.selType === 3){
                                                   modList.funcVal = currentIndex+8;
                                               }

                rootItem.updateStrings();
            }
        }
    }

    Text {
        id: text8
        //x: 378
        y: 50
        anchors.right: parent.right
        anchors.rightMargin: 240
        text: qsTr("P")
        font: window.font
    }

    Text {
        id: text9
        //x: 483
        y: 50
        anchors.right: parent.right
        anchors.rightMargin: 50
        text: qsTr("Кол-во точек наблюдения") + rootItem.emptyString
        font: window.font
    }

    Text {
        id: text10
        x: 377
        y: 116
        visible: if(modList.fileBool===false) true; else false;
        anchors.right: parent.right
        anchors.rightMargin: 205
        text: qsTr("Функция") + rootItem.emptyString
        font: window.font
    }
    Text {
        id: text11
        x: 374
        y: 186
        anchors.right: parent.right
        anchors.rightMargin: 120
        text: qsTr("Шаг интегрирования") + rootItem.emptyString
        font: window.font
    }
    RowLayout {
        id: rowLayout4
        x: 374
        y: 210
        width: 200
        height: 30
        anchors.right: parent.right
        anchors.rightMargin: 50
        TextField {
            Layout.fillWidth: true
            id: integralVal
            width: parent.width /2
            height: parent.height
            text: modList.integralVal
            onEditingFinished:
            {
                modList.integralVal = integralVal.text
            }
        }
        CheckBox {
            id: rungeVal
            text: qsTr("Правило Рунге") + rootItem.emptyString
            checked: modList.RungeVal
            onClicked:
            {
                 if(integralVal.visible) integralVal.visible = false
                 else integralVal.visible = true
                 modList.RungeVal = rungeVal.checked
            }
        }
    }

}
