import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:panskill/Model/SkilledModel.dart';
import 'package:panskill/Model/userData.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomePage.dart';

class SkillService extends StatefulWidget {
  final String serviceId;

  const SkillService({Key? key, required this.serviceId}) : super(key: key);

  @override
  State<SkillService> createState() => _SkillServiceState(this.serviceId);
}

class _SkillServiceState extends State<SkillService> {
  String serviceId;
  Color mainColor = Color(0xff014c92);
  String? mobile, token;
  SkilledModel skillModel = SkilledModel(data: []);
  List<SkilledModel> listModel = [];
  List _loadedPhotos = [];
  List<SkilledModel>? subcategories;

  _SkillServiceState(this.serviceId);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PANSKILL"),
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 16.0),
        backgroundColor: mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: (skillModel.data.isNotEmpty)
            ? ListView.builder(
                itemCount: skillModel.data.length,
                itemBuilder: _itemBuilder,
              )
            :  const Center(
                child: SpinKitCircle(
                  color: Colors.blue,
                  size: 80.0,
                ),
              ),
      ),

    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return InkWell(
      child: Card(
        color: Colors.white,
        elevation: 8.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 120,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (skillModel.data[index].avatar?.isEmpty ?? true) const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 40,
                            backgroundImage: AssetImage('data_repo/images/user_demo.png'),
                          ) else CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(
                                skillModel.data[index].avatar.toString())),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      //CrossAxisAlignment.end ensures the components are aligned from the right to left.
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  skillModel.data[index].name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                    'Minimal Cost: ${skillModel.data[index].minimumCost.toString()}'),
                                Text(
                                    'Hourly Cost: ${skillModel.data[index].hourlyCost.toString()}'),
                                Text(
                                    'Daily Cost: ${skillModel.data[index].dailyCost.toString()}'),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      /* onTap: () => MaterialPageRoute(
          builder: (context) =>
              SecondRoute(id: _data.getId(index), name: _data.getName(index))),*/
    );
  }

  void checkMethodSimple(int value) {
    if (value > 100) {
      print('Value is Bigger than 100');
    } else {
      print('Value is Smaller than 100');
    }
  }



  _loadDetails() async {
    print('inside save preference');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mobile = (prefs.getString('mobile') ?? '');
    token = (prefs.getString('token') ?? '');
    // print(token);
    getData();
  }

  void getData() async {
    try {
      final response = await http.post(
        Uri.parse("https://workaroo.ai/api/skilled_workers/$serviceId"),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        setState(() {
          Map<String, dynamic> resposne = jsonDecode(response.body);
          skillModel = SkilledModel.fromJson(resposne);
          if (skillModel.data.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("No Data Found "),
            ));
          }
        });
      } else if (response.statusCode == 404) {}
    } catch (e) {
      print(e);
    }
    // var json = jsonDecode(response.body);
  }
}
