
import 'dart:convert';
import 'dart:io';

import 'package:diet_fast_forward/Database/DatabaseHelper.dart';
import 'package:diet_fast_forward/Views/StartStopDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:sqflite/sqflite.dart';

import '../SharedPref.dart';

class ChewBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChewBarState();


}

class _ChewBarState extends State<ChewBar> {


//  final dbHelper = DatabaseHelper.instance;

  SharedPref sharedPref = SharedPref();

  List dataList = new List();


  @override
  void initState() {
    super.initState();
    getPrefValues();
  }

  @override
  Widget build(BuildContext context) {
    print('datalist'+dataList.toString());
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: createTable(),
      ),
        floatingActionButton: new FloatingActionButton(
            elevation: 0.0,
            child: new Icon(Icons.add),
            backgroundColor: Color(0xFFBe97619),
            onPressed: _pressed,
        )
    );
  }



//  TableRow _buildTableRow(String listOfNames) {
//    return TableRow(
//      children: listOfNames.split(',').map((name) {
//        return Container(
//          alignment: Alignment.center,
//          child: Text(name,),
//          padding: EdgeInsets.all(5.0),
//        );
//      }).toList(),
//    );
//  }
  TableRow _buildFirstTableRow(String listOfNames) {
    return TableRow(
      decoration: BoxDecoration(color: Color(0xFFBe97619)),
      children: listOfNames.split(',').map((name) {
        return Container(
//          color: Colors.orange,
          alignment: Alignment.center,
          child: Text(name, ),
          padding: EdgeInsets.only(left:5.0,right: 5,bottom: 5,top: 25),
        );
      }).toList(),
    );
  }

  Widget createTable() {
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
      Container(
        alignment: Alignment.center,
        color:  Color(0xFFBe97619),
        padding: EdgeInsets.only(left:5.0,right: 5,bottom: 5,top: 25),
        child: Text("Time"),
      ),Container(
        alignment: Alignment.center,
        color:  Color(0xFFBe97619),
        padding: EdgeInsets.only(left:5.0,right: 5,bottom: 5,top: 25),
        child: Text("Meal"),
      ),Container(
        alignment: Alignment.center,
        color:  Color(0xFFBe97619),
        padding: EdgeInsets.only(left:5.0,right: 5,bottom: 5,top: 25),
        child: Text("Bites"),
      ),Container(
        alignment: Alignment.center,
        color:  Color(0xFFBe97619),
        padding: EdgeInsets.only(left:5.0,right: 5,bottom: 5,top: 25),
        child: Text("Total Time"),
      ),
    ]));
    if(dataList!=null &&dataList.length>0){
      for (int i = 0; i < dataList.length; ++i) {
        String newString=dataList[i].toString();
        List<String> newList=newString.split('-');
        rows.add(TableRow(children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black)
            ),
            child: Text(newList[0]),
          ),Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black)
            ),
            child: Text(newList[1]),
          ),Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black)
            ),
            child: Text(newList[2]),
          ),Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black)
            ),
            child: Text(newList[3]),
          ),

        ]));
      }

    }
    return Table(children: rows);
  }
    _newRows()  {
    if(dataList!=null && dataList.length>0){
      for(int i=0;i<dataList.length;i++){
        String newString= dataList[i].toString();

        return new TableRow(

            children: newString.split(',').map((name) {
               Container(
                alignment: Alignment.center,
                child: Text(name,),
                padding: EdgeInsets.all(5.0),
              );
            }).toList()
        );
//      });

//        String newString= dataList[i].toString();
//        return new TableRow(
//
//            children: newString.split('-').map((name) {
//              return Container(
//                alignment: Alignment.center,
//                child: Text(name,),
//                padding: EdgeInsets.all(5.0),
//              );
//            }).toList()
//        );



//        List<TableRow> rows = [];
//        for (int i = 0; i < dataList.length; ++i) {
//          rows.add(TableRow(children: newString.split('-').map((name) {
//            return Container(
//              alignment: Alignment.center,
//              child: Text(name,),
//              padding: EdgeInsets.all(5.0),
//            );
//          }).toList()));
//        }
//        return Table(children: rows);

//        buildRowsByLoop(newString);
      }
//      return;
    }
    else{
      String newString=' - - - ';

      return TableRow(

          children: newString.split('-').map((name) {
            return Container(
              alignment: Alignment.center,
              child: Text(name,),
              padding: EdgeInsets.all(5.0),
            );
          }).toList()
      );

//      List<TableRow> rows = [];
//      for (int i = 0; i < 1; ++i) {
//        rows.add(TableRow(children: newString.split('-').map((name) {
//          return Container(
//            alignment: Alignment.center,
//            child: Text(name,),
//            padding: EdgeInsets.all(5.0),
//          );
//        }).toList()));
//        return Table(children: rows);
//      }

    }

  }

  Future<void> getPrefValues() async {
    List list=await sharedPref.read('newDataTable');
    setState(()  {
      dataList=list;
    });
  }


  Future<void> _pressed() async {
    String received=await Navigator.push(context, MaterialPageRoute(builder: (context) => StartStopDialog()));
    if(received==null || received=='abc'){
      getPrefValues();
    }

  }

  buildRowsByLoop(String newString) {
    return new TableRow(

        children: newString.split('-').map((name) {
          return Container(
            alignment: Alignment.center,
            child: Text(name,),
            padding: EdgeInsets.all(5.0),
          );
        }).toList()
    );
  }


}