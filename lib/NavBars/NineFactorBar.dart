import 'dart:convert';

import 'package:diet_fast_forward/Views/FactorDetailView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NineFactorBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NineFactorBarState();
}

class _NineFactorBarState extends State<NineFactorBar> {
//  List data;
//  String json;

List images= List();
List titles= List();
List durations= List();
List times= List();

  @override
  void initState() {
    super.initState();
    addData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
//            Container(
//                    margin: EdgeInsets.only(top:20,right: double.infinity),
//              child: IconButton(
//
//              icon: Icon(Icons.arrow_back,size: 35,),
//              onPressed: (){
//                SystemNavigator.pop();
//              },
//            )
//
//
//                    //: Icon(Icons.arrow_back)
//                    //child: Text(_timeString,style: TextStyle(fontSize: 22,color: Color(0xFFBe97619),fontWeight: FontWeight.bold),),
//                  ),
          Container(
            padding: EdgeInsets.only(top: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(right: 10),
                    child: Image.asset(
                      'assets/images/forwardbutton.png',
                      width: 70,
                      height: 70,
//                        fit:BoxFit.fill
                    )),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Image.asset(
                    'assets/images/ninfactorimage.png',
                    width: 180,
                    height: 150,
                  ),
                )
              ],
            ),
          ),
            Expanded(
              child: _getTile(),
            )

          ]
        )
      )
    );
  }

  _getTile() {
    return ListView.builder(itemCount: 9 ,itemBuilder: (BuildContext context,int position){
      return Card(
        color:  Color(0xFFBe97619),
          child: InkWell(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => FactorDetailView(imgPath: images[position],name: titles[position],duration: durations[position],time:  times[position],)));},
            child: ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Image.asset(
                  'assets/images/${images[position]}',
                ),
              ),
              title: Text(
                titles[position],
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    durations[position],
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "Next reminder on : ",
                    style: TextStyle(color: Colors.white),
                  ),
//          Text("Breath Fresh Air",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                ],
              ),
              trailing: Column(
//            mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
//                padding: EdgeInsets.only(top: 7),
                    child: Text('Time period set',
                      style: TextStyle(color: Colors.white),),
                  ),
                  Container(
//                padding: EdgeInsets.only(top: 5,bottom: 5),
                    child: Text(
                      times[position], style: TextStyle(color: Colors.white),),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text('Edit', style: TextStyle(color: Colors.white),),
                      Icon(Icons.edit, color: Colors.white,)
                    ],
                  )
                ],
              ),
            ),
          )
      );
    });

  }

  void addData() {
//    1
    images.add('breath_image.png');
    titles.add('Breath Fresh Air');
    durations.add('At least 30 minutes a day');
    times.add('14:30 - 15:00');
//    2
    images.add('sleep_image.png');
    titles.add('Good Night Sleep');
    durations.add('At least 7-8 hours a day');
    times.add('22:30 - 06:00');
//    3
    images.add('water_image.png');
    titles.add('Drink Fresh Water');
    durations.add('A glass every 2 hours');
    times.add('07:00 - 20:00');
//    4
    images.add('fitness_image.png');
    titles.add('Physical Activity');
    durations.add('At least 3 times per week');
    times.add('18:30 - 19:30');
//    5
    images.add('diet.png');
    titles.add('Eat Healthy Food');
    durations.add('Optimal 3 meals a day');
    times.add('10:30 - 21:00');
//    6
    images.add('sun_image.png');
    titles.add('Go out in the Sun');
    durations.add('At least 30 minutes a day');
    times.add('12:00 - 12:30');
//    7
    images.add('beliefg.png');
    titles.add('Belief is essential');
    durations.add('At least 30 minutes a day');
    times.add('22:00 - 22:30');
//    8
    images.add('tech_image.png');
    titles.add('Use the TECH');
    durations.add('Measure once a day');
    times.add('07:00 - 07:05');
//    9
    images.add('control_image.png');
    titles.add('Control is Power');
    durations.add('Learn a new good habit');
    times.add('08:00 - 21:15');
  }
}
