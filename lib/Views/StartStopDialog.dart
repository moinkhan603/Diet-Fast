import 'dart:async';
import 'dart:convert';

import 'package:diet_fast_forward/Model.dart';
import 'package:diet_fast_forward/Views/tutorialView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../SharedPref.dart';


class StartStopDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WatcherState();

}
//typedef Marker MarkerUpdateAction(Marker marker);

class _WatcherState extends State<StartStopDialog> {

  String _timeString='';
  String _mealString='BreakFast';

  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();

    loadSharedPrefs();
    FlutterRingtonePlayer.playNotification();
  }
  SharedPref sharedPref = SharedPref();

  var chewNumber=32;
  var pauseTime=5;

  TextEditingController _chewFilter = new TextEditingController();
  TextEditingController _pauseTimeFilter = new TextEditingController();

  List dataList = new List();

  var bitesPerc=0.0;
  var chewPerc=0.0;

  TextEditingController _bitesFilter = new TextEditingController();
  TextEditingController _totalTimeFilter = new TextEditingController();


  bool isNotVibrate=true;
  bool isNotVoice=true;


  bool isStart=true;
  bool isReset=false;
  bool isPause=false;
  bool isFinish=false;
  bool isResume=false;

  Color _iconVibratorColor = Colors.black;
  Color _iconSpeakerColor = Colors.black;


  bool startIsPressed = false;
  bool pauseIsPressed = false;
  bool resetIsPressed = false;
  bool finishIsPressed = false;
  bool ResumeIsPressed = false;
  String stopTimeToDisplay='00:00:00';
  final dur= Duration(milliseconds: 10);

  Stopwatch watch= new Stopwatch();

  void startTimer(){
    Timer(dur,keepRunning);
  }
  void startTimernew(){
    Timer(dur,keepRunning);
  }

  keepRunning(){
    if(watch.isRunning){
      setState(() {
        stopTimeToDisplay=
            (watch.elapsed.inMinutes%60).toString().padLeft(2,'0')+' :'' '+
                (watch.elapsed.inSeconds%60).toString().padLeft(2,'0')+' : ' +
                (watch.elapsed.inMilliseconds%1000).toString().padLeft(2,'0');
      });

      calculateProgress(watch.elapsed.inSeconds);
      if(bitesPerc>=100){
        watch.start();
        calculateNewProgress(watch.elapsed.inSeconds);
      }
      startTimer();
    }
  }

  void startStopwatch(){
    setState(() {

      finishIsPressed=false;

      isFinish=true;
      isReset=true;
      isPause=true;
      isStart=false;
    });
    watch.start();
    startTimer();
  }
