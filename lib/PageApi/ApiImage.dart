import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Model/Services.dart';
class MyGetHttpData extends StatefulWidget {
  @override
  MyGetHttpDataState createState() => MyGetHttpDataState();
}

// Create the state for our stateful widget
class MyGetHttpDataState extends State<MyGetHttpData> {
  final String url = "https://jsonplaceholder.typicode.com/photos";
  late List data;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Api'),
        ),
        body: SafeArea(
            child: _loadedPhotos.length == 0
                ? Center(
              child: ElevatedButton(
                child: Text('Load Photos'),
                onPressed: _fetchData,
              ),
            )
            // The ListView that displays photos
                : ListView.builder(
              itemCount: _loadedPhotos.length,
              itemBuilder: (BuildContext ctx, index) {
                return ListTile(
                  leading: Image.network(
                    _loadedPhotos[index]["thumbnailUrl"],
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                  title: Text(_loadedPhotos[index]['title']),
                  subtitle:
                  Text('Photo ID: ${_loadedPhotos[index]["id"]}'),
                );
              },
            ))
    );
  }
}