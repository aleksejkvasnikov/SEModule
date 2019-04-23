import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtCanvas3D 1.1
import QtQuick 2.0
import QtCanvas3D 1.1
Page {
    property int val2dor3d: 1
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
            implicitHeight: 25
            Layout.fillWidth: true
            width: parent.width /2
            height: parent.height
            text: modList.rVal
            onEditingFinished:
            {
                modList.rVal = rTf.text
                imageCube.radius=rTf.text*100*5
                imageCube.callme()
            }
        }
        TextField {
            id: hTf
            implicitHeight: 25
            Layout.fillWidth: true
            width: parent.width /2
            height: parent.height
            text: modList.hVal
            onEditingFinished:
            {
                modList.hVal = hTf.text
                imageCube.cylHeight=hTf.text*100*5
                imageCube.callme()
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
            implicitHeight: 25
            Layout.fillWidth: true
            width: parent.width /3
            height: parent.height
            text: modList.aVal
            onEditingFinished:
            {
                modList.aVal = aTf.text
                imageCube.aa=aTf.text*100*5
                imageCube.callme()
            }
        }

        TextField {
            implicitHeight: 25
            id: bTf
            Layout.fillWidth: true
            width: parent.width /3
            height: parent.height
            text: modList.bVal
            onEditingFinished:
            {
                modList.bVal = bTf.text
                imageCube.bb=bTf.text*100*5
                imageCube.callme()
            }
        }
        TextField {
            id: dTf
            implicitHeight: 25
            Layout.fillWidth: true
            width: parent.width /3
            height: parent.height
            text: modList.dVal
            onEditingFinished:
            {
                modList.dVal = dTf.text
                imageCube.dd=dTf.text*100*5
                imageCube.callme()
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
            Layout.fillWidth: true
            implicitHeight: 25
            width: parent.width /2
            height: parent.height
            text: modList.tVal
            onEditingFinished:
            {
                imageCube.t=tTf.text*100*5
                imageCube.callme()
                modList.tVal = tTf.text
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
        y: 235
        width: 240
        height: 30
        visible : if (val2dor3d==3) true; else false;
        TextField {
            id: apTf
            implicitHeight: 25
            Layout.fillWidth: true
            width: parent.width
            height: parent.height
            text: modList.apVal
            onEditingFinished:
            {
                imageCube.apRadius=apTf.text*100*5
                imageCube.callme()
                modList.apVal = apTf.text
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
            implicitHeight: 25
            Layout.fillWidth: true
            width: parent.width /2
            height: parent.height
            text: modList.wVal
            onEditingFinished:
            {
                imageCube.w=wTf.text*100*5
                imageCube.callme()
                modList.wVal = wTf.text
            }
        }

        TextField {
            id: lTf
            implicitHeight: 25
            Layout.fillWidth: true
            width: parent.width /2
            height: parent.height
            text: modList.lVal
            onEditingFinished:
            {
                imageCube.l=lTf.text*100*5
                imageCube.callme()
                modList.lVal = lTf.text
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
            implicitHeight: 25
            Layout.fillWidth: true
            width: parent.width /2
            height: parent.height
            text: modList.xVal
            onEditingFinished:
            {
                imageCube.xx=xTf.text*100*5
                imageCube.callme()
                modList.xVal = xTf.text
            }
        }

        TextField {
            id: yTf
            implicitHeight: 25
            Layout.fillWidth: true
            width: parent.width /2
            height: parent.height
            text: modList.yVal
            onEditingFinished:
            {
                imageCube.yy=yTf.text*100*5
                imageCube.callme()
                modList.yVal = yTf.text
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
            implicitHeight: 25
            Layout.fillWidth: true
            width: parent.width /2
            height: parent.height
            text: modList.mapVal
            onEditingFinished:
            {
                imageCube.map=mapTf.text
                imageCube.callme()
                modList.mapVal = mapTf.text
            }
        }
        TextField {
            id: napTf
            implicitHeight: 25
            Layout.fillWidth: true
            width: parent.width /2
            height: parent.height
            text: modList.napVal
            onEditingFinished:
            {
                imageCube.nap=napTf.text
                imageCube.callme()
                modList.napVal = napTf.text
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
            implicitHeight: 25
            Layout.fillWidth: true
            width: parent.width /2
            height: parent.height
            text: modList.dhVal
            onEditingFinished:
            {
                imageCube.dh=dhTf.text*100*5
                imageCube.callme()
                modList.dhVal = dhTf.text
            }
        }

        TextField {
            id: dvTf
            implicitHeight: 25
            Layout.fillWidth: true
            width: parent.width /2
            height: parent.height
            text: modList.dvVal
            onEditingFinished:
            {
                imageCube.dv=dvTf.text*100*5
                imageCube.callme()
                modList.dvVal = dvTf.text
            }
        }
    }
    Text {
        id: text8
        x: 30
        y: 230
        visible : if (val2dor3d==3) false; else true;
        text: qsTr("Ширина")
        font: window.font
    }

    Text {
        id: text9
        x: 184
        y: 230
        visible : if (val2dor3d==3) false; else true;
        text: qsTr("Высота")
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
        cylHeight: hTf.text*100*5
        //! [0]
        angleOffset: -180 / 8.0
        backgroundColor: "#FCFCFC"
        state: "image1"
        image1: "qrc:/devices.png"
    }
}

