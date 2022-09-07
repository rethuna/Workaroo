import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:panskill/Model/Register.dart';
import 'package:panskill/screenPanskill/verify_otp.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Database/DatabaseHelper.dart';
import '../services/Constants.dart';

class RegisterDemo extends StatefulWidget {
  const RegisterDemo({Key? key}) : super(key: key);

  @override
  State<RegisterDemo> createState() => _RegisterDemoState();
}

class _RegisterDemoState extends State<RegisterDemo> {
  TextEditingController _controller_username = new TextEditingController();
  TextEditingController _controller_mobile = new TextEditingController();
  String dialedCodedigits = "+91";
  bool isLoading = true;
  Register regModel = Register();
  String? token = "";

  // final dbHelper = DatabaseHelper.instance;

  Color mainColor = Color(0xff014c92);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PANSKILL"),
        backgroundColor: mainColor,
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 16.0),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 130),
          Padding(
            padding: const EdgeInsets.only(left: 28, right: 28),
            child: Image.asset("data_repo/images/panlogo.png"),
          ),
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: Center(
              child: Text(
                "Register",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: mainColor),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              icon: Icon(
                Icons.work,
                color: mainColor,
                size: 30.0,
              ),
              label: const Text('SKILLED WORKER',
                  style: TextStyle(fontWeight: FontWeight.normal)),
              onPressed: () {
                _onAlertWithCustomContentPressed(context, "SkilledWorker");
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                )),
                overlayColor: getColor(Colors.white, mainColor),
                foregroundColor: getColor(mainColor, Colors.white),
                backgroundColor: getColor(Colors.white, mainColor),
                side: getBorder(mainColor, mainColor),
              ),

              /* style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onSurface: mainColor,
                side: BorderSide(color: mainColor, width: 1),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),*/
            ),
          ),
          const SizedBox(height: 5),
          Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              icon: Icon(
                Icons.account_box,
                color: mainColor,
                size: 30.0,
              ),
              label: const Text('CUSTOMER',
                  style: TextStyle(fontWeight: FontWeight.normal)),
              onPressed: () {
                _onAlertWithCustomContentPressed(context, "Customer");
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                )),
                overlayColor: getColor(Colors.white, mainColor),
                foregroundColor: getColor(mainColor, Colors.white),
                backgroundColor: getColor(Colors.white, mainColor),
                side: getBorder(mainColor, mainColor),
              ),
            ),
          ),
          new Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }

  MaterialStateProperty<Color> getColor(Color color, Color colorPressed) {
    final getColor = (Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return colorPressed;
      } else {
        return color;
      }
    };
    return MaterialStateProperty.resolveWith(getColor);
  }

  MaterialStateProperty<BorderSide> getBorder(Color color, Color colorPressed) {
    final getBorder = (Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return BorderSide(color: colorPressed, width: 1);
      } else {
        return BorderSide(color: color, width: 1);
      }
    };
    return MaterialStateProperty.resolveWith(getBorder);
  }

// Alert custom content
  _onAlertWithCustomContentPressed(context, String type) {
    Alert(
        context: context,
        title: "Register Here",
        content: Column(
          children: <Widget>[
            TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.account_circle),
                  labelText: 'Name',
                  labelStyle: TextStyle(fontSize: 14),
                  prefix: Padding(
                    padding: EdgeInsets.all(1),
                  ),
                  border: OutlineInputBorder(),
                ),
                controller: _controller_username),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  labelStyle: const TextStyle(fontSize: 14),
                  prefixIcon: const Icon(Icons.phone),
                  prefix: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Text(dialedCodedigits),
                  ),
                  border: const OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val == '') {
                    return 'Phone Number is required';
                  }
                },
                keyboardType: TextInputType.number,
                controller: _controller_mobile),
          ],
        ),
        buttons: [
          DialogButton(
            height: 50,
            color: mainColor,
            onPressed: () => registerData(type),
            child: const Text(
              "REGISTER",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          )
        ]).show();
  }

  // Button onPressed methods
  void registerData(String userType) async {
    try {
      final response =
          await http.post(Uri.parse("https://workaroo.ai/api/register"),
              headers: {
                "Accept": "application/json",
                "Content-Type": "application/x-www-form-urlencoded"
              },
              body: ({
                'name': _controller_username.text,
                'mobile': _controller_mobile.text,
                'roles[]': userType.trim(),
              }));
      print(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        setState(() {
          Map<String, dynamic> resposne = jsonDecode(response.body);
          regModel = Register.fromJson(resposne);
        });
        token = regModel.meta?.token;
        String? name = regModel.data?.name;
        _save(token!, name!);
        print(" $token");
        kShowToast("Register success");
        sendOTP();
      } else if (response.statusCode == 422) {
        kShowToast("Mobile Number Already Exist");
      }
    } catch (e) {
      print(e);
    }
    // var json = jsonDecode(response.body);
  }

  _save(String token, String name) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('token', token);
    prefs.setString('name', name);

    print('saved $token');
  }

  void sendOTP() async {
    String otp = OTP(4);
    final response = await http.post(
        Uri.parse("https://sapteleservices.com/SMS_API/sendsms.php"),
        body: ({
          'username': "panskill",
          'password': "d99140",
          'mobile': dialedCodedigits + _controller_mobile.text,
          'sendername': "PASKCO",
          'message': "The OTP for your registration at Pan Skill Connect is " +
              otp.trim() +
              ".Please submit it for phone number verification.PAN SKILL CONNECT PRIVATE LIMITED.",
          'routetype': "1",
          'tid': "1607100000000187941"
        }));
    print(response.statusCode);
    if (response.statusCode == 200) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (c) => VerifyOTPScreen(
              mobile: dialedCodedigits + " " + _controller_mobile.text,
              otp: otp,
              token: token.toString())));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Invalid credential")));
    }
    // var json = jsonDecode(response.body);
    setState(() {
      // _data = Users.fromJson(json);
      isLoading = false;
    });
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


}
