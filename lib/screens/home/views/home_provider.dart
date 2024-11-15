import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:government_app/model/webmodel.dart';

class Homeprovider with ChangeNotifier {
  bool isConnect = false;
  Connectivity connectivity = Connectivity();
  double progress = 0;

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
}
