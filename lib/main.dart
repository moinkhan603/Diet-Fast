import 'dart:async';
import 'package:diet_fast_forward/Views/HomescreenView.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
//    delay;
    // TODO: implement build
    return MaterialApp(

      home: HomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.white),
    );

  }


}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {




  @override
  Widget build(BuildContext context) {
    _delay();

    // TODO: implement build
    return Scaffold(
        body: Center(
          child:Image.asset('assets/images/splash_image.jpeg',fit: BoxFit.fill,),
        )
    );
  }
  _delay(){
    new Future.delayed(new Duration(seconds: 3), ()
    {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomescreenView()));
    });
  }


}