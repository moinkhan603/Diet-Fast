import 'dart:convert';

import 'package:diet_fast_forward/Views/AfterLogin.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:http/http.dart' as http;


class LoginView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _LoginState();


}


//final logger = Logger();
//abstract class RestClient {
//
//  factory RestClient(Dio dio) _RestClient;
//  }
//
//  @POST('https://plan.vlatkins.com/wp-json/wcra/v1/getusers/')
//  Observable<JsonElement> login(@Query("secret_key") String key, @Query("param1") String email, @Query("param2") String password);
//}

class _LoginState extends State<LoginView> {

  ProgressDialog pr;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController _emailFilter = new TextEditingController(text: '252525@sdfgdrg.hk');
  TextEditingController _passwordFilter = new TextEditingController(text: 'Accountusername99999');
  String _email = "";
  String _password = "";

  _LoginPageState() {
    _emailFilter.addListener(_emailListen);
    _passwordFilter.addListener(_passwordListen);
  }
  void _emailListen() {
    if (_emailFilter.text.isEmpty) {
      _email = "";
    } else {
      _email = _emailFilter.text;
    }
  }

  void _passwordListen() {
    if (_passwordFilter.text.isEmpty) {
      _password = "";
    } else {
      _password = _passwordFilter.text;
    }
  }


  @override
  Widget build(BuildContext context) {


    pr = new ProgressDialog(context);

    pr = new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);

    pr.style(
        message: 'Loading...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
    );
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        margin: EdgeInsets.all(20),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 40),
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
                margin: EdgeInsets.only(top: 20,bottom: 10),
                padding: EdgeInsets.all(10),
                child: Text('SPECIAL WEIGHT LOSS TOOLS FOR WAR AGAINST OBESITY MEMBERS ONLY',style: TextStyle(fontSize: 25,color: Colors.grey,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              ),Container(
                margin: EdgeInsets.all(10),
                child: Text('Use the war against obesity login cardentials',style: TextStyle(color: Colors.grey,),),
              ),

              Container(
                margin: EdgeInsets.all(10),
                width: 250,
//                color: Color(0xFFBe97619),
                child: TextField(
                  controller: _emailFilter,
                  style: TextStyle(color: Colors.white),
                  decoration:InputDecoration(
                      border: InputBorder.none,
                      fillColor: Color(0xFFBe97619),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.white,),

                      hintText: 'Email Address'
                  ),
                  autofocus: true,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                width: 250,
//                color: Color(0xFFBe97619),
                child: TextField(
                  controller: _passwordFilter,
                  style: TextStyle(color: Colors.white),
                  obscureText: true,
                  decoration:InputDecoration(
                      border: InputBorder.none,
                      fillColor: Color(0xFFBe97619),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.white,),
                      hintText: 'Password'
                  ),
                  textAlign: TextAlign.center,
//                  keyboardType: ,
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: RaisedButton(
                    onPressed: _loginPressed,

                    color: Color(0xFFBe97619),
                    child: Container(
                        width: 150,
                        padding: EdgeInsets.only(top: 15,bottom: 15),
                        child: Center(
                          child: Text('LOGIN',style: TextStyle(color: Colors.white,fontSize: 16),),
                        )
                    )
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
//                padding: EdgeInsets.all(10),
                child: Text('Become War Against Obesity Member',style: TextStyle(fontSize: 25,color: Colors.grey,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: RaisedButton(
                    onPressed: _launchURL,
                    color: Color(0xFFBe97619),
                    child: Container(
                        width: 200,
                        padding: EdgeInsets.only(top: 15,bottom: 15),
                        child: Center(
                          child: Text('LEARN MORE',style: TextStyle(color: Colors.white,fontSize: 16),),
                        )
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _launchURL() async {
    String url='https://waragainstobesity.org/learn';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  Future<void> _loginPressed () async {
    pr.show();
    _LoginPageState();

    String email = _emailFilter.text.toString();
    String password = _passwordFilter.text.toString();

    if(email.length!=0){
      if(password.length!=0){

        int code=await postData(email,password);

        if(code==200){
          pr.dismiss();
          Navigator.push(context, MaterialPageRoute(builder: (context) => AfterLogin()));
        }
        else{
          _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text('Something went wrong!')));
        }

      }else{
        _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text('Enter Password')));
      }
    } else{
      _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text('Enter Email Address')));
    }
  }

  static Future<int> postData(String email,String password) async {
//    debug
    String url="https://plan.vlatkins.com/wp-json/wcra/v1/getusers/";
//    release
//    String url="https://plan.vlatkins.com/";
    var body = {
      'secret_key': '0aPrw1k5acAj4gFcic7DsmhC4e0POftD',
      'param1': email,
      'param2': password,
    };
    http.Response res = await http.post(url, body: body); // post api call
    int data = jsonDecode(res.statusCode.toString());
    print('response body'+res.body.toString());
    print('response data'+data.toString());
    return data;
  }

}