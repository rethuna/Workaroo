import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:panskill/screenPanskill/RegisterScreen.dart';
import 'package:http/http.dart' as http;
import 'package:panskill/screenPanskill/pin_screen.dart';
import 'package:panskill/screenPanskill/pincheck_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/userData.dart';
import '../services/FirebaseService.dart';
import 'HomePage.dart';
class LoginDemo extends StatefulWidget {
  const LoginDemo({Key? key}) : super(key: key);

  @override
  State<LoginDemo> createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  String dialedCodedigits = "+91";
  final TextEditingController mobileNumber = TextEditingController();
  UsersData usrModel = UsersData();
  String? token = "";
  Color mainColor = const Color(0xff014c92);
  String userEmail = "";
  bool isLoading = false;
  User? result = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    checkPermission();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        centerTitle: true,
        titleTextStyle: const TextStyle(fontSize: 16.0),
      ),
      body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.only(left: 28, right: 28),
                child: Image.asset("data_repo/images/panlogo.png"),
              ),
              const SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Mobile No',
                      prefixIcon: const Icon(Icons.phone),
                      prefix: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Text(dialedCodedigits),
                      ),
                      border: const OutlineInputBorder(),
                    ),
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    controller: mobileNumber),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: mainColor,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 5)),
                        onPressed: () async {
                          if (mobileNumber.text == "") {
                            showToast("Enter mobile number");
                          } else {
                            var check = await loginData();
                            print(check.toString());
                            if (check == "true") {
                              showToast("Login Success");
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (c) =>
                                      PinChkScreen(
                                        token: token.toString(),
                                      )));
                            } else {
                              showToast("Login failed");
                            }
                          }
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 25),
                    Container(
                      width: 150,
                      height: 50,
                      child: InkWell(
                        onTap: () {},
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: mainColor,
                          ),
                          onPressed: () async {
                            setState(() {
                              isLoading = true;

                            });
                            FirebaseService service = new FirebaseService();
                            try {
                              await service.signInwithGoogle();
                              Navigator.pushNamedAndRemoveUntil(
                                  context, "Homepage", (route) => false);
                              result == null
                                  ? Navigator.of(context).push(MaterialPageRoute(
                                  builder: (c) => LoginDemo()))
                                  :  Navigator.of(context).push(MaterialPageRoute(
                                  builder: (c) => HomeScreen()));
                            } catch (e) {
                              if (e is FirebaseAuthException) {
                                showMessage(e.message!);
                              }
                            }
                            setState(() {
                              isLoading = false;
                              result == null
                                  ? Navigator.of(context).push(MaterialPageRoute(
                                  builder: (c) => LoginDemo()))
                                  :  Navigator.of(context).push(MaterialPageRoute(
                                  builder: (c) => HomeScreen()));
                            });
                          },
                          child: Wrap(
                            children: const [
                              Icon(Icons.android, color: Colors.white),
                              SizedBox(width: 5),
                              Text('Google SignIn',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RegisterDemo()));
                      },
                      child: new Text("New User Register Here"),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser
        ?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,

    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }


  Future<String> loginData() async {
    String result;
    final response =
    await http.post(Uri.parse("https://workaroo.ai/api/login"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: ({
          'mobile': mobileNumber.text,
        }));
    setState(() {
      Map<String, dynamic> resposne = jsonDecode(response.body);
      usrModel = UsersData.fromJson(resposne);
    });
    if (response.statusCode == 201 || response.statusCode == 200) {
      token = usrModel.meta?.token;
      String? name = usrModel.data?.name;
      _save(token!, mobileNumber.text);
      result = "true";
      return result;
    } else {
      result = "false";
      return result;
    }
  }

  void showMessage(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(message),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  _save(String token, String mobile) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('token', token);
    prefs.setString('mobile', mobile);

    print('saved $token');
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Color(0xff014c92),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  String OTP(int len) {
    var rndnumber = "";
    var rnd = new Random();
    for (var i = 0; i < len; i++) {
      rndnumber = rndnumber + rnd.nextInt(9).toString();
    }
    print(rndnumber);
    return rndnumber;
  }

  Future<void> checkPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.sms,
      Permission.phone,
      //add more permission to request here.
    ].request();

    if (statuses[Permission.sms]!.isDenied) {
      //check each permission status after.
      print("Location permission is denied.");
    }

    if (statuses[Permission.phone]!.isDenied) {
      //check each permission status after.
      print("Camera permission is denied.");
    }
  }
}
