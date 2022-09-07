/*
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Model/Services.dart';
import 'Skilled_Service.dart';

class SO extends StatefulWidget {
  @override
  State<SO> createState() => _SOState();
}

class _SOState extends State<SO> {
  Services servModel = Services(data: []);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[dashBg, content],
      ),

    );

  }

  get dashBg => Column(
        children: <Widget>[
          Expanded(
            child: Container(color: Colors.deepPurple),
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
            header,
            grid,
          ],
        ),
      );

  get header => ListTile(
        contentPadding: EdgeInsets.only(left: 20, right: 20, top: 20),
        leading: CircleAvatar(
          child: Image(
            image: AssetImage('data_repo/images/logo.png'),
            width: 30,
            height: 30,
          ),
        ),
        title: Text(
          'Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          'Services',
          style: TextStyle(color: Colors.blue),
        ),
      );

  get grid => Expanded(
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(32),
          color: Colors.white,
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
}
*/
