import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:panskill/Model/Services.dart';
import 'package:panskill/screenPanskill/Skilled_Service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../screenPanskill/HomePage.dart';
import '../screenPanskill/SearchService.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({Key? key}) : super(key: key);

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  Color mainColor = Color(0xff014c92);
  String? mobile, token;
  Services servModel = Services(data: []);
  List _loadedPhotos = [];
  var _displayAll = false;
  Widget appBarTitle = new Text("PANSKILL");
  Icon actionIcon = new Icon(Icons.search);

  @override
  void initState() {
    super.initState();
    _loadDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(
          'Skilled Workers',
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          SizedBox(width: 20.0,),
          Wrap(
            spacing: 5, // space between two icons
            children: <Widget>[

              IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[dashBg, content],
      ), floatingActionButton: Padding(
      padding: const EdgeInsets.all(20.0),
      child: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SearchService()));
        },
        child: const Icon(Icons.filter_list),
        backgroundColor: mainColor,
      ),
    ),
      floatingActionButtonLocation:FloatingActionButtonLocation.miniEndDocked,

      drawer: MyDrawerDirectory(),

    );
  }

  get dashBg => Column(
        children: <Widget>[
          Expanded(
            child: Container(color: mainColor),
            flex: 3,
          ),
          Expanded(
            child: Container(color: Colors.transparent),
            flex: 5,
          ),
        ],
      );

  get content => Container(
        child: Column(
          children: <Widget>[
          //  header,
            grid,
          ],
        ),
      );

  get header => ListTile(
        contentPadding: const EdgeInsets.only(left: 50, right: 20, top: 50),
        title: const Text(
          'Panskill',
          style: TextStyle(color: Colors.white),
        ),
        subtitle: const Text(
          '10 items',
          style: TextStyle(color: Colors.white70),
        ),
        leading: const CircleAvatar(
          child: Image(
            image: AssetImage('data_repo/images/logo.png'),
            width: 30,
            height: 30,
          ),
        ),
        trailing: Wrap(
          spacing: 5, // space between two icons
          children: <Widget>[
            IconButton(
              icon: actionIcon,
              onPressed: () {
                setState(() {
                  if (this.actionIcon.icon == Icons.search) {
                    this.actionIcon = new Icon(Icons.close);
                    this.appBarTitle = new TextField(
                      style: new TextStyle(
                        color: Colors.white,
                      ),
                      decoration: new InputDecoration(
                          prefixIcon:
                          new Icon(Icons.search, color: Colors.white),
                          hintText: "Search...",
                          hintStyle: new TextStyle(color: Colors.white)),
                    );
                  } else {
                    this.actionIcon = new Icon(Icons.search);
                    this.appBarTitle =  Text("PANSKILL",style: TextStyle(fontSize: 5),);
                  }
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ],
        ),
      );

  get headLine => Padding(
        padding: const EdgeInsets.symmetric(vertical: 150, horizontal: 1),
        child: Text(
          'Panskill',
          style: TextStyle(color: Colors.white),
        ),
      );

  get grid => Expanded(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white70,
                style: BorderStyle.solid,
                width: 1.0,
              ),
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0)),
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(15),
          child: GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 0.85,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: <Widget>[
              for (var i = 0; i < servModel.data.length; i++)
                servModel.data[i].icon.toString().endsWith("null")
                    ? getStructuredGridCell_(
                        servModel.data[i].name.toString(),
                        "electrical.png",servModel.data[i].id,
                      )
                    : getStructuredGridCell(
                        servModel.data[i].name.toString(),
                        servModel.data[i].icon.toString(),servModel.data[i].id,
                      ),
            ],
          ),
        ),
      );

  Widget _contactItem(servModel) {
    return Container(
      color: Colors.blue.withOpacity(0.5),
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.person),
          Text(servModel),
        ],
      ),
    );
  }

  Widget _seeNoSeeMore() {
    return InkWell(
      onTap: () => setState(() => _displayAll = !_displayAll),
      child: Container(
        color: Colors.blue.withOpacity(0.5),
        padding: EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.person),
            Text(_displayAll ? "hide" : "Show all"),
          ],
        ),
      ),
    );
  }

  GestureDetector getStructuredGridCell_(name, image,int id) {
    // Wrap the child under GestureDetector to setup a on click action
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (c) => SkillService(
              serviceId: id.toString(),
            )));
        print("onTap called.");
      },
      //65.3
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                alignment: Alignment.topCenter,
                child: Image(image: AssetImage('data_repo/images/' + image)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(name,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                    style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.normal,
                        fontSize: 12)),
              ),
            )
          ],
        ),
      ),
    );
  }

  GestureDetector getStructuredGridCell(name, image,int id) {
    // Wrap the child under GestureDetector to setup a on click action
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (c) => SkillService(
              serviceId: id.toString(),
            )));
      },
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                alignment: Alignment.topCenter,
                child: image.toString().contains("svg")
                    ? SvgPicture.network(image.toString(),
                        height: 50, width: 50, fit: BoxFit.fill)
                    : Image(
                        image: NetworkImage(image.toString()),
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(name,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                    style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.normal,
                        fontSize: 12)),
              ),
            )
          ],
        ),
      ),
    );
  }

  _loadDetails() async {
    print('inside save preference');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mobile = (prefs.getString('mobile') ?? '');
    token = (prefs.getString('token') ?? '');
    getData();
  }

  Future<List<String>> fetchGalleryData() async {
    try {
      final response = await http
          .get(Uri.parse("https://workaroo.ai/api/services"), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        return compute(parseGalleryData, response.body);
      } else {
        throw Exception('Failed to load');
      }
    } on SocketException catch (e) {
      throw Exception('Failed to load');
    }
  }

  List<String> parseGalleryData(String responseBody) {
    final parsed = List<String>.from(json.decode(responseBody));
    return parsed;
  }

  void getData() async {
    try {
      final response = await http
          .get(Uri.parse("https://workaroo.ai/api/services"),
          headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 201 || response.statusCode == 200) {
        setState(() {
          Map<String, dynamic> resposne = jsonDecode(response.body);
          servModel = Services.fromJson(resposne);
          _loadedPhotos = servModel.data;
        });
      } else if (response.statusCode == 422) {

      }
    } catch (e) {
      print(e);
    }
    // var json = jsonDecode(response.body);
  }
}
