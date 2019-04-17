import QtQuick 2.9
import QtCanvas3D 1.0
import "imagecube.js" as GLCode

Canvas3D {
    id: cube
    property double xRotAnim: 0
    //! [0]
    state: "image1"
    property color backgroundColor: "#FCFCFC"
    property real angleOffset: -180 / 8.0
    property string image1: ""
    //! [0]
    property string image2: ""
    property string image3: ""
    property string image4: ""
    property string image5: ""
    property string image6: ""
    property real xRotation: 0
    property real yRotation: 0
    property real zRotation: 0
    property real aa: 0
    property real bb: 0
    property real dd: 0
    property real t: 0
    property real w: 0
    property real l: 0
    property real xx: 0
    property real yy: 0
    property real dh: 0
    property real dv: 0
    property real map: 0
    property real nap: 0
    onBackgroundColorChanged: { GLCode.setBackgroundColor(cube.backgroundColor); }

    //! [1]
    states: [
        State {
            name: "image1"
            PropertyChanges { target: cube; xRotation: 0; }
            PropertyChanges { target: cube; yRotation: 180 * 1.5 + angleOffset; }
            PropertyChanges { target: cube; zRotation: 0 }
        }
    ]

    //! [2]
    transitions: [
        Transition {
            id: turnTransition
            from: "*"
            to: "*"
            RotationAnimation {
                properties: "xRotation,yRotation,zRotation"
                easing.type: Easing.InOutCubic
                direction: RotationAnimation.Shortest
                duration: 450
            }
        }
    ]
    //! [2]
    function callme(){
        GLCode.resizeCube(cube);
    }
    function enableWire(){
        GLCode.enableWire(cube);
    }
    function arrayMode(){
        GLCode.changeMode(cube);
    }
    //! [3]
    onInitializeGL: {
        GLCode.initializeGL(cube, eventSource);
    }
    ControlEventSource {
        anchors.fill: parent
        focus: true
        id: eventSource
    }
    onPaintGL: {
     //   GLCode.paintGL(cube);
    }

    onResizeGL: {
        GLCode.resizeGL(cube);
    }
    //! [3]
    Timer {
       interval: 20; running: true; repeat: true
       onTriggered: {
         GLCode.animate();
       }
    }
}

