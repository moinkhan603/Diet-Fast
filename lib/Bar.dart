import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';

class Bar extends StatelessWidget {
  final double height;
  final String label;
  final String value;

  final int _baseDurationMs = 1000;
  final double _maxElementHeight = 150;

  Bar(this.height, this.label,this.value);

  @override
  Widget build(BuildContext context) {
    return ControlledAnimation(
      duration: Duration(milliseconds: (height * _baseDurationMs).round()),
      tween: Tween(begin: 0.0, end: height),
      builder: (context, animatedHeight) {
        return Column(
          children: <Widget>[
            Text(value,style: TextStyle(color: Colors.black),),
//            Container(
//              height: (1 - animatedHeight) * _maxElementHeight,
//            ),
            Container(
              width: 30,
              margin: EdgeInsets.only(left: 8,right: 8),
              height: animatedHeight * _maxElementHeight,
              color: Color(0xFFBe97619),
            ),
            Text(label)
          ],
        );
      },
    );
  }
}