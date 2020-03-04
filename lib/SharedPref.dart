import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return  prefs.getStringList(key);
  }

  save(String key, value) async {
    List<String> list = new List();
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList(key) != null) {
      list = prefs.getStringList(key);
      list.add(value);
    }else{
      list.add(value);
    }
    await prefs.setStringList(key, list);
    print('savedValue' + list.toString());
  }
}