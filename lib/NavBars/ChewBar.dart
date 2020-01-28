
import 'dart:io';

import 'package:diet_fast_forward/Database/DatabaseHelper.dart';
import 'package:diet_fast_forward/Views/StartStopDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../SharedPref.dart';

class ChewBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChewBarState();


}

class _ChewBarState extends State<ChewBar> {


  final dbHelper = DatabaseHelper.instance;

//  SharedPref sharedPref = SharedPref();

  List dataList = new List();


  @override
  void initState() {
    _query();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    print('datalist'+dataList.toString());
    // TODO: implement build
    return Scaffold(
      body: Table(
        border: TableBorder(
          horizontalInside: BorderSide(
            color: Colors.black,
            style: BorderStyle.solid,
            width: 1.0,
          ),
          verticalInside: BorderSide(
            color: Colors.black,
            style: BorderStyle.solid,
            width: 1.0,
          ),
        ),
        children: [
          _buildFirstTableRow("Time, Meal, Bites, Total Time"),
          _newRows(),

        ],
      ),
        floatingActionButton: new FloatingActionButton(
            elevation: 0.0,
            child: new Icon(Icons.add),
            backgroundColor: Color(0xFFBe97619),
            onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => StartStopDialog()));}
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

  _newRows()  {
    if(dataList.length>0){
      for(int i=0;i<dataList.length;i++){

        String newString=dataList[i]['time'].toString()+','+dataList[i]['meal'].toString()+','+dataList[i]['bites'].toString()+','+dataList[i]['totalTime'].toString();
        print('newString'+newString);

        return TableRow(

          children: newString.split(',').map((name) {
            return Container(
              alignment: Alignment.center,
              child: Text(name,),
              padding: EdgeInsets.all(5.0),
            );
          }).toList(),
        );
      }
    }
    else{
      String newString=' , , , ';
      return TableRow(

        children: newString.split(',').map((name) {
          return Container(
            alignment: Alignment.center,
            child: Text(name,),
            padding: EdgeInsets.all(5.0),
          );
        }).toList(),
      );

    }

  }


  Future<String> _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
    allRows.forEach((row) => dataList.add(row));

    return 'Success';

  }

}