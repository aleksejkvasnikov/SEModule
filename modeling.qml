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
        width: window.width-30
        height: (window.height > 600) ? window.height/3 : 200
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
        x: 30
        y: 120
        width: 300
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
        y: 22
        width: 73
        height: 27
        text: qsTr("Корпус  (величины указаны в метрах)") + rootItem.emptyString
         font: window.font
    }

    Text {
        id: text2
        x: 374
        y: 25
        anchors.right: parent.right
        anchors.rightMargin: 205
        text: qsTr("Апертура") + rootItem.emptyString
         font: window.font
    }

    Text {
        id: text3
        x: 132
        y: 50
        text: qsTr("b")
         font: window.font
    }

    Text {
        id: text4
        x: 30
        y: 50
        text: qsTr("a")
        font: window.font
    }

    Text {
        id: text5
        x: 234
        y: 50
        text: qsTr("d")
         font: window.font
    }

    Text {
        id: text6
        x: 30
        y: 100
        text: qsTr("t")
         font: window.font
    }


    Text {
        id: text7
        x: 184
        y: 100
        text: qsTr("σ (С/м)")
         font: window.font
    }
    CheckBox {
        id: opacId
        x: 330
        y: 65
        text: qsTr("Прозрачность")
        checked: false
        onCheckStateChanged:{
            imageCube.enableWire();
        }
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
        id: rowLayout3
        x: 374
        y: 120
        width: 200
        height: 30
        anchors.right: parent.right
        anchors.rightMargin: 50
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
        x: 374
        y: 170
        width: 200
        height: 30
        anchors.right: parent.right
        anchors.rightMargin: 50
        TextField {
            id: mapTf
            implicitHeight: 25
            Layout.fillWidth: true
            width: parent.width /2
            height: parent.height
            text: modList.mapVal
            visible:{
                if (val2dor3d==1) false; else true;
            }
            onEditingFinished:
            {
                imageCube.map=mapTf.text

                modList.mapVal = mapTf.text
            }
        }

        TextField {
            id: napTf
            implicitHeight: 25
            Layout.fillWidth: true
            width: parent.width /2
            height: parent.height
            visible:{
                if (val2dor3d==1) false; else true;
            }
            text: modList.napVal
            onEditingFinished:
            {
                imageCube.nap=napTf.text
                modList.napVal = napTf.text
            }
        }
    }
    RowLayout {
        id: rowLayout5
        x: 30
        y: 170
        width: 300
        visible:{
            if (val2dor3d==1) false; else true;
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
            visible:{
                if (val2dor3d==1) false; else true;
            }
            onEditingFinished:
            {
                imageCube.dv=dvTf.text*100*5
                modList.dvVal = dvTf.text
            }
        }
    }
    Text {
        id: text8
        //x: 378
        y: 50
        anchors.right: parent.right
        anchors.rightMargin: 240
        text: qsTr("w")
        font: window.font
        //font.pixelSize: 14
    }

    Text {
        id: text9
        //x: 483
        y: 50
        anchors.right: parent.right
        anchors.rightMargin: 140
        text: qsTr("l")
        font: window.font
    }

    Text {
        id: text10
        x: 378
        y: 100
        anchors.right: parent.right
        anchors.rightMargin: 240
        text: qsTr("X")
         font: window.font
    }

    Text {
        id: text11
        x: 483
        y: 100
        anchors.right: parent.right
        anchors.rightMargin: 140
        text: qsTr("Y")
         font: window.font
    }
    Text {
        id: text12
        x: 378
        y: 150
        visible:{
            if (val2dor3d==1) false; else true;
        }
        anchors.right: parent.right
        anchors.rightMargin: 230
        text: qsTr("M ap")
        font: window.font
    }

    Text {
        id: text13
        x: 483
        visible:{
            if (val2dor3d==1) false; else true;
        }
        y: 150
        anchors.right: parent.right
        anchors.rightMargin: 130
        text: qsTr("N ap")
         font: window.font
    }
    Text {
        id: text14
        x: 30
        visible:{
            if (val2dor3d==1) false; else true;
        }
        y: 150
        text: qsTr("dh")
         font: window.font
    }

    Text {
        id: text15
        x: 184
        visible:{
            if (val2dor3d==1) false; else true;
        }
        y: 150
        text: qsTr("dv")
        font: window.font
    }
        //Row{
            //anchors.horizontalCenter: parent.horizontalCenter
    ImageCube {
        id: imageCube
        width: parent.width
        height: parent.height*0.6
        anchors.top: rectangle.bottom
        //anchors.bottom: parent.bottom
        anchors.bottomMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter
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
        //! [0]
        angleOffset: -180 / 8.0
        backgroundColor: "#FCFCFC"
        state: "image1"
        image1: "qrc:/devices.png"
    }
        Image {
            id: image
            //x: window.width/3
            //y: 0
  //          anchors.top: opacId.anchors.bottom
            x: 335
            y: 100
 //           anchors.left: opacId.anchors.left
//            anchors.leftMargin: 100
            source: (val2dor3d==1) ? "single_activated.png" : "single.png"
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(val2dor3d!=1){
                        val2dor3d = 1;
                        imageCube.arrayMode();
                    }
                }
            }
        }

        Image {
            id: image2
         //   x: window.width/3
         //   y: window.height - window.height/2
            x: 335
            y: 155
       //     anchors.rightMargin: 100
            source: (val2dor3d==2) ? "array_activated.png" : "array.png"
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(val2dor3d!=2){
                        val2dor3d = 2;
                        imageCube.arrayMode();
                    }
                }
            }
        }
        //}
}

