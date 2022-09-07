import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../screenPanskill/HomePage.dart';
import 'gridview.dart';

class Home_tab extends StatefulWidget {
  const Home_tab({Key? key}) : super(key: key);

  @override
  State<Home_tab> createState() => _Home_tabState();
}

class _Home_tabState extends State<Home_tab> {
  List _loadedPhotos = [];

  // The function that fetches data from the API
  Future<void> _fetchData() async {
    const API_URL = 'https://jsonplaceholder.typicode.com/photos';

    final response = await http.get(Uri.parse(API_URL));
    final data = json.decode(response.body);

    setState(() {
      _loadedPhotos = data;
    });
  }

  Color mainColor = Color(0xff014c92);
  final MyGridView myGridView = MyGridView();
@override
  void initState() {
    super.initState();
    _fetchData();
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
      body: SafeArea(
        child: _loadedPhotos.isEmpty
            ? const Center(
            child: CircularProgressIndicator()
        )
        // The ListView that displays photos
            :
             GridView.builder(
                itemCount: _loadedPhotos.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                          decoration: BoxDecoration(
                              image: new DecorationImage(
                                  image: new NetworkImage(
                                      _loadedPhotos[index]["thumbnailUrl"]),
                                  fit: BoxFit.cover))));
                })

        /*ListView.builder(
                  itemCount: _loadedPhotos.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return ListTile(
                      leading: Image.network(
                        _loadedPhotos[index]["thumbnailUrl"],
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                      title: Text(_loadedPhotos[index]['title']),
                      subtitle: Text('Photo ID: ${_loadedPhotos[index]["id"]}'),
                    );
                  },
                )*/
      ),
      drawer: MyDrawerDirectory(),
    );
  }
}
