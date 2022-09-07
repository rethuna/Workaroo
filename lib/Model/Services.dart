// To parse this JSON data, do
//
//     final services = servicesFromJson(jsonString);

import 'dart:convert';

Services servicesFromJson(String str) => Services.fromJson(json.decode(str));

String servicesToJson(Services data) => json.encode(data.toJson());

class Services {
  Services({
    required this.data,
  });

  List<Datum> data;

  factory Services.fromJson(Map<String, dynamic> json) => Services(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.icon,
  });

  int id;
  String name;
  String icon;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    icon: json["icon"] == null ? null : json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "icon": icon == null ? null : icon,
  };
}
