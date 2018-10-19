import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
import CustomPlot 1.0
Page {
    id: results
    width: window.width
    height: window.height*0.85
    spacing: -6
    transformOrigin: Item.Center

    title: qsTr("Результаты") + rootItem.emptyString
    Item {
        anchors.fill: parent
            CustomPlotItem {
                id: customPlot
                anchors.fill: parent
               // list: modList
                Component.onCompleted: {
                    modList.callTest( customPlot);
                }

            }
    }
}
