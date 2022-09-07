import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:panskill/screenPanskill/pin_screen.dart';

import 'HomePage.dart';

class VerifyOTPScreen extends StatefulWidget {
  final String otp;
  final String mobile;
  final String token;

  VerifyOTPScreen(
      {Key? key, required this.mobile, required this.otp, required this.token})
      : super(key: key);

  @override
  State<VerifyOTPScreen> createState() =>
      _VerifyOTPScreenState(this.mobile, this.otp, this.token);
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  String otp;
  final String mobile;
  final String token;
  String codeValue = "";
  Color mainColor = const Color(0xff014c92);
  String otpNumber = "";
  bool isLoading = true;

  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();

  _VerifyOTPScreenState(this.mobile, this.otp, this.token);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PANSKILL"),
        backgroundColor: mainColor,
        titleTextStyle: TextStyle(fontSize: 16.0),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      // backgroundColor: Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: Colors.black54,
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  //  color: Color(0xffCDDDEF),
                  color: Colors.deepPurple.shade50,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'data_repo/images/otp.png',
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'Verification',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: mainColor),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Enter the 4 digit OTP sent to $mobile",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 28,
              ),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OtpInput(
                            controller: _fieldOne, first: true, last: false),
                        OtpInput(
                            controller: _fieldTwo, first: false, last: false),
                        OtpInput(
                            controller: _fieldThree, first: false, last: false),
                        OtpInput(
                            controller: _fieldFour, first: false, last: true)
                      ],
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            otpNumber = _fieldOne.text +
                                _fieldTwo.text +
                                _fieldThree.text +
                                _fieldFour.text;
                            if (otpNumber == otp) {
                              showToast("OTP is verified successfully");
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (c) => PinGenScreen(
                                        token: token.toString(),
                                      )));
                            } else {
                              showToast("OTP is verified failed");
                            }
                          });
                        },
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(mainColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Verify and continue',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  const Text(
                    "Didn't get OTP? ",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black38,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  GestureDetector(
                    onTap: () {
                      getData();
                    },
                    child: Text(
                      "Resend New OTP",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: mainColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getData() async {
    String otpvalue = OTP(4);
    final response = await http.post(
        Uri.parse("https://sapteleservices.com/SMS_API/sendsms.php"),
        body: ({
          'username': "panskill",
          'password': "d99140",
          'mobile': mobile,
          'sendername': "PASKCO",
          'message': "The OTP for your registration at Pan Skill Connect is " +
              otpvalue +
              ".Please submit for phone number verification.PANSKILL CONNECT PRIVATE LIMITED.",
          'routetype': "1",
          'tid': "1607100000000187941"
        }));
    if (response.statusCode == 200) {
      showToast("OTP Resend successfully");
      otp = otpvalue;
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Invalid credential")));
    }
    // var json = jsonDecode(response.body);
    setState(() {
      // _data = Users.fromJson(json);
      isLoading = false;
    });
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: mainColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }
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

class OtpInput extends StatelessWidget {
  final TextEditingController controller;
  final bool first, last;
  Color mainColor = Color(0xff014c92);

  OtpInput(
      {Key? key,
      required this.first,
      required this.last,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          autofocus: false,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          controller: controller,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: mainColor),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }

  closeKeyboard(BuildContext context) {
    var currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
