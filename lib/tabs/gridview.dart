import 'package:flutter/material.dart';

class MyGridView {
  GestureDetector getStructuredGridCell(name, image) {
    // Wrap the child under GestureDetector to setup a on click action
    return GestureDetector(
      onTap: () {
        print("onTap called.");
      },
      child: Card(
          elevation: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[

              Image(image: AssetImage('data_repo/images/' + image)),
              Center(
                child: Text(name,style:
                TextStyle(color: Colors.blue, fontWeight: FontWeight.normal)),
              )
            ],
          )),
    );
  }

  GridView build() {
    return GridView.count(
      primary: true,
      padding: const EdgeInsets.all(1.0),
      crossAxisCount: 2,
      childAspectRatio: 0.85,
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
      children: <Widget>[
        getStructuredGridCell("cleaning", "cleaning.png"),
        getStructuredGridCell("Electrical", "electrical.png"),
        getStructuredGridCell("Education", "education.png"),
        getStructuredGridCell("floor", "floor.png"),
        getStructuredGridCell("fabrication", "fabrication.png"),
        getStructuredGridCell("dc", "dc.png"),
        getStructuredGridCell("Design", "design.png"),
        getStructuredGridCell("cleaning", "cleaning.png"),
        getStructuredGridCell("Education", "education.png"),
        getStructuredGridCell("Electrical", "electrical.png"),
        getStructuredGridCell("fabrication", "fabrication.png"),
        getStructuredGridCell("dc", "dc.png"),
      ],
    );
  }
}
