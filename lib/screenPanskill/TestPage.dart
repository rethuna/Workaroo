import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Contact {
  final String name;

  Contact(this.name);
}

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final contacts = [
    Contact("sahar"),
    Contact("Joe"),
    Contact("fo"),
    Contact("Fifo"),
    Contact("Moshe"),
  ];

  var _displayAll = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          _top(),
        ],
      ),
    );
  }

  _top() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("data_repo/images/logo.png"),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    "Hi..there..",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
                onPressed: () {},
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _gridContacts() {
    final size = _displayAll ? contacts.length : contacts.length - 2;
    final contactsWidget =
        List.generate(size, (index) => _contactItem(contacts[index]))
          ..add(_seeNoSeeMore());
    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 2 / 1,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: contactsWidget,
    );
  }

  Widget _contactItem(Contact item) {
    return Container(
      color: Colors.blue.withOpacity(0.5),
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.person),
          Text(item.name),
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
}
