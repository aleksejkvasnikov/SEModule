import QtQuick 2.9
import QtQuick.Controls 2.2
import QtDataVisualization 1.3
import SfModel 1.0
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
import HZformatter 1.0
import Qt3D.Extras 2.0
import Qt3D.Core 2.0
import Qt3D.Render 2.0
Page {
    id: pag
    width: 600
    height: 400

    title: qsTr("3D отображение") + rootItem.emptyString
    Item {
        width: window.width
        height: window.height
      //  OrbitCameraController {
          //  camera: surface.scene.activeCamera
     //   }
        Surface3D {
            width: window.width
            height: window.height
            id: surface
            horizontalAspectRatio: 0.8
            theme.font: window.font
            theme.labelBackgroundEnabled: false
            Surface3DSeries {
                id: surfaceSeries
                baseGradient: rtb
                colorStyle: Theme3D.ColorStyleRangeGradient
                drawMode: Surface3DSeries.DrawSurface
                flatShadingEnabled: false
                meshSmooth: true
                itemLabelFormat: qsTr("ЭЭ в точке (@xLabel, @zLabel м): @yLabel дБ")
                ItemModelSurfaceDataProxy {
                    id: surfDatProx
                    itemModel:  SurfaceModel {
                        id: myModel
                        list: modList
                    }
                    // Mapping model roles to surface series rows, columns, and values.
                    rowRole: "z"
                    columnRole: "x"
                    yPosRole: "y"
                }
                ColorGradient {
                    id: rtb
                    ColorGradientStop {
                        id: cgs1
                        position: 0.5; color: "#ff1f1f"
                    }
                    ColorGradientStop {
                        id: cgs2
                        position: 0.0; color: "#021cf0"
                    }
                }

            }
            shadowQuality: AbstractGraph3D.ShadowQualityMedium
           // axisX.labelFormat: "%f"
            axisX.formatter: HZformatter {

            }
            locale: Qt.locale("ru_RU")
            axisZ.labelFormat: "%.2f"
            axisY.labelFormat: "%d"
            axisY.title: qsTr("ЭЭ, дБ") + rootItem.emptyString
            axisX.title: qsTr("Частота, Гц") + rootItem.emptyString
            axisZ.title: qsTr("Точка обзора, м") + rootItem.emptyString
            axisX.titleVisible: true
            axisY.titleVisible: true
            axisZ.titleVisible: true
            axisX.labelAutoRotation: 15
            axisY.labelAutoRotation: 90
            axisZ.labelAutoRotation: 15

        }

        ColorDialog {
            id: colorDialog
            currentColor: cgs1.color
            title: qsTr("Выберите цвет") + rootItem.emptyString
            onAccepted: {
                console.log("You chose: " + colorDialog.color)
                cgs1.color = colorDialog.color;
            }
            onRejected: {
                console.log("Canceled")
            }
        }
        ColorDialog {
            id: colorDialog2
            currentColor: cgs2.color
            title: qsTr("Выберите цвет") + rootItem.emptyString
            onAccepted: {
                console.log("You chose: " + colorDialog2.color)
                cgs2.color = colorDialog2.color;
            }
            onRejected: {
                console.log("Canceled")
            }
        }
        RowLayout {
            anchors.topMargin: 10
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            Button {

                id: control31
                text: qsTr("Сетка") + rootItem.emptyString
                Layout.fillWidth: true
                contentItem: Text {
                    text: control31.text
                    font: control31.font
                    opacity: enabled ? 1.0 : 0.3
                    color: control31.down ? "#17a81a" : "#000"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }
                onClicked: {
                                if (surfaceSeries.drawMode & Surface3DSeries.DrawWireframe) {
                                    surfaceSeries.drawMode &= ~Surface3DSeries.DrawWireframe;

                                } else {
                                    surfaceSeries.drawMode |= Surface3DSeries.DrawWireframe;

                                }
                            }

                background: Rectangle {
                    implicitWidth: 60
                    implicitHeight: 40
                    opacity: enabled ? 1 : 0.3
                    border.color: control31.down ? "#17a81a" : "#000"
                    border.width: 1
                    radius: 2
                }
            }
            Button {

                id: control
                text: qsTr("Вычислить") + rootItem.emptyString
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
                //  surface.axisX.setLocale(Qt.locale("ru_RU"));
                    timeElapsed.visible = true;
                    iterCount.visible = true;
                    prb.visible = true;
                    modList.recalculate();
                    //customPlot.initCustomPlot();
                   //surface.axisX.applyNiceNumbers();
                    //modList.progress = true;
                }

                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40
                    opacity: enabled ? 1 : 0.3
                    border.color: control.down ? "#17a81a" : "#000"
                    border.width: 1
                    radius: 2
                }
            }
            Button {
                id: control1
                text: qsTr("Очистить") + rootItem.emptyString
                Layout.fillWidth: true
                contentItem: Text {
                    text: control1.text
                    font: control1.font
                    opacity: enabled ? 1.0 : 0.3
                    color: control1.down ? "#17a81a" : "#000"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }
                onClicked: {
                    //timeElapsed.visible = false;
                   // iterCount.visible = false;
                    modList.removeallItems();
                }
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40
                    opacity: enabled ? 1 : 0.3
                    border.color: control1.down ? "#17a81a" : "#000"
                    border.width: 1
                    radius: 2
                }
            }
            Button{
                id: control42
                text: qsTr("Стоп")  + rootItem.emptyString
                Layout.fillWidth: true
                contentItem: Text {
                    text: control42.text
                    font: control42.font
                    opacity: enabled ? 1.0 : 0.3
                    color: control42.down ? "#17a81a" : "#000"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }
                 onClicked: {
                     modList.interrupted();
                }
                 background: Rectangle {
                    implicitWidth: 60
                    implicitHeight: 40
                    opacity: enabled ? 1 : 0.3
                    border.color: control42.down ? "#17a81a" : "#000"
                    border.width: 1
                    radius: 2
                }
            }
            ColumnLayout {
                spacing: 1
                Button {
                    id: control2
                   // text: qsTr("Up")
                   // Layout.fillWidth: true
                    contentItem: Text {
                        text: control2.text
                        font: control2.font
                        opacity: enabled ? 1.0 : 0.3
                        color: control2.down ? "#17a81a" : "#000"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                    }
                    onClicked: {
                        colorDialog.visible = true;
                    }
                    background: Rectangle {
                        width: 20
                        height: 20
                        opacity: enabled ? 1 : 0.3
                        color: cgs1.color
                        border.color: control2.down ? "#17a81a" : "#000"
                        border.width: 1
                        radius: 1
                    }
                }
                Button {
                    id: control3
                    //text: qsTr("Down")
                   // Layout.fillWidth: true
                    contentItem: Text {
                        text: control3.text
                        font: control3.font
                        opacity: enabled ? 1.0 : 0.3
                        color: control3.down ? "#17a81a" : "#000"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                    }
                    onClicked: {
                        colorDialog2.visible = true;
                    }
                    background: Rectangle {
                        width: 20
                        height: 20
                        color: cgs2.color
                        opacity: enabled ? 1 : 0.3
                        border.color: control3.down ? "#17a81a" : "#000"
                        border.width: 1
                        radius: 1
                    }
                }

            }
            ColumnLayout {
                spacing: 10
                Label {
                    id: timeElapsed
                   // visible: false
                    text: qsTr("Время вычислений: ")  + rootItem.emptyString + modList.time/1000 + qsTr(" с")  + rootItem.emptyString
                }
                Label {
                    id: iterCount
                 //   visible: false
                    text: qsTr("Кол-во итераций: ")  + rootItem.emptyString + modList.iter
                }
            }
            ColumnLayout
            {
                spacing: 10
                Button{
                    id: controlsa1
                    text: qsTr("1") + rootItem.emptyString
                    Layout.fillWidth: true
                    contentItem: Text {
                        text: controlsa1.text
                        font: controlsa1.font
                        opacity: enabled ? 1.0 : 0.3
                        color: controlsa1.down ? "#17a81a" : "#000"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                    }
                     onClicked: {
                        modList.saveOne();
                    }
                     background: Rectangle {
                        implicitWidth: 20
                        implicitHeight: 20
                        opacity: enabled ? 1 : 0.3
                        border.color: controlsa1.down ? "#17a81a" : "#000"
                        border.width: 1
                        radius: 1
                    }
                }
                 Button{
                    id: controlsa2
                    text: qsTr("2") + rootItem.emptyString
                    Layout.fillWidth: true
                    contentItem: Text {
                        text: controlsa2.text
                        font: controlsa2.font
                        opacity: enabled ? 1.0 : 0.3
                        color: controlsa2.down ? "#17a81a" : "#000"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                    }
                     onClicked: {
                        modList.saveTwo();
                    }
                     background: Rectangle {
                        implicitWidth: 20
                        implicitHeight: 20
                        opacity: enabled ? 1 : 0.3
                        border.color: controlsa2.down ? "#17a81a" : "#000"
                        border.width: 1
                        radius: 1
                    }
                }
            }
             ColumnLayout
            {
                spacing: 10
                Button{
                    id: controlshow1
                    text: qsTr("Граф.1") + rootItem.emptyString
                    Layout.fillWidth: true
                    contentItem: Text {
                        text: controlshow1.text
                        font: controlshow1.font
                        opacity: enabled ? 1.0 : 0.3
                        color: controlshow1.down ? "#17a81a" : "#000"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                    }
                     onClicked: {
                        modList.showOne();
                    }
                     background: Rectangle {
                        implicitWidth: 20
                        implicitHeight: 20
                        opacity: enabled ? 1 : 0.3
                        border.color: controlshow1.down ? "#17a81a" : "#000"
                        border.width: 1
                        radius: 1
                    }
                }
                 Button{
                    id: controlshow2
                    text: qsTr("Граф.2") + rootItem.emptyString
                    Layout.fillWidth: true
                    contentItem: Text {
                        text: controlshow2.text
                        font: controlshow2.font
                        opacity: enabled ? 1.0 : 0.3
                        color: controlshow2.down ? "#17a81a" : "#000"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                    }
                     onClicked: {
                        modList.showTwo();
                    }
                     background: Rectangle {
                        implicitWidth: 20
                        implicitHeight: 20
                        opacity: enabled ? 1 : 0.3
                        border.color: controlshow2.down ? "#17a81a" : "#000"
                        border.width: 1
                        radius: 1
                    }
                }
            }
             Button{
                id: compute
                text: qsTr("Дельта") + rootItem.emptyString
                Layout.fillWidth: true
                contentItem: Text {
                    text: compute.text
                    font: compute.font
                    opacity: enabled ? 1.0 : 0.3
                    color: compute.down ? "#17a81a" : "#000"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }
                 onClicked: {
                    modList.differenceBetweenSaves();
                }
                 background: Rectangle {
                    implicitWidth: 20
                    implicitHeight: 20
                    opacity: enabled ? 1 : 0.3
                    border.color: compute.down ? "#17a81a" : "#000"
                    border.width: 1
                    radius: 1
                }
            }
        }
        Row{
            ProgressBar {
                id: prb
                visible: false;
                width: window.width
               // indeterminate: true
                value: modList.progress/100
            }
        }
    }
}
