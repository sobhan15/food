import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:food/FoodList.dart';
import 'package:food/Welcome.dart';

import 'package:flutter_crashlytics/flutter_crashlytics.dart';

import 'package:shared_preferences/shared_preferences.dart';




void main() async {
 bool isInDebugMode = false;

 FlutterError.onError = (FlutterErrorDetails details) {
   if (isInDebugMode) {
     // In development mode simply print to console.
     FlutterError.dumpErrorToConsole(details);
   } else {
     // In production mode report to the application zone to report to
     // Crashlytics.
     Zone.current.handleUncaughtError(details.exception, details.stack);
   }
 };

 await FlutterCrashlytics().initialize();

 runZoned<Future<Null>>(() async {
   runApp(MyApp());
 }, onError: (error, stackTrace) async {
   // Whenever an error occurs, call the `reportCrash` function. This will send
   // Dart errors to our dev console or Crashlytics depending on the environment.
   await FlutterCrashlytics().reportCrash(error, stackTrace, forceCrash: false);
 });
}

//void main()=>runApp(MyApp());



class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  SharedPreferences prefs;
  var userId;

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  void initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString("user_id");
    });
    print(userId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
        ],
        locale: Locale("fa", "IR"),
        title: 'Flutter Demo',
        theme: ThemeData(
            primaryColor: Colors.teal[400],
            accentColor: Colors.teal[100],
            primarySwatch: Colors.blue,
            fontFamily: "IranSans"),

        home: userId == null ? Welcome() : FoodList());

  }
}
