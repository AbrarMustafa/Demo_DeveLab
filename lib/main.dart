import 'package:demo_develab/screens/dashboardScreen.dart';
import 'package:demo_develab/screens/loginScreen.dart';
import 'package:demo_develab/screens/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// WidgetsBinding.instance.window.physicalSize.width;
// SharedPreferences.setMockInitialValues({});
//drawer UI Update ,set all strings in app for multilanguage .
SharedPreferences? prefs;
void main() {
  return runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => SplashScreen(),
      '/login': (context) => LoginScreen(),
      '/country': (context) => DashboardScreen(),
    },
    debugShowCheckedModeBanner: false,
  ));

}
