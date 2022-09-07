import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:panskill/screenPanskill/Skilled_Service.dart';
import 'package:panskill/tabs/Businesscreen.dart';
import 'package:panskill/tabs/Hometab.dart';
import '../services/FirebaseService.dart';
import '../tabs/Servicescreen.dart';
import '../tabs/Profilescreen.dart';
import 'Dashboard.dart';
import 'Loginscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  Color mainColor = Color(0xff014c92);
  GlobalKey globalKey = GlobalKey(debugLabel: 'btm_app_bar');

  void onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final widgetTitle = ["Home", "Business", "Social", "Service", "Profile"];

  //list of widgets to call ontap

  final widgetOptions = [
    ServicePage(),
    BusinessPage(),
    ProfilePage(),
    ServicePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    FirebaseService service = new FirebaseService();

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Business',
            icon: Icon(Icons.work),
          ),
          BottomNavigationBarItem(
            label: 'Social',
            icon: Icon(Icons.supervised_user_circle),
          ),
          BottomNavigationBarItem(
            label: 'Service',
            icon: Icon(Icons.settings),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.account_box),
          ),
        ],
        key: globalKey,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: onItemTapped,
        backgroundColor: colorScheme.surface,
        selectedItemColor: mainColor,
        unselectedItemColor: colorScheme.onSurface.withOpacity(.60),
        selectedLabelStyle: textTheme.caption,
        unselectedLabelStyle: textTheme.caption,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
    );
  }
}

class MyDrawerDirectory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            // <-- SEE HERE
            decoration: BoxDecoration(color: const Color(0xff1160a8)),
            accountName: Text(
              "Panskill",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              "panskill@gmail.com",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            currentAccountPicture: Image.asset("data_repo/images/mob_logo.png"),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
            ),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));            },
          ),
          ListTile(
            leading: Icon(
              Icons.work,
            ),
            title: const Text('My Business'),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => BusinessPage()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.message,
            ),
            title: const Text('My Plan'),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          ListTile(
            leading: Icon(
              Icons.account_circle,
            ),
            title: const Text('Register worker'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.notifications_active_outlined,
            ),
            title: const Text('Notification'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
            ),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
            ),
            title: const Text('SignOut'),
            onTap: () async {
              try {
                FirebaseService service = new FirebaseService();
                await service.signOutFromGoogle();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginDemo()));
              } catch (e) {
                print(e);
              }
            },
          ),
        ],
      ),
    );
  }
}
