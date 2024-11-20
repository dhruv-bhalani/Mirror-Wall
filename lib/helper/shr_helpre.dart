import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShrHelper {
  static ShrHelper shrHelper = ShrHelper();
  String? index;
  void themeset(bool val) async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    shr.setBool("themes", val);
  }

  Future<bool?> themeget() async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    bool? val = shr.getBool("themes");
    return val;
  }

  void setIndex(String Web) async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    shr.setString("Web", Web);
  }

  Future<String?> getIndex() async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    String? index = shr.getString("Web");
    return index;
  }
}
