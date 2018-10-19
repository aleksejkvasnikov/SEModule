import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import QtQuick 2.0
import QtCanvas3D 1.0

//! [4]
import "textureandlight.js" as GLCode
//! [4]

Page {
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
        text: qsTr("σ")
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
            id: wTf
            implicitHeight: 25
            Layout.fillWidth: true
            width: parent.width /2
            height: parent.height
            text: modList.wVal
            onEditingFinished:
            {
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
            onEditingFinished:
            {
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
                modList.napVal = napTf.text
            }
        }
    }
    RowLayout {
        id: rowLayout5
        x: 30
        y: 170
        width: 300
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
        anchors.right: parent.right
        anchors.rightMargin: 230
        text: qsTr("M ap")
        font: window.font
    }

    Text {
        id: text13
        x: 483
        y: 150
        anchors.right: parent.right
        anchors.rightMargin: 130
        text: qsTr("N ap")
         font: window.font
    }
    Text {
        id: text14
        x: 30
        y: 150
        text: qsTr("dh")
         font: window.font
    }

    Text {
        id: text15
        x: 184
        y: 150
        text: qsTr("dv")
        font: window.font
    }

       Image {
        id: image
        x: window.width/3
        y: window.height - window.height/2
        width: window.height/3
        height: (window.height-35)/3
        source: "corpus.PNG"
    }


}

