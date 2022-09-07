import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:panskill/Model/Users.dart';
import 'dart:math';

class ApiDemo extends StatefulWidget {
  const ApiDemo({Key? key}) : super(key: key);

  @override
  State<ApiDemo> createState() => _ApiDemoState();
}

class _ApiDemoState extends State<ApiDemo> {
  Users _data = Users();
  bool isLoading = true;

//https://sapteleservices.com/SMS_API/sendsms.php?username=panskill&
// password=d99140&mobile=8129426067&sendername=PASKCO&
// message=%27The%20OTP%20for%20your%20registration%20at%20Pan%20Skill%20Connect%20is%20%s.%20Please%20submit%20it%20for%20phone%20number%20verification.
// PAN%20SKILL%20CONNECT%20PRIVATE%20LIMITED&routetype=1&tid=1607100000000187941
  void getData() async {
    final response =
    await http.get(Uri.parse("https://fluttmac.github.io/api/user.json"));
    var json = jsonDecode(response.body);
    setState(() {
      _data = Users.fromJson(json);
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : ListView.builder(
            itemCount: _data.data!.length,
            itemBuilder: (context, index) {
              return Container(
                child: Column(
                  children: [
                    Text(_data.data![index].name),
                    Text(_data.data![index].profession),
                    Text(OTP(4)),
                  ],
                ),
              );
            }));
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
