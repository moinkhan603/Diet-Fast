import 'dart:async';
import 'dart:convert';
//import 'dart:html';

import 'package:diet_fast_forward/Database/DatabaseHelper.dart';
import 'package:diet_fast_forward/Model.dart';
import 'package:diet_fast_forward/Views/tutorialView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

import '../SharedPref.dart';


class StartStopDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WatcherState();

}
//typedef Marker MarkerUpdateAction(Marker marker);

class _WatcherState extends State<StartStopDialog> {

  final dbHelper = DatabaseHelper.instance;

  String _timeString;
  String _mealString='BreakFast';

  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();

  }
//  SharedPref sharedPref = SharedPref();

  var chewNumber=32;
  var pauseTime=5;

  int bites=0;
  String totalTime='0';

  TextEditingController _chewFilter = new TextEditingController(text: '32');
  TextEditingController _pauseTimeFilter = new TextEditingController(text: '5');

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

  String stopTimeToDisplay='00:00:00';
  final dur= Duration(seconds: 1);

  Stopwatch watch= new Stopwatch();

  void startTimer(){
    Timer(dur,keepRunning);
  }
  void startTimernew(){
    Timer(dur,keepRunning);
  }

  keepRunning(){
    if(watch.isRunning){
      if (this.mounted) {
        setState(() {
          stopTimeToDisplay=
              (watch.elapsed.inMinutes%60).toString().padLeft(2,'0')+' :'' '+
                  (watch.elapsed.inSeconds%60).toString().padLeft(2,'0')+' : ' +
                  (watch.elapsed.inMilliseconds%1000).toString().padLeft(2,'0');
          if(!isNotVoice){
//            FlutterRingtonePlayer.playNotification();
            FlutterRingtonePlayer.play(
              android: AndroidSounds.notification,
              ios: IosSounds.glass,
              looping: true, // Android only - API >= 28
              volume: 1, // Android only - API >= 28
              asAlarm: false, // Android only - all APIs
            );
          }
          if(!isNotVibrate){
            Vibration.vibrate(duration: 100, amplitude: 128);
          }
        });

      }

      if(bitesPerc<100){
        calculateProgress(watch.elapsed.inSeconds);
      } else{
//        watch.start();
        calculateNewProgress(watch.elapsed.inSeconds);
      }
      startTimer();
    }
  }

  void startStopwatch(){
    if(_chewFilter.text.length!=0 && _pauseTimeFilter.text.length!=0){
      if(this.mounted){
        setState(() {

          isFinish=true;
          isReset=true;
          isPause=true;
          isStart=false;
        });
      }
      watch.start();
      startTimer();
    }

  }
  void resetStopwatch(){
    if(this.mounted){
      setState(() {
        stopTimeToDisplay='00:00:00';
        chewPerc=0.0;
        bitesPerc=0.0;
        bites=0;
        totalTime='0';
        isStart=true;
        isReset=false;
        isPause=false;
        isFinish=false;
        isResume=false;
      });
    }
    watch.stop();
    watch.reset();
  }
  void pauseStopwatch(){
    if(this.mounted){
      setState(() {
        isPause=false;
        isFinish=false;
        isResume=true;
        isReset=true;
//      resetIsPressed=false;
      });
    }
    watch.stop();
  }
  void ResumeStopwatch(){
    if(this.mounted){
      setState(() {
        isPause=true;
        isFinish=true;
        isResume=false;
        isReset=true;
//      resetIsPressed=false;
      });
    }
    watch.start();
    startTimer();
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
                      width: MediaQuery.of(context).size.width/2-25,
                      child: Text('CHEW NUMBER',style: TextStyle(color: Colors.grey,fontSize: 16),textAlign: TextAlign.center,),
                    ),

                    Container(
                      width: MediaQuery.of(context).size.width/2-25,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.only(left: 20,right: 20,),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFBe97619),width: 3,),
                      ),
                      child:TextField(
                        maxLines: 1,
                        controller: _chewFilter,
                        style: TextStyle(color: Color(0xFFBe97619),fontSize: 18,fontWeight: FontWeight.bold),
                        decoration:InputDecoration(
                            hintStyle: TextStyle(color: Color(0xFFBe97619),fontSize: 18,fontWeight: FontWeight.bold),
                            hintText: 'Default = 32'
                        ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                        autofocus: false,
                        textAlign: TextAlign.center,
                      ),
                    ),

                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width/2-25,
                      child: Text('PAUSE TIME',style: TextStyle(color: Colors.grey,fontSize: 16),textAlign: TextAlign.center,),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width/2-25,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.only(left: 20,right: 20,),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFBe97619),width: 3,),
                      ),
                      child:TextField(
                        maxLines: 1,
                        controller: _pauseTimeFilter,
                        style: TextStyle(color: Color(0xFFBe97619),fontSize: 18,fontWeight: FontWeight.bold),
                        decoration:InputDecoration(
                            hintStyle: TextStyle(color: Color(0xFFBe97619),fontSize: 18,fontWeight: FontWeight.bold),
                            hintText: 'Default = 5'
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        autofocus: false,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )
              ],
            ),
              Row(
                children: <Widget>[
                  CircularPercentIndicator(
                    radius: 230.0,
                    startAngle: 90,
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
                      startAngle: 90,
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
                            padding: EdgeInsets.all(5),
                            onPressed: startStopwatch,
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
                            padding: EdgeInsets.all(5),
                            onPressed:resetStopwatch,
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
                            padding: EdgeInsets.all(5),
                            onPressed:pauseStopwatch,
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
                            padding: EdgeInsets.all(5),
                            onPressed: _saveData,
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
                            padding: EdgeInsets.all(5),
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
                                        if(this.mounted){
                                          setState(() {
                                            if(_iconVibratorColor==Colors.black){
                                              _iconVibratorColor = Color(0xFFBe97619);
//                                              Vibration.vibrate(duration: 1000, amplitude: 128);
                                              isNotVibrate=false;
                                            }else{
//                                              Vibration.cancel();
                                              isNotVibrate=true;
                                              _iconVibratorColor = Colors.black;
                                            }

                                          });
                                        }
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width/4-3,
                                    child: IconButton(
                                      icon: Icon(Icons.ring_volume, color: _iconSpeakerColor,),
                                      onPressed: (){
                                        if(this.mounted){
                                          setState(() {

                                            if(_iconSpeakerColor==Colors.black){
                                              _iconSpeakerColor = Color(0xFFBe97619);
                                              isNotVoice=false;
//                                              FlutterRingtonePlayer.play(
//                                                android: AndroidSounds.notification,
//                                                ios: IosSounds.glass,
//                                                looping: true, // Android only - API >= 28
//                                                volume: 1, // Android only - API >= 28
//                                                asAlarm: false, // Android only - all APIs
//                                              );
                                            }else{
                                              isNotVoice=true;
//                                              FlutterRingtonePlayer.stop();
                                              _iconSpeakerColor = Colors.black;
                                            }

                                          });
                                        }
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
                                        if(this.mounted){
                                          setState(() {
                                            if(_iconVibratorColor==Colors.black){
                                              _iconVibratorColor = Color(0xFFBe97619);
//                                              Vibration.vibrate(duration: 1000, amplitude: 128);
                                              isNotVibrate=false;
                                            }else{
                                              isNotVibrate=true;
//                                              Vibration.cancel();
                                              _iconVibratorColor = Colors.black;
                                            }

                                          });
                                        }
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width/4-2,
                                    child: IconButton(
                                      icon: Icon(Icons.ring_volume, color: _iconSpeakerColor,),
                                      onPressed: (){
                                        if(this.mounted){
                                          setState(() {
                                            if(_iconSpeakerColor==Colors.black){
                                              _iconSpeakerColor = Color(0xFFBe97619);
                                              isNotVoice=false;
//                                              FlutterRingtonePlayer.play(
//                                                android: AndroidSounds.notification,
//                                                ios: IosSounds.glass,
//                                                looping: true, // Android only - API >= 28
//                                                volume: 1, // Android only - API >= 28
//                                                asAlarm: true // Android only - all APIs
//                                              );
                                            }else{
                                              isNotVoice=true;
//                                              FlutterRingtonePlayer.stop();
                                              _iconSpeakerColor = Colors.black;
                                            }


                                          });
                                        }
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
                                  child: Text(bites.toString()))
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
                                  child: Text(totalTime.toString()))
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


  _saveData() {

    watch.stop();

    DateFormat dateFormat = new DateFormat.Hms();

    DateTime bOpen = dateFormat.parse("03:00:01");
    DateTime bClose = dateFormat.parse("12:00:00");
    DateTime lOpen = dateFormat.parse("12:00:01");
    DateTime lClose = dateFormat.parse("18:00:00");
    DateTime now = dateFormat.parse(_timeString);

    if(now.isAfter(bOpen)&&now.isBefore(bClose)){
      _mealString='Breakfast';
    }else if(now.isBefore(lClose)&&now.isAfter(lOpen)){
      _mealString='Lunch';
    }else{
      _mealString='Supper';
    }


    String time = _timeString;
    String meal = _mealString;
    String abites = bites.toString();
    String atotalTime = totalTime;

    setState(() {
      _insert(time,meal,abites,atotalTime);
    });
  }

  void calculateProgress(int inSeconds) {
    int value=int.parse(_chewFilter.text);
    if(bitesPerc<100){
      bitesPerc=inSeconds/value*100;
    }else{
//      watch.stop();
      bitesPerc=100;
    }
  }

  void calculateNewProgress(int inSeconds) {
    int value=int.parse(_pauseTimeFilter.text);
    if(chewPerc<100){
      chewPerc=(inSeconds-int.parse(_chewFilter.text))/value*100;
    }else{
      chewPerc=100;
      watch.stop();
      resetCycleStopwatch();
      startStopwatch();
    }
  }

  void resetCycleStopwatch(){
    if(this.mounted){
      setState(() {
        totalTime=stopTimeToDisplay;
        stopTimeToDisplay='00:00:00';
        chewPerc=0.0;
        bitesPerc=0.0;
        bites=bites+1;
        isStart=false;
        isReset=true;
        isPause=true;
        isFinish=true;
        isResume=false;
        totalTime=totalTime;

      });
    }
//    watch.stop();
    watch.reset();
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-ddThh:mm:ss').format(dateTime);
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    if(this.mounted){
      setState(() {
        List<String> separated= formattedDateTime.split('T');
        _timeString = separated[1];
      });
    }
  }

  void _insert(String a,String b,String c,String d) async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnTime : a,
      DatabaseHelper.columnMeal  : b ,
      DatabaseHelper.columnBites  : c ,
      DatabaseHelper.columnTotalTime  : d ,
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
    print('inserted row is: ${row.toString()}');

    Navigator.pop(context);

  }


}