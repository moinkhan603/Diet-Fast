import 'package:diet_fast_forward/Views/LoginView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SuggestionsView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _SuggestionState();


}

class _SuggestionState extends State<SuggestionsView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/suggestions.jpeg'),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 20),
                child: Text('BELOW YOU CAN ACCESS OUR SUGGESTIONS',textAlign:TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.grey),),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: RaisedButton(
                  onPressed: _launchURLMeal,
                  color: Color(0xFFBe97619),
                  child: Container(
                    width: 250,
                    padding: EdgeInsets.only(top: 15,bottom: 15),
                    child: Center(
                      child: Text('21 DAYS MEAL PLAN',style: TextStyle(color: Colors.white,fontSize: 16),),
                    ),
                  )
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: RaisedButton(
                  onPressed:  _launchURLRecipie,
                  color: Color(0xFFBe97619),
                  child: Container(
                    width: 250,
                    padding: EdgeInsets.only(top: 15,bottom: 15),
                    child: Center(
                      child: Text('LOW CARBS MEAL RECIPIES',style: TextStyle(color: Colors.white,fontSize: 16),),
                    ),
                  )
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: RaisedButton(
                  onPressed: _launchURLCourse,
                  color: Color(0xFFBe97619),
                  child: Container(
                      width: 250,
                      padding: EdgeInsets.only(top: 15,bottom: 15),
                      child: Center(
                        child: Text('KETO 101 VIDEO COURSE',style: TextStyle(color: Colors.white,fontSize: 16),),
                      )
                  )
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.only(left: 10,right: 10),
                child: Text('FOR MORE TOOLS WE RECOMMEND YOU TO JOIN THE WAR AGAINST OBESITY ALL-IN-ONE E-CENTER CONTAINING EVERYTHING YOU NEED TO FIGHT AGAINST OBESITY',
                  textAlign:TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.grey),),
              ),
            ),

            Container(
              margin: EdgeInsets.all(10),
              child: RaisedButton(
                  onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => LoginView())),
                  color: Color(0xFFBe97619),
                  child: Container(
                      width: 250,
                      padding: EdgeInsets.only(top: 15,bottom: 15),
                      child: Center(
                        child: Text('MEMBER AREA ACCESS',style: TextStyle(color: Colors.white,fontSize: 16),),
                      )
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }

  _launchURLMeal() async {
    String url='https://nutrieveryday.com/21_Days_Meal_Plan';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchURLRecipie() async {
    String url='https://nutrieveryday.com/Low_Carb_Meal_Recipes';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchURLCourse() async {
    String url='https://nutrieveryday.com/Keto_101_Video_Course';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


}
