import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtCanvas3D 1.1
import QtQuick 2.0
import QtCanvas3D 1.1
import QtQuick.Controls.Styles 1.4
Page {
    property int val2dor3d: modList.selType
    id: page
    width: window.width
    height: window.height
    spacing: -6
    transformOrigin: Item.TopLeft
    title: qsTr("Моделирование") + rootItem.emptyString
    Rectangle {
        id: rectangle
        x: 15
        y: 14
        width: 250
        height: 80
        color: "#cfcfcf"
        radius: 0
        border.width: 1
        RowLayout{
            anchors.fill: parent
            spacing: 0
            Image {
                id: image
                Layout.leftMargin: 5
                Layout.maximumWidth: rectangle.width/3
                source: (val2dor3d!=1) ? "single_activated.png" : "single.png"
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if(val2dor3d!=1){
                            val2dor3d = 1;
                            modList.selType = 1;
                            imageCube.sometype = 0;
                            imageCube.arrayMode(0);
                        }
                    }
                }
            }
            Image {
                id: image2
                Layout.maximumWidth: rectangle.width/3
                source: (val2dor3d!=2) ? "array_activated.png" : "array.png"
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        if(val2dor3d!=2){
                            val2dor3d = 2;
                            modList.selType = 2;
                            imageCube.sometype = 1;
                            imageCube.arrayMode(1);
                        }
                    }
                }
            }
            Image {
                id: image3
                Layout.maximumWidth: rectangle.width/3
                Layout.rightMargin: 20
                source: (val2dor3d!=3) ? "cylinder_activated.png" : "cylinder.png"
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        if(val2dor3d!=3){
                            val2dor3d = 3;
                            modList.selType = 3;
                            imageCube.sometype = 2;
                            imageCube.arrayMode(2);
                        }
                    }
                }
            }
        }
    }
    Rectangle {
        id: rectangle2
        x: 15
        y: 104
        width: 250
        height: 100
        color: "#cfcfcf"
        radius: 0
        border.width: 1
    }
    Rectangle {
        id: rectangle3
        x: 15
        y: 214
        width: 250
        height: if(val2dor3d===1) 110
        else if(val2dor3d===2) 155
        else if(val2dor3d===3) 65
        color: "#cfcfcf"
        radius: 0
        border.width: 1
    }

    RowLayout {
        x: 20
        y: 129
        width: 240
        height: 30
        visible : if (val2dor3d==3) true; else false;
        TextField {
            id: rTf
            text: modList.rVal
            onEditingFinished:
            {
                modList.rVal = rTf.text
                imageCube.radius=rTf.text*100*5
                imageCube.callme()
            }
            background: Rectangle {
                Layout.fillWidth: true
                implicitHeight: 25
                implicitWidth: rowLayout2.width / 2 - 5
                color: rTf.enabled ? "transparent" : "#353637"
                border.color: (rTf.text >0 && rTf.text > apTf.text) ? "#21be2b" : "red"
            }
        }
        TextField {
            id: hTf
            text: modList.hVal
            onEditingFinished:
            {
                modList.hVal = hTf.text
                imageCube.cylHeight=hTf.text*100*5
                imageCube.callme()
            }
            background: Rectangle {
                Layout.fillWidth: true
                implicitHeight: 25
                implicitWidth: rowLayout2.width / 2 - 5
                color: hTf.enabled ? "transparent" : "#353637"
                border.color: (hTf.text >0) ? "#21be2b" : "red"
            }
        }
    }
    RowLayout {
        x: 20
        y: 129
        width: 240
        height: 30
        visible : if (val2dor3d==3) false; else true;
        TextField {
            id: aTf
            text: modList.aVal
            onEditingFinished:
            {
                modList.aVal = aTf.text
                imageCube.aa=aTf.text*100*5
                imageCube.callme()
            }
            background: Rectangle {
                Layout.fillWidth: true
                implicitHeight: 25
                implicitWidth: rowLayout5.width/3-5
                color: aTf.enabled ? "transparent" : "#353637"
                border.color: (aTf.text >0) ? "#21be2b" : "red"
            }
        }

        TextField {
            id: bTf
            text: modList.bVal
            onEditingFinished:
            {
                modList.bVal = bTf.text
                imageCube.bb=bTf.text*100*5
                imageCube.callme()
            }
            background: Rectangle {
                Layout.fillWidth: true
                implicitHeight: 25
                implicitWidth: rowLayout5.width/3-5
                color: bTf.enabled ? "transparent" : "#353637"
                border.color: (bTf.text >0) ? "#21be2b" : "red"
            }
        }
        TextField {
            id: dTf
            text: modList.dVal
            onEditingFinished:
            {
                modList.dVal = dTf.text
                imageCube.dd=dTf.text*100*5
                imageCube.callme()
            }
            background: Rectangle {
                Layout.fillWidth: true
                implicitHeight: 25
                implicitWidth: rowLayout5.width/3-5
                color: dTf.enabled ? "transparent" : "#353637"
                border.color: (dTf.text >0) ? "#21be2b" : "red"
            }
        }
    }

    RowLayout {
        id: rowLayout1
        x: 20
        y: 164
        width: 240
        height: 30
        TextField {
            id: tTf
            text: modList.tVal
            onEditingFinished:
            {
                modList.tVal = tTf.text
                imageCube.t=tTf.text*100*5
                imageCube.callme()               
            }
            background: Rectangle {
                Layout.fillWidth: true
                implicitHeight: 25
                implicitWidth: rowLayout5.width-5
                color: tTf.enabled ? "transparent" : "#353637"
                border.color: (tTf.text >0) ? "#21be2b" : "red"
            }
        }

        TextField {
            id: sigmaTf
            visible: false
            implicitHeight: 25
            Layout.fillWidth: true
            width: parent.width /2
            height: parent.height
            text: modList.sigmaVal
            onEditingFinished:
            {
                modList.sigmaVal = sigmaTf.text
            }
        }
    }


    Text {
        id: text1
        x: 30
        y: 106
        width: 73
        height: 27
        text: qsTr("Корпус  (величины указаны в метрах)") + rootItem.emptyString
         font: window.font
    }

    Text {
        id: text2
        x: 30
        y: 215
        text: qsTr("Апертура") + rootItem.emptyString
         font: window.font
    }

    Text {
        visible : if (val2dor3d==3) false; else true;
        id: text3
        x: 132
        y: 117
        text: qsTr("b")
         font: window.font
    }

    Text {
        visible : if (val2dor3d==3) false; else true;
        id: text4
        x: 30
        y: 117
        text: qsTr("a")
        font: window.font
    }

    Text {
        visible : if (val2dor3d==3) false; else true;
        id: text5
        x: 234
        y: 117
        text: qsTr("d")
         font: window.font
    }
    Text {
        visible : if (val2dor3d==3) true; else false;
        id: textR
        x: 30
        y: 117
        text: qsTr("r")
        font: window.font
    }

    Text {
        visible : if (val2dor3d==3) true; else false;
        id: textH
        x: 234
        y: 117
        text: qsTr("h")
         font: window.font
    }
    Text {
        id: text6
        x: 30
        y: 156
        text: qsTr("Толщина")
         font: window.font
    }


    Text {
        id: text7
        x: 184
        y: 156
        visible: false
        text: qsTr("σ (С/м)")
         font: window.font
    }
    Text {
        id: textAp
        x: 30
        y: 230
        visible: if (val2dor3d==3) true; else false;
        text: qsTr("Радиус")
         font: window.font
    }
    CheckBox {
        id: opacId
        x: 30
        y: 352
        visible: false
        text: qsTr("Прозрачность")
        checked: false
        onCheckStateChanged:{
            imageCube.enableWire();
        }
    }
    RowLayout {
        id: rowLayout3
        x: 20
        y: 240
        width: 240
        height: 30
        visible : if (val2dor3d==3) true; else false;
        TextField {
            id: apTf
            text: modList.apVal
            onEditingFinished:
            {
                modList.apVal = apTf.text
                imageCube.apRadius=apTf.text*100*5
                imageCube.callme()               
            }
            background: Rectangle {
                Layout.fillWidth: true
                implicitHeight: 25
                implicitWidth: rowLayout2.width - 5
                color: apTf.enabled ? "transparent" : "#353637"
                border.color: (apTf.text >0 && apTf.text < rTf.text) ? "#21be2b" : "red"
            }
        }
    }
    RowLayout {
        id: rowLayout2
        x: 20
        y: 240
        width: 240
        height: 30
        visible : if (val2dor3d==3) false; else true;
        TextField {
            id: wTf
            text: modList.wVal
            onEditingFinished:
            {
                modList.wVal = wTf.text
                imageCube.w=wTf.text*100*5
                imageCube.callme()
            }
            background: Rectangle {
                Layout.fillWidth: true
                implicitHeight: 25
                implicitWidth: rowLayout2.width/2 - 5
                color: wTf.enabled ? "transparent" : "#353637"
                border.color: wTf.text > 0 && wTf.text < dvTf.text && ((napTf.text >1 && (napTf.text-1)*dvTf.text+wTf.text < bTf.text) || (napTf.text==="1" && wTf.text < bTf.text)) ? "#21be2b" : "red"
            }
        }

        TextField {
            id: lTf
            text: modList.lVal
            onEditingFinished:
            {
                modList.lVal = lTf.text
                imageCube.l=lTf.text*100*5
                imageCube.callme()
            }
            background: Rectangle {
                Layout.fillWidth: true
                implicitHeight: 25
                implicitWidth: rowLayout2.width/2 - 5
                color: lTf.enabled ? "transparent" : "#353637"
                border.color: lTf.text > 0 && lTf.text < dhTf.text && ((mapTf.text >1 && (mapTf.text-1)*dhTf.text+lTf.text < aTf.text) || (mapTf.text==="1" && lTf.text < aTf.text)) ? "#21be2b" : "red"
            }
        }
    }
    RowLayout {
        id: rowLayout5
        x: 20
        y: 290
        width: 240
        height: 30
        visible : if (val2dor3d==1) true; else false;
        TextField {
            id: xTf
            text: modList.xVal
            onEditingFinished:
            {
                modList.xVal = xTf.text
                imageCube.xx=xTf.text*100*5
                imageCube.callme()
            }
            background: Rectangle {
                Layout.fillWidth: true
                implicitHeight: 25
                implicitWidth: rowLayout5.width/2-5
                color: xTf.enabled ? "transparent" : "#353637"
                border.color: (xTf.text >0 && xTf.text < aTf.text) ? "#21be2b" : "red"
            }
        }

        TextField {
            id: yTf
            text: modList.yVal
            onEditingFinished:
            {
                modList.yVal = yTf.text
                imageCube.yy=yTf.text*100*5
                imageCube.callme()
            }
            background: Rectangle {
                Layout.fillWidth: true
                implicitHeight: 25
                implicitWidth: rowLayout5.width/2 -5
                color: yTf.enabled ? "transparent" : "#353637"
                border.color: (yTf.text >0 && yTf.text < bTf.text) ? "#21be2b" : "red"
            }
        }
    }
    RowLayout {
        id: rowLayout4
        x: 20
        y: 336
        width: 240
        height: 30
        visible:{
            if (val2dor3d==2) true; else false;
        }
        TextField {
            id: mapTf
            text: modList.mapVal
            onEditingFinished:
            {
                modList.mapVal = mapTf.text
                imageCube.map=mapTf.text
                imageCube.callme()
            }
            background: Rectangle {
                Layout.fillWidth: true
                implicitHeight: 25
                implicitWidth: rowLayout5.width/2 -5
                color: mapTf.enabled ? "transparent" : "#353637"
                border.color: ((mapTf.text >1 && (mapTf.text-1)*dhTf.text+lTf.text < aTf.text) || (mapTf.text==="1" && lTf.text < aTf.text)) ? "#21be2b" : "red"
            }
        }
        TextField {
            id: napTf
            text: modList.napVal
            onEditingFinished:
            {
                modList.napVal = napTf.text
                imageCube.nap=napTf.text
                imageCube.callme()
            }
            background: Rectangle {
                Layout.fillWidth: true
                implicitHeight: 25
                implicitWidth: rowLayout5.width/2 -5
                color: napTf.enabled ? "transparent" : "#353637"
                border.color: ((napTf.text >1 && (napTf.text-1)*dvTf.text+wTf.text < bTf.text) || (napTf.text==="1" && wTf.text < bTf.text)) ? "#21be2b" : "red"
            }
        }
    }
    RowLayout {
        id: rowLayout55
        x: 20
        y: 290
        width: 240
        visible:{
            if (val2dor3d==2) true; else false;
        }

        height: 30
        TextField {
            id: dhTf
            text: modList.dhVal
            onEditingFinished:
            {
                modList.dhVal = dhTf.text
                imageCube.dh=dhTf.text*100*5
                imageCube.callme()
            }
            background: Rectangle {
                Layout.fillWidth: true
                implicitHeight: 25
                implicitWidth: rowLayout5.width/2 -5
                color: mapTf.enabled ? "transparent" : "#353637"
                border.color: lTf.text < dhTf.text && ((mapTf.text >1 && (mapTf.text-1)*dhTf.text+lTf.text < aTf.text) || (mapTf.text==="1")) ? "#21be2b" : "red"
            }
        }

        TextField {
            id: dvTf
            text: modList.dvVal
            onEditingFinished:
            {
                modList.dvVal = dvTf.text
                imageCube.dv=dvTf.text*100*5
                imageCube.callme()
            }
            background: Rectangle {
                Layout.fillWidth: true
                implicitHeight: 25
                implicitWidth: rowLayout5.width/2 -5
                color: dvTf.enabled ? "transparent" : "#353637"
                border.color: wTf.text < dvTf.text && ((napTf.text >1 && (napTf.text-1)*dvTf.text+wTf.text < bTf.text)|| (napTf.text==="1"))  ? "#21be2b" : "red"
            }
        }
    }
    Text {
        id: text8
        x: 30
        y: 230
        visible : if (val2dor3d==3) false; else true;
        text: qsTr("Высота")
        font: window.font
    }

    Text {
        id: text9
        x: 184
        y: 230
        visible : if (val2dor3d==3) false; else true;
        text: qsTr("Ширина")
        font: window.font
    }
    Text {
        id: positionText
        x: 30
        y: 270
        anchors.rightMargin: 240
        text: qsTr("Расположение")
        visible:{
            if (val2dor3d==1) true; else false;
        }
         font: window.font
    }
    Text {
        id: dhdvText
        x: 30
        y: 270
        anchors.rightMargin: 240
        text: qsTr("Расстояние между центрами апертур")
        visible:{
            if (val2dor3d==2) true; else false;
        }
         font: window.font
    }
    Text {
        id: mapnapText
        x: 30
        y: 316
        anchors.rightMargin: 240
        text: qsTr("Количество апертур")
        visible:{
            if (val2dor3d==2) true; else false;
        }
         font: window.font
    }
    Text {
        id: text10
        x: 30
        y: 280
        anchors.rightMargin: 240
        text: qsTr("X")
        visible:{
            if (val2dor3d==1) true; else false;
        }
         font: window.font
    }

    Text {
        id: text11
        x: 184
        y: 280
        text: qsTr("Y")
        visible:{
            if (val2dor3d==1) true; else false;
        }
         font: window.font
    }
    Text {
        id: text12
        x: 30
        y: 326
        visible:{
            if (val2dor3d==2) true; else false;
        }
        text: qsTr("Гор.")
        font: window.font
    }

    Text {
        id: text13
        x: 184
        visible:{
            if (val2dor3d==2) true; else false;
        }
        y: 326
        text: qsTr("Верт.")
         font: window.font
    }
    Text {
        id: text14
        x: 29
        visible:{
            if (val2dor3d==2) true; else false;
        }
        y: 280
        text: qsTr("Гор.")
         font: window.font
    }

    Text {
        id: text15
        x: 184
        visible:{
            if (val2dor3d==2) true; else false;
        }
        y: 280
        text: qsTr("Верт.")
        font: window.font
    }
    ImageCube {
        id: imageCube
        width: parent.width-rectangle.width
        height: parent.height
        anchors.left: rectangle.right
        aa: aTf.text*100*5
        bb: bTf.text*100*5
        dd: dTf.text*100*5
        t: tTf.text*100*5
        w: wTf.text*100*5
        l: lTf.text*100*5
        xx: xTf.text*100*5
        yy: yTf.text*100*5
        map: mapTf.text*1
        nap: napTf.text*1
        dh: dhTf.text*100*5
        dv: dvTf.text*100*5
        apRadius: apTf.text*100*5
        radius: rTf.text*100*5
        sometype: val2dor3d-1
        cylHeight: hTf.text*100*5
        //! [0]
        angleOffset: -180 / 8.0
        backgroundColor: "#FCFCFC"
        state: "image1"
        image1: "qrc:/devices.png"
    }
}

