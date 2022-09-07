import 'package:flutter/material.dart';

class BuisinessPost extends StatefulWidget {
  const BuisinessPost({Key? key}) : super(key: key);

  @override
  State<BuisinessPost> createState() => _BuisinessPostState();
}

class _BuisinessPostState extends State<BuisinessPost> {
  Color mainColor = Color(0xff014c92);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("PANSKILL"),
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 16.0),
        backgroundColor: mainColor,
      ),
      body: Container(
        width: 500,
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.all(7),
              child: Stack(children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: Stack(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(left: 10, top: 5),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  cryptoIcon(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  cryptoNameSymbol(),
                                  Spacer(),
                                //  cryptoChange(),
                                  SizedBox(
                                    width: 10,
                                  ),
                                //  changeIcon(),
                                  SizedBox(
                                    width: 20,
                                  )
                                ],
                              ),
                              Row(
                               // children: <Widget>[cryptoAmount()],
                              )
                            ],
                          ))
                    ],
                  ),
                )
              ]),
            ),
          ),
        )));
  }
  Widget cryptoIcon() {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: Align(
          alignment: Alignment.centerLeft,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),//or 15.0
            child: Container(
              height: 70.0,
              width: 70.0,
              child:Image.asset('data_repo/images/logo.png'),
            ),
          ),),
    );
  }
  Widget cryptoNameSymbol() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Beauty Care \n",
                  style: TextStyle(color: Colors.blue,fontSize: 16)
                ),
                WidgetSpan(
                  child: Icon(Icons.location_on, size: 14),
                ),
                TextSpan(
                  text: "Angamaly\n",
                  style: TextStyle(color:Colors.blue )
                ),
                WidgetSpan(
                  child: Icon(Icons.phone, size: 14),
                ),
                TextSpan(
                    text: "8224244430\n",
                    style: TextStyle(color:Colors.blue )
                ),
              ],
            ),
          ),
        ],)
      ),
    );
  }
  Widget cryptoChange() {
    return Align(
      alignment: Alignment.topRight,
      child: RichText(
        text: TextSpan(
          text: '+3.67%',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.green, fontSize: 20),
          children: <TextSpan>[
            TextSpan(
                text: '\n+202.835',
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
  Widget changeIcon() {
    return Align(
        alignment: Alignment.topRight,
        child: Icon(
          Icons.image,
          color: Colors.green,
          size: 30,
        ));
  }
 /* Widget cryptoAmount() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Row(
          children: <Widget>[
            RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                text: '\n\$12.279',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 35,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: '\n0.1349',
                      style: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }*/
}