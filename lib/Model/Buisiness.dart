// To parse this JSON data, do
//
//     final business = businessFromJson(jsonString);

import 'dart:convert';

Business businessFromJson(String str) => Business.fromJson(json.decode(str));

String businessToJson(Business data) => json.encode(data.toJson());

class Business {
  Business({
    required this.data,
  });

  List<Datum> data;

  factory Business.fromJson(Map<String, dynamic> json) => Business(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.slug,
    required this.name,
    required this.icon,
  });

  int id;
  String slug;
  String name;
  String icon;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    slug: json["slug"],
    name: json["name"],
    icon: json["icon"] == null ? null : json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "name": name,
    "icon": icon == null ? null : icon,
  };
}
