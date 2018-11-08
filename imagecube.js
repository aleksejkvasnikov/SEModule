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
var camera, scene, renderer;
var cube, result;
var pointLight;

function initializeGL(canvas, a, b, d) {
    //! [0]
    console.log("azaza")
    camera = new THREE.PerspectiveCamera(50, canvas.width / canvas.height, 1, 2000);
    camera.position.z = 400;
    camera.position.y = 140;

    scene = new THREE.Scene();
    //! [0]

    // Box geometry to be broken down for MeshFaceMaterial
    //! [2]
 //   var geometry = new THREE.BoxGeometry(a, b, d);

    var faceMaterial = new THREE.MeshBasicMaterial({
       color: 0x000000,
       wireframe: true,
     });

    var faceMaterial2 = new THREE.MeshBasicMaterial({
       color: 0x00FF00,
       //wireframe: true,
     });

    var cube1 = new THREE.Mesh(    new THREE.BoxGeometry(a,b,d),    new THREE.MeshLambertMaterial({color: 0xFF0000}));
    var cube1Csg	= THREE.CSG.toCSG(cube1);
    var cube3 = new THREE.Mesh(    new THREE.BoxGeometry(a*.99,b*.99,d*.99),    new THREE.MeshLambertMaterial({color: 0xFF0000}));
    var cube3Csg	= THREE.CSG.toCSG(cube3);
    var cube2 = new THREE.Mesh(    new THREE.BoxGeometry(a/2,b/2,d/2),    new THREE.MeshLambertMaterial({color: 0xFF0000}));
    cube2.translateX(d/2);
    var cube2Csg	= THREE.CSG.toCSG(cube2);
    var resultCsg	= (cube1Csg.subtract(cube3Csg)).subtract(cube2Csg);
    var resultGeo	= THREE.CSG.fromCSG( resultCsg );
    cube = new THREE.Mesh( resultGeo,  new THREE.MeshLambertMaterial({color: 0xFF0000}) );
    scene.add( cube );
    camera.lookAt(cube.position);

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
function animate() {
 // resize();
  cube.rotation.x += 0.01;
  cube.rotation.y += 0.01;
  cube.rotation.z += 0.01;
  renderer.render(scene, camera);
}
function resize() {
  //var width = renderer.domElement.clientWidth;
 // var height = renderer.domElement.clientHeight;
  //if (renderer.domElement.width !== width || renderer.domElement.height !== height) {
    renderer.setSize(width, height, false);
    camera.aspect = width / height;
    camera.updateProjectionMatrix();
 // }
}
function resizeCube(canvas,xSize, ySize, zSize){
  //console.log(xSize/cube.geometry.parameters.width);
    while(scene.children.length > 0){
        scene.remove(scene.children[0]);
    }
    var cube1 = new THREE.Mesh(    new THREE.BoxGeometry(xSize,ySize,zSize),    new THREE.MeshLambertMaterial({color: 0xFF0000}));
    var cube1Csg	= THREE.CSG.toCSG(cube1);
    var cube3 = new THREE.Mesh(    new THREE.BoxGeometry(xSize*.99,ySize*.99,zSize*.99),    new THREE.MeshLambertMaterial({color: 0xFF0000}));
    var cube3Csg	= THREE.CSG.toCSG(cube3);
    var cube2 = new THREE.Mesh(    new THREE.BoxGeometry(xSize/2,ySize/2,zSize/2),    new THREE.MeshLambertMaterial({color: 0xFF0000}));
    cube2.translateX(zSize/2);
    var cube2Csg	= THREE.CSG.toCSG(cube2);
    var resultCsg	= (cube1Csg.subtract(cube3Csg)).subtract(cube2Csg);
    var resultGeo	= THREE.CSG.fromCSG( resultCsg );
    cube = new THREE.Mesh( resultGeo,  new THREE.MeshLambertMaterial({color: 0xFF0000}));
    scene.add( cube );
    camera.lookAt(cube.position);
 /* var scaleFactorX = xSize / cube.geometry.parameters.width;
  var scaleFactorY = ySize / cube.geometry.parameters.height;
  var scaleFactorZ = zSize / cube.geometry.parameters.depth;
  cube.scale.set( scaleFactorX, scaleFactorY, scaleFactorZ );
  */
    // Lights
    //! [6]
    scene.add(new THREE.AmbientLight(0x444444));
    var directionalLight = new THREE.DirectionalLight(0xffffff, 1.0);
    directionalLight.position.y = 130;
    directionalLight.position.z = 700;
    directionalLight.position.x = Math.tan(canvas.angleOffset) * directionalLight.position.z;
    directionalLight.position.normalize();
    scene.add(directionalLight);
   // setBackgroundColor(cube.backgroundColor);
    //! [6]
}
//! [5]
function paintGL(canvas) {
    cube.rotation.x = canvas.xRotation * Math.PI / 180;
    cube.rotation.y = canvas.yRotation * Math.PI / 180;
    cube.rotation.z = canvas.zRotation * Math.PI / 180;
    renderer.render(scene, camera);
}
//! [5]
