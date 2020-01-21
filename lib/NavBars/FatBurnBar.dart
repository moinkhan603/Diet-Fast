import 'dart:async';
//import 'dart:html';

import 'package:diet_fast_forward/Views/SuggestionsView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Bar.dart';

class FatBurnBar extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _FatBurnBarState();

//  final List<charts.Series> seriesList;
//  final bool animate;
//
//  GroupedFillColorBarChart(this.seriesList, {this.animate});
//
//  factory GroupedFillColorBarChart.withSampleData() {
//    return new GroupedFillColorBarChart(
//      _createSampleData(),
//      // Disable animations for image tests.
//      animate: false,
//    );
//  }

}

class _FatBurnBarState extends State<FatBurnBar> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String _timeString;
  String _changeKetosis="Change Ketosis no";

  bool imgVis=true;
  bool barvis=false;

  double max=1;


  TextEditingController _firstFilter = new TextEditingController();
  TextEditingController _secondFilter = new TextEditingController();
  String _first = "";
  String _second = "";



  _CheckState() {
    _firstFilter.addListener(_firstListen);
    _secondFilter.addListener(_secondListen);
  }
  void _firstListen() {
    _CheckPressed();
  }

  void _secondListen() {
    _CheckPressed();
  }


  @override
  void initState() {
    _CheckState();
//    _CheckPressed();
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
//          margin: EdgeInsets.only(left: 20,right: 20,bottom: 20,top: 20),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 30,left: 30,right: 30),
                child: Text(_timeString,style: TextStyle(fontSize: 22,
                    color: Color(0xFFBe97619),
                    fontWeight: FontWeight.bold),),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Card(
                  child: Container(
                    padding: EdgeInsets.only(top: 30,bottom: 30),
                      child:Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.only(right: 10),
                                  child:Image.asset('assets/images/forwardbutton.png',
                                    width: 70,
                                    height: 70,
                                  )
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Image.asset('assets/images/ninfactorimage.png',
                                  width: 180,
                                  height: 150,
                                ),
                              )
                            ],
                          ),
                          Visibility(
                            visible: imgVis,
                            child: Container(
                              margin: EdgeInsets.only(top: 30),
                              child: Image.asset('assets/images/diet_fast_forward.png'),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Visibility(
                              visible: barvis,
                              child:Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  _barsData(max),
                                ],
                              ),
//                              SfCartesianChart(
//                                  zoomPanBehavior: ZoomPanBehavior(enablePanning: true),
//                                  legend: Legend(
//                                      position: LegendPosition.bottom,
//                                      borderColor: Colors.white,
//                                      borderWidth: 0),
//                                  primaryXAxis: NumericAxis(
//                                    visibleMinimum: 0,
//                                    visibleMaximum: max+2,
//                                  ),
//                                  primaryYAxis: NumericAxis(
//                                    labelStyle: ChartTextStyle(color: Colors.black),
//                                  ),
//                                  series: getRandomData(max)),
                            ),
                          ),


                        ],
                      )
                  ),
                )
              ),


              Container(
                padding: EdgeInsets.all(20),
                child: Card(
                  child: Container(
//                    margin: EdgeInsets.all(20),
//                  padding: EdgeInsets.all(20),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width:130,
                          height: 180,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text('Ketosis',style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.bold),),
                              Stack(
                                children: <Widget>[
                                  Image.asset('assets/images/ketosis.jpeg'),
                                  Center(
                                    heightFactor: 2.6,
//                                    widthFactor: 5,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(left: 10),
                                          width: 20,
                                          height: 30,
                                          child: TextField(
//                                            onChanged: ,
                                            controller: _firstFilter,
                                              style: new TextStyle(
                                                  fontSize: 28.0,
//                                                  height: 2.0,
//                                                  color: Colors.black
                                              ),
//                                              validator: Validators.min(8, 'Value less than 8 not allowed'),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintStyle: TextStyle(color: Colors.grey),
                                              hintText: '4'
                                          ),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            LengthLimitingTextInputFormatter(1),
                                            WhitelistingTextInputFormatter.digitsOnly
                                          ],
                                          ),
                                        ),
                                        Container(margin: EdgeInsets.only(bottom: 25,right: 5),
                                          child: Text('.',style: TextStyle(fontSize: 28),),),
                                        Container(
                                          width: 20,
                                          height: 30,
                                          child: TextField(
//                                            onChanged: ,
                                            controller: _secondFilter,
                                            style: new TextStyle(
                                              fontSize: 28.0,
//                                                  height: 2.0,
//                                                  color: Colors.black
                                            ),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintStyle: TextStyle(color: Colors.grey),
                                              hintText: '4'
                                          ),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            LengthLimitingTextInputFormatter(1),
                                            WhitelistingTextInputFormatter.digitsOnly,
                                          ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )

                                ],
                              ),

                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: 180,
                            height: 180,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text('Fat Burn',style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.bold),),
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Image.asset('assets/images/fat_value.jpeg'),
                                    ),
                                    Container(
                                      width: 180,
                                      margin: EdgeInsets.only(top: 50),
                                      child: Center(
                                        child: Text(_changeKetosis,textAlign:TextAlign.center,style: TextStyle(color: Colors.grey,fontSize: 18),),
                                      ),
                                    )
                                  ],
                                ),

                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                  child: Container(
                    margin: EdgeInsets.only(right: 20,bottom: 20),
                    child: RaisedButton(
                      onPressed: _NextCall,
                          color:  Color(0xFFBe97619),
                      child: Text('NEXT',style: TextStyle(color: Colors.white),),
                    ),
                  )
