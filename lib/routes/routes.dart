import 'package:flutter/material.dart';
import 'package:government_app/screens/home/views/home.dart';
import 'package:government_app/screens/splashscreen/splashscreen.dart';
import 'package:government_app/screens/webpage/web.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> allRoutes = {
    '/': (context) => const Splashscreen(),
    '/home': (context) => const Homepage(),
    '/web': (context) => const WebPage(),
  };
}
