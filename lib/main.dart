import 'dart:async';

import 'package:ar_app/arviewpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';
import 'package:toast/toast.dart';
import 'package:ar_app/homepage.dart';

Future<void> main() async {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  void initState() {
    super.initState();
    gotohome();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    );
  }

  Future<void> gotohome() async {
    Future.delayed(Duration(seconds: 0), () {Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => homepage(),),
    );});
  }


}

