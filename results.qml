import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
import CustomPlot 1.0
Page {
    id: results
    width: 600
    height: 400
    spacing: -6
    transformOrigin: Item.TopLeft

    title: qsTr("Результаты") + rootItem.emptyString
    Item {
        width: window.width*0.85
        height: window.height*0.85
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
