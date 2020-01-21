
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPref {
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, value);
  }

//  remove(String key) async {
//    final prefs = await SharedPreferences.getInstance();
//    prefs.remove(key);
//  }
}