//
              )
            ],
          ),
        ),
      ),
    );
  }

  void _CheckPressed() {

    String first = _firstFilter.text.toString();
    String second = _secondFilter.text.toString();

    if(first.length>0 && second.length>0){
      String stringValue=first+'.'+second;

      double value=double.parse(stringValue);

      if (value <= 8.0 && value >= 0.0){
        imgVis=false;
        barvis=true;
        if (value >= 0.0 && value <= 0.1) {
          max=1.0;
        _changeKetosis = "NOT IN KETOSIS";
//        actualvalue = 0
        } else if (value >= 0.2 && value <= 0.5) {
          max=2.0;
          _changeKetosis = "KETOSIS BEGIN";
//        actualvalue = 1
        } else if (value >= 0.6 && value <=2.0) {
          max=3.0;
          _changeKetosis = "FULL STATE OF KETOSIS";
//        actualvalue = 2
        } else if (value >= 2.1&&value <=3.0) {
          max=4.0;
          _changeKetosis = "FULL STATE OF KETOSIS";
//        actualvalue = 3
        } else if (value >= 3.1 &&value<=5.0) {
          max=5.0;
          _changeKetosis = "STARVATION";
//        actualvalue = 4
        } else if (value >= 5.1 && value <=7.0) {
          max=6.0;
          _changeKetosis = "MEDICAL HELP";
//        actualvalue = 5
        } else if (value >= 7.1 &&value <=7.9) {
          max=7.0;
          _changeKetosis = "DANGER";
//        actualvalue = 6
        }
      }else if (value >8.0){
        _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text('Value should be less than 8.0')));
      }

    }else if(first.length==0 && second.length==0){
      imgVis=true;
      barvis=false;
      _changeKetosis='Change Ketosis no';
    }
    else{
      imgVis=true;
      barvis=false;
      _changeKetosis='';
    }

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

  _NextCall(){
    String first = _firstFilter.text.toString();
    String second = _secondFilter.text.toString();

    if(first.length>0 && second.length>0){
      String stringValue=first+'.'+second;

      double value=double.parse(stringValue);

      if (value <= 8.0 && value >= 0.0){

        Navigator.push(context, MaterialPageRoute(builder: (context) => SuggestionsView()));
      }else if (value >8.0){
        _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text('Value should be less than 8.0')));
      }

    }
  }

  _barsData(double maximum) {
    if (maximum != null && maximum == 1) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Bar(0.2, '1', '20')
        ],
      );
    }
    else if (maximum != null && maximum == 2) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Bar(0.2, '1', '20'),
          Bar(0.3, '2', '30'),
        ],
      );
    }
    else if (maximum != null && maximum == 3) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Bar(0.2, '1', '20'),
          Bar(0.3, '2', '30'),
          Bar(0.4, '3', '40'),
        ],
      );
    }
    else if (maximum != null && maximum == 4) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Bar(0.2, '1', '20'),
          Bar(0.3, '2', '30'),
          Bar(0.4, '3', '40'),
          Bar(0.5, '4', '50'),
        ],
      );
    }
    else if (maximum != null && maximum == 5) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Bar(0.2, '1', '20'),
          Bar(0.3, '2', '30'),
          Bar(0.4, '3', '40'),
          Bar(0.5, '4', '50'),
          Bar(0.6, '5', '60'),
        ],
      );
    }
    else if (maximum != null && maximum == 6) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Bar(0.2, '1', '20'),
          Bar(0.3, '2', '30'),
          Bar(0.4, '3', '40'),
          Bar(0.5, '4', '50'),
          Bar(0.6, '5', '60'),
          Bar(0.7, '6', '70'),
        ],
      );
    }
    else if (maximum != null && maximum == 7) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Bar(0.2, '1', '20'),
          Bar(0.3, '2', '30'),
          Bar(0.4, '3', '40'),
          Bar(0.5, '4', '50'),
          Bar(0.6, '5', '60'),
          Bar(0.7, '6', '70'),
          Bar(0.8, '7', '80'),
        ],
      );
    }
  }
}
