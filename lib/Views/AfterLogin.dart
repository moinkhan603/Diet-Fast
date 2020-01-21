import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AfterLogin extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => _AfterLoginState();
}

class _AfterLoginState extends State<AfterLogin> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 60),
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
                    ),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 20,left: 20,right: 20),
                child: Text('BELOW YOU CAN ACCESS THE MODULES',textAlign:TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.grey),),
              ),
              GestureDetector(
                onTap: _launchURL1,
                child: Container(
                    width: 250,
                    color: Color(0xFFBe97619),
                    margin: EdgeInsets.only(top: 10,bottom: 10),
                    padding: EdgeInsets.only(top: 15,bottom: 15),
                    child: Center(
                      child: Text('CALCULATE',style: TextStyle(color: Colors.white,fontSize: 16),),
                    )
                ),
              ),
              GestureDetector(
                onTap: _launchURL2,
                child: Container(
                    width: 250,
                    color: Color(0xFFBe97619),
                    margin: EdgeInsets.only(top: 10,bottom: 10),
                    padding: EdgeInsets.only(top: 15,bottom: 15),
                    child: Center(
                      child: Text('VLATKINS DIET PLAN',style: TextStyle(color: Colors.white,fontSize: 16),),
                    )
                ),
              ),
              GestureDetector(
                onTap: _launchURL3,
                child: Container(
                    color: Color(0xFFBe97619),
                    width: 250,
                    margin: EdgeInsets.only(top: 10,bottom: 10),
                    padding: EdgeInsets.only(top: 15,bottom: 15),
                    child: Center(
                      child: Text('INFORM',style: TextStyle(color: Colors.white,fontSize: 16),),
                    )
                ),
              ),
              GestureDetector(
                onTap: _launchURL4,
                child: Container(
                    width: 250,
                    color: Color(0xFFBe97619),
                    margin: EdgeInsets.only(top: 10,bottom: 10),
                    padding: EdgeInsets.only(top: 15,bottom: 15),
                    child: Center(
                      child: Text('EDUCATE',style: TextStyle(color: Colors.white,fontSize: 16),),
                    )
                ),
              ),
              GestureDetector(
                onTap: _launchURL5,
                child: Container(
                    width: 250,
                    color: Color(0xFFBe97619),
                    margin: EdgeInsets.only(top: 10,bottom: 10),
                    padding: EdgeInsets.only(top: 15,bottom: 15),
                    child: Center(
                      child: Text('FIGHT',style: TextStyle(color: Colors.white,fontSize: 16),),
                    )
                ),
              ),
              GestureDetector(
                onTap: _launchURL6,
                child: Container(
                    width: 250,
                    color: Color(0xFFBe97619),
                    margin: EdgeInsets.only(top: 10,bottom: 10),
                    padding: EdgeInsets.only(top: 15,bottom: 15),
                    child: Center(
                      child: Text('CERTIFY',style: TextStyle(color: Colors.white,fontSize: 16),),
                    )
                ),
              ),
              GestureDetector(
                onTap: _launchURL7,
                child: Container(
                    width: 250,
                    color: Color(0xFFBe97619),
                    margin: EdgeInsets.only(top: 10,bottom: 10),
                    padding: EdgeInsets.only(top: 15,bottom: 15),
                    child: Center(
                      child: Text('AFFILIATE',style: TextStyle(color: Colors.white,fontSize: 16),),
                    )
                ),
              ),

            ]
        ),
      ),
    );
  }
  _launchURL1() async {
    String url='https://nutrieveryday.com/MODULE1';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchURL2() async {
    String url='https://nutrieveryday.com/MODULE2';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchURL3() async {
    String url='https://nutrieveryday.com/MODULE3';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchURL4() async {
    String url='https://nutrieveryday.com/MODULE4';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchURL5() async {
    String url='https://nutrieveryday.com/MODULE5';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchURL6() async {
    String url='https://nutrieveryday.com/MODULE6';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchURL7() async {
    String url='https://nutrieveryday.com/MODULE7';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}