//  void pauseStopwatch(){
//    setState(() {
//      isPause=true;
//      isFinish=true;
//    });
//    watch.stop();
//  }
  void resetStopwatch(){
    setState(() {
      stopTimeToDisplay='00:00:00';
      chewPerc=0.0;
      isStart=true;
      isReset=false;
      isPause=false;
      isFinish=false;
      isResume=false;
    });
    watch.stop();
    watch.reset();
  }
  void PauseStopwatch(){
    setState(() {
      isPause=false;
      isFinish=false;
      isResume=true;
      resetIsPressed=false;
    });
    watch.stop();
  }
  void ResumeStopwatch(){
    setState(() {
      isPause=true;
      isFinish=true;
      isResume=false;
      resetIsPressed=false;
    });
    watch.start();
  }




  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      body:SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 5,top: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      child: Text('CHEW NUMBER',style: TextStyle(color: Colors.grey,fontSize: 16),),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.only(left: 30,right: 30,top: 10,bottom: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFBe97619),width: 3,),
                      ),
                      child:TextField(
                        controller: _chewFilter,
                        decoration: InputDecoration(hintText: 'Default = 32'),
                        textAlign: TextAlign.center,),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text('PAUSE TIME',style: TextStyle(color: Colors.grey,fontSize: 16),),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.only(left: 35,right: 35,top: 10,bottom: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFBe97619),width: 3,),
                      ),
                      child:TextField(
                        controller: _pauseTimeFilter,
                        decoration: InputDecoration(hintText: 'Default = 5'),
                        textAlign: TextAlign.center,),
                    )
                  ],
                )
              ],
            ),
              Row(
                children: <Widget>[
                  CircularPercentIndicator(
                    radius: 230.0,
                    lineWidth: 7.0,
                    percent: bitesPerc/100,
                    center: Text(bitesPerc.toString()+"%",style: TextStyle(color: Color(0xFFBe97619),fontSize: 20),),
                    progressColor:  Color(0xFFBe97619),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: CircularPercentIndicator(
                      radius: 100.0,
                      lineWidth: 7.0,
                      percent: chewPerc/100,
                      center: Text(chewPerc.toString()+"%",style: TextStyle(color: Color(0xFFBe97619),fontSize: 20),),
                      progressColor:  Color(0xFFBe97619),
                    ),
                  ),
                ],
              ),
             Container(
               padding: EdgeInsets.all(20),
               child:  Text(stopTimeToDisplay,style: TextStyle(fontSize: 40,color: Color(0xFFBe97619),fontWeight: FontWeight.w700),),
             ),

              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Visibility(
                        visible: isStart,
                        child: Container(
                          margin: EdgeInsets.only(left: 5,right: 5),
                          child: RaisedButton(
                            onPressed: startIsPressed ? null : startStopwatch,
                            color: Color(0xFFBe97619),
                            child: Text('START',style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: isReset,
                        child: Container(
                          margin: EdgeInsets.only(left: 5,right: 5),
                          child: RaisedButton(
                            onPressed: resetIsPressed ? null : resetStopwatch,
                            color: Color(0xFFBe97619),
                            child: Text('RESET',style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: isPause,
                        child: Container(
                          margin: EdgeInsets.only(left: 5,right: 5),
                          child: RaisedButton(
                            onPressed: pauseIsPressed ? null : PauseStopwatch,
                            color: Color(0xFFBe97619),
                            child: Text('PAUSE',style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: isFinish,
                        child: Container(
                          margin: EdgeInsets.only(left: 5,right: 5),
                          child: RaisedButton(
//                            onPressed: _saveData,
                            color: Color(0xFFBe97619),
                            child: Text('FINISH',style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: isResume,
                        child: Container(
                          margin: EdgeInsets.only(left: 5,right: 5),
                          child: RaisedButton(
                            onPressed: ResumeStopwatch,
                            color: Color(0xFFBe97619),
                            child: Text('RESUME',style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Container(
                    padding: EdgeInsets.only(top: 20,bottom: 20),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width/2-3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Bites Paused',style: TextStyle(fontSize: 20,color: Color(0xFFBe97619)),),
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width/4-2,
                                    child: IconButton(
                                      icon: Icon(Icons.vibration, color: _iconVibratorColor,),
                                      onPressed: (){
                                        setState(() {
                                          if(_iconVibratorColor==Colors.black){
                                            _iconVibratorColor = Color(0xFFBe97619);
                                          }else{
                                            _iconVibratorColor = Colors.black;
                                          }

                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width/4-3,
                                    child: IconButton(
                                      icon: Icon(Icons.ring_volume, color: _iconSpeakerColor,),
                                      onPressed: (){
                                        setState(() {

                                          if(_iconSpeakerColor==Colors.black){
                                            _iconSpeakerColor = Color(0xFFBe97619);
                                            FlutterRingtonePlayer.play(
                                              android: AndroidSounds.notification,
                                              ios: IosSounds.glass,
                                              looping: true, // Android only - API >= 28
                                              volume: 1, // Android only - API >= 28
                                              asAlarm: false, // Android only - all APIs
                                            );
                                          }else{
                                            FlutterRingtonePlayer.stop();
                                            _iconSpeakerColor = Colors.black;
                                          }

                                        });
                                      },
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/2-2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Chewing',style: TextStyle(fontSize: 20,color: Color(0xFFBe97619)),),
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width/4-2,
                                    child: IconButton(
                                      icon: Icon(Icons.vibration, color: _iconVibratorColor,),
                                      onPressed: (){
                                        setState(() {
                                          if(_iconVibratorColor==Colors.black){
                                            _iconVibratorColor = Color(0xFFBe97619);
                                          }else{
                                            _iconVibratorColor = Colors.black;
                                          }

                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width/4-2,
                                    child: IconButton(
                                      icon: Icon(Icons.ring_volume, color: _iconSpeakerColor,),
                                      onPressed: (){
                                        setState(() {
                                          if(_iconSpeakerColor==Colors.black){
                                            _iconSpeakerColor = Color(0xFFBe97619);
                                          }else{
                                            _iconSpeakerColor = Colors.black;
                                          }

                                        });
                                      },
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20,bottom: 20),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width/2-3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Total Bites',style: TextStyle(fontSize: 20,color: Color(0xFFBe97619)),),
                              Container(
                                  margin: EdgeInsets.only(top: 10,bottom: 10),
                                  child: Text('0'))
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/2-3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Total Time',style: TextStyle(fontSize: 20,color: Color(0xFFBe97619)),),
                              Container(
                                  margin: EdgeInsets.only(top: 10,bottom: 10),
                                  child: Text('0'))
                            ],
                          ),
                        )

                      ],
                    ),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width-5,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: RaisedButton(
                        onPressed:(){Navigator.push(context, MaterialPageRoute(builder: (context) => tutorialView()));},
                        padding: EdgeInsets.only(left: 20,right: 20,bottom: 10,top: 10),
                        color: Color(0xFFBe97619),
                        child: Text('Tutorial',style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  )
                ],
              ),
            ],
          )
        )
      )
    );
  }



//  _stopwatch(){
//    return
//  }


  _saveData() {
    String time = _timeString;
    String meal = _mealString;
    String bites = '0';
    String totalTime = '0';

    print('time is '+'$time');

    Model model = new Model(time, meal, bites, totalTime);
    var object = model.toJson();

    print("modelData"+object.toString());

    dataList.add(object);

    sharedPref.save('newList', dataList);
    Navigator.pop(context);

    loadSharedPrefs();
    
  }
  loadSharedPrefs(){
    try {
      List list = new List( sharedPref.read('newList'));
//      Scaffold.of(context).showSnackBar(SnackBar(
//          content: new Text("Loaded!"),
//          duration: const Duration(milliseconds: 500)));
      setState(() {
        dataList = list;
        print('DataList'+list.toString());
      });


    } catch (Excepetion) {
//      Scaffold.of(context).showSnackBar(SnackBar(
//          content: new Text("Nothing found!"),
//          duration: const Duration(milliseconds: 500)));
    }
  }

  void calculateProgress(int inSeconds) {
    if(bitesPerc<100){
      bitesPerc=inSeconds/chewNumber*100;
    }else{
      watch.stop();
      bitesPerc=100;
    }
  }

  void calculateNewProgress(int inSeconds) {
    if(chewPerc<100){
      chewPerc=inSeconds/pauseTime*100;
    }else{
      watch.stop();
      chewPerc=100;
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm:ss').format(dateTime);
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }


}