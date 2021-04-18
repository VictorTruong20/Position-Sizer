import "package:flutter/material.dart";
import "./pages/onBoardingPage.dart";
import "package:flutter/services.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return MaterialApp(
      title:"Position Size Calculator",
      home: Home() ,
      debugShowCheckedModeBanner: false,
    );
  }
}

