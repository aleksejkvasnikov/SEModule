/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the QtCanvas3D module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

Qt.include("three.js")
Qt.include("csg.js")
Qt.include("ThreeCSG.js")
//Qt.include("Arial_Regular.js")
var camera, scene, renderer,group;
var cube, result, axesHelper, gridHelper, letterA;
var pointLight;
var mode = 0;
var PrevX=40, PrevY=90;
var buttonpressed;
var wireVal = false;
function drawLetters(canvas){

    var source ='qrc:/Arial_Regular.json';
    var loader = new THREE.FontLoader();
    loader.load( source, function ( font ) {
        if(canvas.sometype=== 2) var aText = "r"
        else aText = "a"
      var textGeometry = new THREE.TextGeometry( aText, {
        font: font,
        size: 10,
        height: 1,
        curveSegments: 12,
        bevelThickness: 1,
        bevelSize: 1,
        bevelEnabled: false
      });
      var textMaterial = new THREE.MeshPhongMaterial(
        { color: "black", specular: "black" }
      );
      letterA = new THREE.Mesh( textGeometry, textMaterial );
        letterA.translateY(-canvas.bb/2*1.3);
        letterA.translateZ(canvas.dd/2);
        group.add(letterA);

        textGeometry = new THREE.TextGeometry( "b", {
          font: font,
          size: 10,
          height: 1,
          curveSegments: 12,
          bevelThickness: 1,
          bevelSize: 1,
          bevelEnabled: false
        });
        textMaterial = new THREE.MeshPhongMaterial(
          { color: "black", specular: "black" }
        );
        var letterB = new THREE.Mesh( textGeometry, textMaterial );
          letterB.translateX(-canvas.aa/2-(canvas.aa/2*0.1));
          letterB.translateZ(canvas.dd/2);
        if(canvas.sometype != 2) group.add(letterB);
        if(canvas.sometype=== 2) var dText = "h"
        else dText = "d"
        textGeometry = new THREE.TextGeometry( dText, {
          font: font,
          size: 10,
          height: 1,
          curveSegments: 12,
          bevelThickness: 1,
          bevelSize: 1,
          bevelEnabled: false
        });
        textMaterial = new THREE.MeshPhongMaterial(
          { color: "black", specular: "black" }
        );
        var letterD = new THREE.Mesh( textGeometry, textMaterial );
          letterD.translateX(canvas.aa/2+(canvas.aa/2*0.1));
          letterD.translateY(-canvas.bb/2*1.3);
        group.add(letterD);

    });
}

