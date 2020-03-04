import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ComingSoon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text('Coming Soon...!',style: TextStyle(color: Color(0xFFBe97619),fontSize: 25),),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: RaisedButton(
                color: Color(0xFFBe97619),
                onPressed: (){SystemNavigator.pop();},
                child: Container(
                    width: 250,
                    padding: EdgeInsets.only(top: 15,bottom: 15),
                    child: Center(
                      child: Text('EXIT',style: TextStyle(color: Colors.white,fontSize: 16),),
                    )
                )
            ),
          ),
        ],
      ),
    );
  }



}

