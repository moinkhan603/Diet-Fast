//
//import 'package:shared_preferences/shared_preferences.dart';
//import 'dart:convert';
//
//class SharedPref {
//  read(String key) async {
//    final prefs = await SharedPreferences.getInstance();
//    print("response"+prefs.getStringList(key).toString());
//    return prefs.getStringList(key);
//
//  }
//
//  save(String key, value) async {
//    List<String> list=new List();
//    final prefs = await SharedPreferences.getInstance();
//    if(prefs.getStringList(key)!=null){
//     list=prefs.getStringList(key);
//     list.add(value);
//    }
//    else{
//      list.add(value);
//    }
//
//    prefs.setStringList(key, list);
//  }
//
////  remove(String key) async {
////    final prefs = await SharedPreferences.getInstance();
////    prefs.remove(key);
////  }
//}