function initializeGL(canvas, eventSource) {
    //! [0]
    camera = new THREE.PerspectiveCamera(50, canvas.width / canvas.height, 1, 2000);
    camera.position.z = 400;
    camera.position.y = 140;

    scene = new THREE.Scene();
    //! [0]

    var size = 100;
    var divisions = 10;

 //   gridHelper = new THREE.GridHelper( size, divisions );
   // gridHelper.translateY(-1*canvas.bb);
   // scene.add( gridHelper );
    var cube1, cube1Csg, cube2, cube2Csg, cube3, cube3Csg, resultGeo, resultCsg;
    axesHelper = new THREE.AxisHelper( 25 );
    axesHelper.translateX(-1*canvas.aa/2);
    axesHelper.translateY(-1*canvas.bb/2);
    if(canvas.sometype===2) axesHelper.translateZ(canvas.cylHeight*0.8);
    else axesHelper.translateZ(canvas.dd*0.8);
    axesHelper.rotation.y = Math.PI / 2;
   // scene.add( axesHelper );
    if(canvas.sometype===0){
        cube1 = new THREE.Mesh(new THREE.BoxGeometry(canvas.aa+canvas.t,canvas.bb+canvas.t,canvas.dd+canvas.t),new THREE.MeshLambertMaterial({color: 0xFF0000}));
        cube1Csg	= THREE.CSG.toCSG(cube1);
        cube3 = new THREE.Mesh(new THREE.BoxGeometry(canvas.aa,canvas.bb,canvas.dd),new THREE.MeshLambertMaterial({color: 0xFF0000}));
        cube3Csg	= THREE.CSG.toCSG(cube3);
        cube2 = new THREE.Mesh(new THREE.BoxGeometry(canvas.l,canvas.w,canvas.t),new THREE.MeshLambertMaterial({color: 0xFF0000}));
        cube2.translateX(-canvas.aa/2+canvas.xx);
        cube2.translateY(-canvas.bb/2+canvas.yy);
        cube2.translateZ(canvas.dd/2);
     //   cube2.translateY(canvas.bb/2);
         cube2Csg	= THREE.CSG.toCSG(cube2);
         resultCsg	= (cube1Csg.subtract(cube3Csg)).subtract(cube2Csg);
         resultGeo	= THREE.CSG.fromCSG( resultCsg );
    }
    else if(canvas.sometype===1){
         cube1 = new THREE.Mesh(new THREE.BoxGeometry(canvas.aa+canvas.t,canvas.bb+canvas.t,canvas.dd+canvas.t),new THREE.MeshLambertMaterial({color: 0xFF0000}));
         cube1Csg	= THREE.CSG.toCSG(cube1);
         cube3 = new THREE.Mesh(new THREE.BoxGeometry(canvas.aa,canvas.bb,canvas.dd),new THREE.MeshLambertMaterial({color: 0xFF0000}));
         cube3Csg	= THREE.CSG.toCSG(cube3);
         resultCsg	= (cube1Csg.subtract(cube3Csg));
       // console.log((canvas.dh*(canvas.map-1))/2);
        for(var i=0; i<canvas.map; i++)
            for(var j=0; j<canvas.nap; j++){
                cube2 = new THREE.Mesh(new THREE.BoxGeometry(canvas.l,canvas.w,canvas.t),new THREE.MeshLambertMaterial({color: 0xFF0000}));
                cube2.translateX(canvas.dh*i - ((canvas.dh*(canvas.map-1))/2));
                cube2.translateY(canvas.dv*j - ((canvas.dv*(canvas.nap-1))/2));
                cube2.translateZ(canvas.dd/2);
                cube2Csg	= THREE.CSG.toCSG(cube2);
                resultCsg = resultCsg.subtract(cube2Csg);
            }
         resultGeo	= THREE.CSG.fromCSG( resultCsg );
    }else if(canvas.sometype===2){
        // цилиндр
        var cylinder1  = new THREE.Mesh(new THREE.CylinderGeometry(canvas.radius+canvas.t, canvas.radius+canvas.t, canvas.cylHeight+canvas.t, 36), new THREE.MeshLambertMaterial({color: 0xFF0000}));
        cylinder1.rotation.x = Math.PI / 2;
        var cylinder2  = new THREE.Mesh(new THREE.CylinderGeometry(canvas.radius, canvas.radius, canvas.cylHeight, 36), new THREE.MeshLambertMaterial({color: 0xFF0000}));
        cylinder2.rotation.x = Math.PI / 2;
        var cylinder3  = new THREE.Mesh(new THREE.CylinderGeometry(canvas.apRadius, canvas.apRadius, canvas.cylHeight, 36), new THREE.MeshLambertMaterial({color: 0xFF0000}));
        cylinder3.rotation.x = Math.PI / 2;
        cylinder3.translateZ(-1 * canvas.cylHeight/2);
        var cylinder1Csg	= THREE.CSG.toCSG(cylinder1);
        var cylinder2Csg	= THREE.CSG.toCSG(cylinder2);
        var cylinder3Csg	= THREE.CSG.toCSG(cylinder3);
        resultCsg	= (cylinder1Csg.subtract(cylinder2Csg)).subtract(cylinder3Csg);
        resultGeo	= THREE.CSG.fromCSG( resultCsg );
        console.log("here");
    }

    group = new THREE.Group();
    cube = new THREE.Mesh( resultGeo,  new THREE.MeshLambertMaterial({color: 0x6A5ACD, wireframe: wireVal}) );
    if(!wireVal){       
        group.add(cube);
    }
    else{
        // wireframe
        var geo = new THREE.EdgesGeometry( cube.geometry ); // or WireframeGeometry
        var mat = new THREE.LineBasicMaterial( { color: "black", linewidth: 2 } );
        var wireframe = new THREE.LineSegments( geo, mat );
        group.add( wireframe );
    }
    group.add(axesHelper);
    drawLetters(canvas);
    scene.add( group );
    camera.lookAt(group.position);
    // Lights
    //! [6]
    scene.add(new THREE.AmbientLight(0x444444));
    var directionalLight = new THREE.DirectionalLight(0xffffff, 1.0);
    directionalLight.position.y = 130;
    directionalLight.position.z = 700;
    directionalLight.position.x = Math.tan(canvas.angleOffset) * directionalLight.position.z;
    directionalLight.position.normalize();
    scene.add(directionalLight);
    //! [6]

    //! [4]
    renderer = new THREE.Canvas3DRenderer(
                { canvas: canvas, antialias: true, devicePixelRatio: canvas.devicePixelRatio });
    renderer.setPixelRatio(canvas.devicePixelRatio);
    renderer.setSize(canvas.width, canvas.height);
    setBackgroundColor(canvas.backgroundColor);
    eventSource.mouseMove.connect(onDocumentMouseMove);
    eventSource.mouseDown.connect(onDocumentMouseDown);
    eventSource.mouseUp.connect(onDocumentMouseUp);
    eventSource.mouseWheel.connect(onDocumentMouseWheel);
    //! [4]
}

