import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SearchService extends StatelessWidget {
  const SearchService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Panskill',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // This holds a list of fiction users
  // You can use data fetched from a database or a server as well
  final List<Map<String, dynamic>> _allUsers = [
    {"id": 1, "name": "Andy", "age": 29},
    {"id": 2, "name": "Aragon", "age": 40},
    {"id": 3, "name": "Bob", "age": 5},
    {"id": 4, "name": "Barbara", "age": 35},
    {"id": 5, "name": "Candy", "age": 21},
    {"id": 6, "name": "Colin", "age": 55},
    {"id": 7, "name": "Audra", "age": 30},
    {"id": 8, "name": "Banana", "age": 14},
    {"id": 9, "name": "Caversky", "age": 100},
    {"id": 10, "name": "Becky", "age": 32},
  ];
  Color mainColor = const Color(0xff014c92);

  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundUsers = [];

  @override
  initState() {
    // at the beginning, all users are shown
    _foundUsers = _allUsers;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PANSKILL"),
        backgroundColor: mainColor,
        titleTextStyle: TextStyle(fontSize: 16.0),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: mainColor, width: 1.0,),
                  ),
                  hintText: 'Search service',
                  hintStyle: TextStyle(color: Colors.black26,),
                  suffixIcon: Container(
                    margin: EdgeInsets.all(1),
                    height: 58,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      border: Border(
                        left: BorderSide(
                          color: Colors.black12,
                          width: 1.0,
                        ),
                      ),),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                            child: Center(
                              child: IconButton(
                                icon: const Icon(
                                  FontAwesome.briefcase,
                                ),
                                iconSize: 20,
                                color: mainColor,
                                splashColor: Colors.purple,
                                onPressed: () {},
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: mainColor, width: 1.0,),
                  ),
                  hintText: 'Search location',
                  hintStyle: TextStyle(color: Colors.black26,),
                  suffixIcon: Container(
                    margin: EdgeInsets.all(1),
                    height: 58,
                    width:50,
                    decoration: const BoxDecoration(
                      color: Colors.white60,
                      border: Border(
                        left: BorderSide(
                          color: Colors.black12,
                          width: 1.0,
                        ),
                      ),),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                            child: Center(
                              child: IconButton(
                                icon: Icon(
                                  Icons.location_pin,
                                ),
                                iconSize: 23,
                                color: mainColor,
                                splashColor: Colors.purple,
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: _foundUsers.isNotEmpty
                  ? ListView.builder(
                itemCount: _foundUsers.length,
                itemBuilder: (context, index) => Card(
                  key: ValueKey(_foundUsers[index]["id"]),
                  color: Colors.blueGrey,
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: Text(
                      _foundUsers[index]["id"].toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                    title: Text(_foundUsers[index]['name']),
                    subtitle: Text(
                        '${_foundUsers[index]["age"].toString()} years old'),
                  ),
                ),
              )
                  : const Text(
                'No results found',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
