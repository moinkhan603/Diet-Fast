import 'dart:async';

import 'package:diet_fast_forward/NavBars/ChewBar.dart';
import 'package:diet_fast_forward/NavBars/ComingSoon.dart';
import 'package:diet_fast_forward/NavBars/FatBurnBar.dart';
import 'package:diet_fast_forward/NavBars/NineFactorBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeBar extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => _HomeBarState();


}

class _HomeBarState extends State<HomeBar> {

  String _timeString;


  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 60,left: 20,right: 20),
              child: Stack(
                children: <Widget>[
 

                  Container(
                  //  margin: EdgeInsets.only(top:5,left: 10),
                    child: Text(_timeString,style: TextStyle(fontSize: 22,color: Color(0xFFBe97619),fontWeight: FontWeight.bold),),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Column(
                      children: <Widget>[
                        Image.asset('assets/images/settings_icon.png',color: Colors.grey,),
                        Text('SETTINGS',style: TextStyle(color: Colors.grey,),)
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
                margin:EdgeInsets.only(left: 20,right: 20,top: 30),
                child:Card(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 10,right: 10),
                        child: Image.asset('assets/images/welcome_image.jpeg'),
                      ),
                      GestureDetector(
                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => NineFactorBar()));},
                        child: Image.asset('assets/images/factors_image.png'),
                      ),
                      GestureDetector(
                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ChewBar()));},
                        child: Container(
                          padding: EdgeInsets.only(top: 30,bottom: 15),
                          child: Image.asset('assets/images/chewing_count.png'),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => FatBurnBar()));},
                        child: Container(
                          padding: EdgeInsets.only(top: 15,bottom: 15),
                          child: Image.asset('assets/images/fat_burn.png'),
                        ),
                      ),
                    ],
                  ),
                )

            ),
          ],
        ),
      ),
    );
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm:ss').format(dateTime);
  }

}
