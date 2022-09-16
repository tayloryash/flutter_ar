
import 'dart:typed_data';

import 'Armodelselect.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';
import 'package:network_image_to_byte/network_image_to_byte.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class arviewpage extends StatefulWidget {
  objmodel modeldes;
  arviewpage(this.modeldes);
  @override
  _arviewpageState createState() => _arviewpageState(this.modeldes);
}

class _arviewpageState extends State<arviewpage> {
  _arviewpageState(this.modeldes);
  void initstate(){
    super.initState();
  }
  List<double> cubesize;
  objmodel modeldes;
  ArCoreController arCoreController;
  Uint8List byteImage,byteImage1;

  Future<bool> _onWillPop() async {
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar:  AppBar(
          title:  const  Text('Xperience'),
        ),
        body:  ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
        ),
      ),
    );
  }

  //functions::::::::::::::::::

  void  _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    if(modeldes.type=='sphere'){
      _addsphere();
    }
    else if(modeldes.type=="sphere2"){
      _addmoonearth();
    }
    else if(modeldes.type=='cube'){
      _addCube();
    }
  }

  //convert image to byteimage
  Future<Uint8List> _networkImageToByte(String imageaddress,String imageaddress1) async {
    byteImage = await networkImageToByte(imageaddress);
    if(imageaddress1!="0"){
      byteImage1=await networkImageToByte(imageaddress1);
    }
    return byteImage;
  }

  //convert cube size to double
  List<double> convertStringtodoublearr(String size){
     var cubesize=size.split(",");
     for(int i=0;i<cubesize.length;i++){
       this.cubesize[i]=double.parse(cubesize[i]);
     }
  }

  //sphere ar model implementation
  Future _addsphere() async {
    await _networkImageToByte(modeldes.img_url,modeldes.explain);

    //description ar model:::::::::::::::::::::::::::::::

    final material = ArCoreMaterial(
      metallic: 1,
      color: Colors.blue,
      //metallic: 1.0,
      textureBytes: byteImage1,
    );
    final cube = ArCoreCube(
        materials: [material],
        size: vector.Vector3(0.5,0.2,0.1)
    );
    final node = ArCoreNode(
      shape: cube,
      position: vector.Vector3(0,-0.4,0.5),
    );

    //sphere texture model ::::::::::::::::::::::::::::::::::::

    final eamaterial = ArCoreMaterial(
      metallic: 1,
      color: Colors.blue,
      textureBytes: byteImage,
    );
    final sphere = ArCoreSphere(
      materials: [eamaterial],
      radius: double.parse(modeldes.size[0]),
    );
    final eanode = ArCoreNode(
      shape: sphere,
      position: vector.Vector3(0,0,-1),
      children: modeldes.explain=="0"?[]:[node],
    );
    arCoreController.addArCoreNode(eanode);
  }


  //cube ar model implementation
  Future _addCube() async{
    await _networkImageToByte(modeldes.img_url,modeldes.explain);

    //description ar model::::::::::::::::::::::::::::::::::::

    final material = ArCoreMaterial(
      metallic: 1,
      color: Colors.blue,
      //metallic: 1.0,
      textureBytes: byteImage1,
    );
    final cube = ArCoreCube(
        materials: [material],
        size: vector.Vector3(0.5,0.2,0.1)
    );
    final node = ArCoreNode(
      shape: cube,
      position: vector.Vector3(0,-0.4,0.5),
    );

    //cube texture model ::::::::::::::::::::::::::::::::::;

    final cube_material = ArCoreMaterial(
      metallic: 1,
      color: Colors.blue,
      //metallic: 1.0,
      textureBytes: byteImage,
    );
    final cube_cube = ArCoreCube(
      materials: [cube_material],
      size: vector.Vector3(double.parse(modeldes.size[0]),double.parse(modeldes.size[1]),double.parse(modeldes.size[2])),
    );
    final cube_node = ArCoreNode(
      shape: cube_cube,
      children: modeldes.explain=="0"?[]:[node],
      position: vector.Vector3(0,0,-1),
    );
    arCoreController.addArCoreNode(cube_node);
  }



  Future _addmoonearth() async {
    await _networkImageToByte(modeldes.img_url,modeldes.explain);

    //description ar model:::::::::::::::::::::::::::::::

    final material = ArCoreMaterial(
      metallic: 1,
      color: Colors.blue,
      //metallic: 1.0,
      textureBytes: byteImage1,
    );
    final moon = ArCoreSphere(
        materials: [material],
        radius: 0.05,
    );
    final node = ArCoreNode(
      shape: moon,
      position: vector.Vector3(0.2,0.3,0.5),
    );

    //sphere texture model ::::::::::::::::::::::::::::::::::::

    final eamaterial = ArCoreMaterial(
      metallic: 1,
      color: Colors.blue,
      textureBytes: byteImage,
    );
    final sphere = ArCoreSphere(
      materials: [eamaterial],
      radius: double.parse(modeldes.size[0]),
    );
    final eanode = ArCoreNode(
      shape: sphere,
      position: vector.Vector3(0,0,-1),
      children: modeldes.explain=="0"?[]:[node],
    );
    arCoreController.addArCoreNode(eanode);
  }




  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }

}