function setBackgroundColor(backgroundColor) {
    var str = ""+backgroundColor;
    var color = parseInt(str.substring(1), 16);
    if (renderer)
        renderer.setClearColor(color);
}

function resizeGL(canvas) {
    if (camera === undefined) return;
    camera.aspect = canvas.width / canvas.height;
    camera.updateProjectionMatrix();
    renderer.setPixelRatio(canvas.devicePixelRatio);
    renderer.setSize(canvas.width, canvas.height);
}
function onDocumentMouseWheel(x,y) {
  camera.zoom += (y/120)/8;
  // console.log(y);
    camera.updateProjectionMatrix();
}
function onDocumentMouseDown(x,y, buttons) {
  buttonpressed = true;
}
function onDocumentMouseUp(x,y) {
    buttonpressed = false;
}
function onDocumentMouseMove(x,y) {

    var delta=PrevY-x;
    var delta2=PrevX-y;
   // console.log(delta)
    if(buttonpressed){
    group.rotation.y += (-1*delta)/70;
  //  axesHelper.rotation.y += (-1*delta)/70;
   // gridHelper.rotation.y += (-1*delta)/70;
        group.rotation.x += (-1*delta2)/70;
     //   axesHelper.rotation.x += (-1*delta2)/70;
    //    gridHelper.rotation.x += (-1*delta2)/70;
    }
   // camera.position.y += ( -y/40 - camera.position.y ) * .2;
    PrevY=x;
    PrevX=y;
}
function animate() {
  renderer.render(scene, camera);
}
function resize() {
    renderer.setSize(width, height, false);
    camera.aspect = width / height;
    camera.updateProjectionMatrix();
}
function enableWire(canvas)
{
    while(scene.children.length > 0){
        scene.remove(scene.children[0]);
    }
    if(wireVal) wireVal = false;
    else wireVal = true;
    initializeGL(canvas);
}
function changeMode(type, canvas)
{
    while(scene.children.length > 0){
        scene.remove(scene.children[0]);
    }
    mode = type;
    initializeGL(canvas);
}
function resizeCube(canvas){
    while(scene.children.length > 0){
        scene.remove(scene.children[0]);
    }
    initializeGL(canvas);
}
//! [5]
function paintGL(canvas) {
    cube.rotation.x = canvas.xRotation * Math.PI / 180;
    cube.rotation.y = canvas.yRotation * Math.PI / 180;
    cube.rotation.z = canvas.zRotation * Math.PI / 180;
    renderer.render(scene, camera);
}
//! [5]
