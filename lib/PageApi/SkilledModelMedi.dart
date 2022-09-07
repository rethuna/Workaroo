/*
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:panskill/Model/SkilledModel.dart';
import 'package:panskill/Model/userData.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
      body: ListView.builder(
        padding: const EdgeInsets.all(5.5),
        itemCount: skillModel.data.length,
        itemBuilder: _itemBuilder,
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
                    skillModel.data[index].media.isEmpty
                        ? const CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                          "https://webstockreview.net/images/male-clipart-professional-man-3.jpg"),
                    )
                        :
                    CircleAvatar(
                        radius: 40,
                        backgroundImage: skillModel.data[index].media[index]
                            .collectionName ==
                            'avatar'
                            ? NetworkImage(skillModel
                            .data[index].media[0].path
                            .toString())
                            : NetworkImage(skillModel
                            .data[index].media[1].path
                            .toString())),

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

      */
/* onTap: () => MaterialPageRoute(
          builder: (context) =>
              SecondRoute(id: _data.getId(index), name: _data.getName(index))),*//*

    );
  }
  void checkMethodSimple(int value) {

    if(value > 100)
    {
      print('Value is Bigger than 100');
    }
    else{
      print('Value is Smaller than 100');
    }
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

  _loadDetails() async {
    print('inside save preference');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mobile = (prefs.getString('mobile') ?? '');
    token = (prefs.getString('token') ?? '');
    print(token);
    getData();
  }

  var loading = false;

  void getData() async {
    try {
      final response = await http.post(
        Uri.parse("http://panskillconnect.com/api/skilled_workers/$serviceId"),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        setState(() {
          Map<String, dynamic> resposne = jsonDecode(response.body);
          skillModel = SkilledModel.fromJson(resposne);
          */
/* for (int i = 0; i < skillModel.data.length; i++) {
            print(skillModel.data[i].name);
            String? path = skillModel.data[i].media[i].collectionName;

            if (path == 'cover') {
              print('collname:$path');

              String? pathh = skillModel.data[i].media[0].path;
              String? path2 = skillModel.data[i].media[1].path;
              print('media[0]:$pathh');
              print('media[1]:$path2');
            } else {
              print('collname:$path');

              String? pathh = skillModel.data[i].media[0].path;
              print('media[0]:$pathh');
            }
          }*//*

        });
      } else if (response.statusCode == 422) {}
    } catch (e) {
      print(e);
    }
    // var json = jsonDecode(response.body);
    loading = false;
  }
}
*/
