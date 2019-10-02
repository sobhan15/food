import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:food/FoodGroups.dart';
import 'package:food/FoodList.dart';
import 'package:food/SignUp.dart';
import 'package:food/Welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LogIn.dart';

void main() => runApp(MyApp());

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
        home: userId == null ? LogIn() : FoodList());
  }
}
