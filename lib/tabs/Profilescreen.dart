import 'package:flutter/material.dart';

import '../screenPanskill/HomePage.dart';
class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color mainColor = Color(0xff014c92);

    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text("PANSKILL"),
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 16.0),

        backgroundColor: mainColor,
      ),
      body: Container(
        child: Center(
          child: Column(
            // center the children
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.favorite,
                size: 160.0,
                color: Colors.white,
              ),
              Text(
                "Profile tabs",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
      drawer: MyDrawerDirectory(),
    );
  }
}