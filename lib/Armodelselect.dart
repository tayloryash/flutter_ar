mport 'package:camera/camera.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'arviewpage.dart';

class Armodelselect extends StatefulWidget {

  @override
  _ArmodelselectState createState() => _ArmodelselectState();
}

class _ArmodelselectState extends State<Armodelselect> {
  int _cameraOcr = 0;
  //String _textValue = "sample";
  String position = "";
  bool vision = false;
  bool showwords = true;
  bool search=false;
  String searchtext;
  bool flash=false;
  List<OcrText> scannedwords = [];
  var DATA,DATA2,DATA3;
  final databasepost=FirebaseDatabase.instance.reference();
  final databasepost1=FirebaseDatabase.instance.reference();
  OcrText selected;


  @override
  void initState() {
    getdata();
    FlutterMobileVision.start().then((x) =>
        setState(() {
          vision = true;
        }));
    super.initState();
  }

  Future<List<OcrText>> _getwords() async {
    return scannedwords;
  }

  Future<bool> _onWillPop() async {
    SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Container(
        height: MediaQuery.of(context).size.height - 185.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
        ),
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.transparent,
                expandedHeight: 100,
                floating: false,
                pinned: false,
                automaticallyImplyLeading: false,
                flexibleSpace: FlexibleSpaceBar(
                  background:  Row(
                             mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    decoration:BoxDecoration(
                                      color: Colors.grey[100],
                                      border: Border.all(
                                          color: Colors.blue,
                                          width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      boxShadow: [BoxShadow(blurRadius: 5,color: Colors.black54,offset: Offset(1,3))],
                                    ),
                                    child: IconButton(
                                      icon: Icon(Icons.refresh,color: Colors.blue[500],),
                                      onPressed: (){
                                        setState(() {
                                          getdata();
                                        });
                                      },
                                    ),
                                  ),
                                ),
                               Visibility(
                                 visible:!search,
                                 child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                     decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                          border: Border.all(
                                                color: Colors.blue,
                                                width: 1.0),
                                                borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                                boxShadow: [BoxShadow(blurRadius: 5,color: Colors.black54,offset: Offset(1,3))],
                                                ),
                                                  child: IconButton(
                                                  icon: Icon(Icons.camera_alt,color: Colors.blue[500],),
                                                  onPressed: (){
                                                    camerarefresh();
                                                    },
                                                    ),
                                                    ),
                                                    ),
                               ),
                                                  Visibility(
                                                    visible: !search,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                        child: Container(
                                                          decoration:BoxDecoration(
                                                          color: Colors.grey[100],
                                                          border: Border.all(
                                                          color: Colors.blue,
                                                          width: 1.0),
                                                            borderRadius: BorderRadius.all(
                                                             Radius.circular(5.0)),
                                                             boxShadow: [BoxShadow(blurRadius: 5,color: Colors.black54,offset: Offset(1,3))],
                                                             ),
                                                              child:IconButton(
                                                                  icon: Icon(flash?Icons.flash_on:Icons.flash_off),
                                                                   color: Colors.blue,
                                                                   onPressed: () {
                                                                    setState(() {
                                                                       if(flash){
                                                                        flash=false;
                                                                        }
                                                                        else{
                                                                        flash=true;
                                                                        }
                                                                        });
                                                                  },
                                                                  ),
                                                                  ),),
                                                  ),
                                                  Visibility(
                                                    visible: !search,
                                                    child: Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                        child: Container(
                                                          decoration:BoxDecoration(
                                                          color: Colors.grey[100],
                                                          border: Border.all(
                                                          color: Colors.blue,
                                                          width: 1.0),
                                                            borderRadius: BorderRadius.all(
                                                            Radius.circular(5.0)),
                                                            boxShadow: [BoxShadow(blurRadius: 5,color: Colors.black54,offset: Offset(1,3))],
                                                            ),
                                                            child: IconButton(
                                                            icon: Icon(Icons.list,color: Colors.blue[500],),
                                                            onPressed: (){
                                                            setState(() {
                                                            if(showwords){
                                                            showwords=false;
                                                        }
                                                        else{
                                                        showwords=true;
                                                        }
                                                        });
                                                        },
                                                        ),
                                                        ),
                                                        ),
                                                  ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    decoration:BoxDecoration(
                                      color: Colors.grey[100],
                                      border: Border.all(
                                          color: Colors.blue,
                                          width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      boxShadow: [BoxShadow(blurRadius: 5,color: Colors.black54,offset: Offset(1,3))],
                                    ),
                                    child: IconButton(
                                      icon: Icon(Icons.search,color: Colors.blue[500],),
                                      onPressed: (){
                                        setState(() {
                                          if(search){
                                            search=false;
                                          }
                                          else{
                                            search=true;
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: search,
                                  child: Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: TextField(
                                          decoration: InputDecoration(
                                              labelText: "Keyword",
                                              border: OutlineInputBorder()
                                          ),
                                          onChanged: (text) {
                                            setState(() {
                                             searchtext=text;
                                            });
                                          }
                                      ),
                                    ),
                                  ),
                                ),

                              ]),
                                                          ),
                                                        )
                                                      ];
          },
          body:Container(
            padding: EdgeInsets.fromLTRB(50, 10, 0, 0),
            child: FutureBuilder(
                future: _getwords(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(search){
                    return Center(
                      child: RaisedButton(
                        color: Color(0xFF21BFBD),
                        onPressed: (){
                          searchbutton(searchtext);
                        },
                        child: Text("Build Model"),
                      ),
                    );
                  }
                  else if (scannedwords.length == 0 || !showwords) {
                    return Container();
                  }
                  /*
                  else if(scannedwords.length==1){
                    wordselected(scannedwords[0]);
                    return Container();
                  }
                  */
                  else {
                    return Container(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: scannedwords.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: (){
                                  wordselected(scannedwords[index]);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    border: Border.all(
                                        color: Colors.blue,
                                        width: 2.0),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5.0)),
                                    boxShadow: [BoxShadow(blurRadius: 5,color: Colors.black54,offset: Offset(1,3))],
                                  ),
                                  padding: EdgeInsets.all(10),
                                  child: Center(child: Text(processword(scannedwords[index].value.toString(),),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 30,
                                    ),),),
                                ),
                              ),
                            );
                          }),
                    );
                  }
                }
            ),
          ),
        ),
      ),
    );
  }
  //functions:::::::::::::::
  Future<void> camerarefresh() async{
      _read();
  }


  //read live words from camera
  _read() async {
    try {
      print(" $_cameraOcr");
      scannedwords = await FlutterMobileVision.read(
        camera: 0,
        flash: flash,
        waitTap: true,
        autoFocus: true,
        multiple: true,
        showText: true,
        fps: 30,
      );

      Future.delayed(Duration(seconds: 1), () {
        setState(() {

        });
      });
    } catch (e) {
      showToast("failed to recognize text");
    }
  }

  //method when ocr word list is shown
  Future<void> wordselected(OcrText word) async{
    String name=word.value.toString().toLowerCase();
    if(!checkname(name, DATA2['available'])){
      showToast("Ar data not available check after sometime");
      changerequestword(name,DATA2['requested']);
    }else{
      print("${DATA[name]['image']}");
      objmodel modeldes=new objmodel(name,DATA[name]['size'].toString().split(","),DATA[name]['image'] ,DATA[name]['explain'], DATA[name]['type']);
      Future.delayed(Duration(seconds: 2), () {
        vision=false;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => arviewpage(modeldes),),
        );});
    }

  }

  //for search keyword button method implementation
  Future<void> searchbutton(String word) async{
    String name=word.toLowerCase();
    print(DATA[0]);
    if(!checkname(name, DATA2['available'])){
      showToast("Ar data not available check after sometime");
      changerequestword(name,DATA2['requested']);
    }else {
      print("image${DATA[name]['image']}");
      objmodel modeldes=new objmodel(name,DATA[name]['size'].toString().split(","),DATA[name]['image'] , DATA[name]['explain'],DATA[name]['type']);
      Future.delayed(Duration(seconds: 2), () {
        vision=false;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => arviewpage(modeldes),),
        );});
    }
  }

  //check if the word exist in the available,requested word list
  bool checkname(String word,String list){
    var listc=list.split(",");
    for(int i=0;i<listc.length;i++){
      if(listc[i]==word){
        return true;
      }
    }
    return false;
  }

  //make wordfrequency change request to firebase database
  changerequestword(String word,String list){
    if(checkname(word, list)){
      int count=int.parse(DATA3[word]);
      count=count+1;
      databasepost.child("wordfrequency").update({
        "$word":"$count",
      });
    }else{
      databasepost.child("wordfrequency").update({
        "$word":"1",
      });
      if(list==""){
        databasepost1.child("wordlist").update({
          "requested":"${word}",
        });
      }
      else{
        databasepost1.child("wordlist").update({
          "requested":"${list},${word}",
        });
      }

    }
  }

  String processword(String word){
    String postword="";
    word.runes.forEach((int rune) {
      var character = new String.fromCharCode(rune);
      if(character==" "){
        postword=postword+" ";
      }
      else{
        postword=postword+character;
      }
    });
    var w=postword.split("\n");
    postword="";
    for(int i=0;i<w.length;i++){
      postword=postword+w[i]+" ";
    }
    return postword.trim();
  }

  //toast method
  void showToast(String text) {
    Toast.show(text, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
  }

  //get url for image from database
  Future<void> getdata() async{
    DatabaseReference reference= await FirebaseDatabase.instance.reference().child("datamodel");
    reference.once().then((DataSnapshot snap){
      DATA=snap.value;
    });
    DatabaseReference reference2= await FirebaseDatabase.instance.reference().child("wordlist");
    reference2.once().then((DataSnapshot snap){
      DATA2=snap.value;
    });
    DatabaseReference reference3= await FirebaseDatabase.instance.reference().child("wordfrequency");
    reference3.once().then((DataSnapshot snap){
      DATA3=snap.value;
    });

  }
}

class objmodel{
  var size;
  String name,img_url,type,explain;
  objmodel(this.name,this.size,this.img_url,this.explain,this.type);
}
