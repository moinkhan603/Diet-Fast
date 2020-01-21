

import 'package:diet_fast_forward/NavBars/ComingSoon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FactorDetailView extends StatefulWidget {
  String imgPath;
  String name;
  String duration;
  String time;


  FactorDetailView({
    this.imgPath,this.name,this.duration,this.time,
  });


  @override
  State<StatefulWidget> createState() => _FactorDetailState();
}

class _FactorDetailState extends State<FactorDetailView> {

  String imgPath;
  String name;
  String duration;
  String time;


  @override
  void initState() {
    super.initState();
    imgPath=widget.imgPath;
    name=widget.name;
    duration=widget.duration;
    time=widget.time;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
          margin: EdgeInsets.all(5),
//                                    height: 100,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(right: 10),
                        child:Image.asset('assets/images/forwardbutton.png',
                          width: 70,
                          height: 70,
//                         fit:BoxFit.fill
                        )
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child:
                      Image.asset('assets/images/ninfactorimage.png',
                        width: 180,
                        height: 150,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                color: Color(0xFFBe97619),
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Image.asset(
                      'assets/images/$imgPath',
                    ),
                  ),
                  title: Text(
                    name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        duration,
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
                          time, style: TextStyle(color: Colors.white),),
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

            ],
          )
      ),
      floatingActionButton: new FloatingActionButton(
        elevation: 0.0,
        child: new Icon(Icons.add),
        backgroundColor: Color(0xFFBe97619),
        onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ComingSoon()));}
        )
    );
  }
}