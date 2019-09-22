import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:food/FoodGroups.dart';
import 'package:food/FoodList.dart';
import 'package:food/SignUp.dart';
import 'package:food/Welcome.dart';

import 'LogIn.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
        locale:
            Locale("fa", "IR"), 
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.teal[400],
        accentColor: Colors.teal[100],
        primarySwatch: Colors.blue,
        fontFamily: "IranSans"
      ),
      home: LogIn()
    );
  }
}


