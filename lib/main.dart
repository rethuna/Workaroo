// @dart=2.9

import 'package:flutter/material.dart';
import 'package:panskill/screenPanskill/Dashboard.dart';
import 'package:panskill/screenPanskill/SplashScreen.dart';
import 'package:panskill/screenPanskill/TestPage.dart';
import 'screenPanskill/Loginscreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Panskill',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'CharisSIL',
        brightness: Brightness.light,
        /* light theme settings */
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'CharisSIL',
        brightness: Brightness.dark,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.light,
      home: SplashDemo()
    );
  }
}

