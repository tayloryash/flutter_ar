import 'package:ar_app/Armodelselect.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';
import 'package:ar_app/arviewpage.dart';

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();

}

class _homepageState extends State<homepage> {
  @override
  void initState() {
    super.initState();
  }

  Future<bool> _onWillPop() async {
    SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Color(0xFF21BFBD),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 15.0, left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      color: Colors.white,
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25.0),
              Padding(
                padding: EdgeInsets.only(left: 40.0),
                child: Row(
                  children: <Widget>[
                    Text('X',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 45.0)),
                    Text('perience',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 45.0)),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              Armodelselect(),
            ],
          ),
        ),
      ),
    );
  }

//functions:::::::::::::::
  void showToast(String text) {
    Toast.show(text, context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
  }
}
