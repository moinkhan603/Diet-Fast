import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class tutorialView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WatcherState();

}
//typedef Marker MarkerUpdateAction(Marker marker);

class _WatcherState extends State<tutorialView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      
      body: GestureDetector(
        onTap: (){
          Navigator.pop(context,true);
        },
        child: Image.asset(
          
          'assets/images/tutorial_3.jpg',
          //fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
      )
    );
  }
}