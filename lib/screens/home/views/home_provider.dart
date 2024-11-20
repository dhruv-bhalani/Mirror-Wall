import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:government_app/model/webmodel.dart';
import 'package:government_app/helper/shr_helpre.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class Homeprovider with ChangeNotifier {
  bool isConnect = false;
  Connectivity connectivity = Connectivity();
  double progress = 0;
  List<ConnectivityResult> results = [];
  bool isdarkmode = false;
  int count = 0;
  String? url;

  List<WebModels> webList = [
    WebModels(
      title: "Home",
      url: "https://www.google.com",
      icon: Icons.home,
    ),
  ];
  void changeProgress(double value) {
    progress = value;
    notifyListeners();
  }

  Future<void> checkConnection() async {
    StreamSubscription<List<ConnectivityResult>> results =
        (await Connectivity().onConnectivityChanged.listen(
      (List<ConnectivityResult> result) {
        if (result.contains(ConnectivityResult.none)) {
          isConnect = false;
        } else {
          isConnect = true;
        }
        notifyListeners();
      },
    ));
  }

  void changeTheme(bool val) {
    isdarkmode = val;
    ShrHelper.shrHelper.themeset(val);
    notifyListeners();
  }

  Future<void> checkTheme() async {
    bool? val = await ShrHelper.shrHelper.themeget();
    isdarkmode = val!;
    notifyListeners();
  }

  void selectIndex(String Web) {
    ShrHelper.shrHelper.setIndex(Web);
    notifyListeners();
  }

  Future<void> getSelectIndex() async {
    url = await ShrHelper.shrHelper.getIndex();
    notifyListeners();
  }
}
