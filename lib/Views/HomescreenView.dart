import 'dart:async';
import 'dart:ui';

import 'package:diet_fast_forward/NavBars/ChewBar.dart';
import 'package:diet_fast_forward/NavBars/ComingSoon.dart';
import 'package:diet_fast_forward/NavBars/FatBurnBar.dart';
import 'package:diet_fast_forward/NavBars/HomeBar.dart';
import 'package:diet_fast_forward/NavBars/NineFactorBar.dart';
import 'package:diet_fast_forward/NavBars/TodayBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class HomescreenView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();

}
//typedef Marker MarkerUpdateAction(Marker marker);

class _HomeState extends State<HomescreenView> {

  int _currentIndex = 2;
  final List<Widget> _children = [
    ComingSoon(),
    NineFactorBar(),
    HomeBar(),
    ChewBar(),
    FatBurnBar(),
  ];



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: _children[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(

        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.today,color: Colors.grey,),
            activeIcon: new Icon(Icons.today,color: Colors.black,),
            title: new Text('Today',style: TextStyle(color: Colors.black)),
          ),
          BottomNavigationBarItem(
            icon: new Image.asset('assets/images/nine_factor.png',color: Colors.grey,),
            activeIcon: new Image.asset('assets/images/nine_factor.png',color: Colors.black,),
            title: new Text('Nine Factor',style: TextStyle(color: Colors.black),),
          ),
          BottomNavigationBarItem(
              icon: new Icon(Icons.home,color: Colors.grey,),
              activeIcon: new Icon(Icons.home,color: Colors.black,) ,
              title: Text('Home',style: TextStyle(color: Colors.black))
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.face,color: Colors.grey,),
            activeIcon: new Icon(Icons.face,color: Colors.black,),
            title: new Text('Chew',style: TextStyle(color: Colors.black)),
          ),
          BottomNavigationBarItem(
              icon: new Icon(Icons.directions_run,color: Colors.grey,),
              activeIcon: new Icon(Icons.directions_run,color: Colors.black,),
              title: Text('Fat Burn',style: TextStyle(color: Colors.black)),
          ),
          BottomNavigationBarItem(
              icon: new Icon(Icons.live_help,color: Colors.grey,),
              activeIcon: new Icon(Icons.live_help,color: Colors.black,),
              title: Text('Support',style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
  void onTabTapped(int index) {
    if(index==5){
      _launchSupport();
    }
    else{
      setState(() {
        _currentIndex = index;
      });
    }
  }

  _launchSupport() async {
    String url='https://dietfastforward.com/support';
    if (await canLaunch(url)) {
    await launch(url);
    } else {
    throw 'Could not launch $url';
    }
  }

}