// To parse this JSON data, do
//
//     final skilledModel = skilledModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SkilledModel skilledModelFromJson(String str) => SkilledModel.fromJson(json.decode(str));

String skilledModelToJson(SkilledModel data) => json.encode(data.toJson());

class SkilledModel {
  SkilledModel({
    required this.data,
     this.links,
     this.meta,
  });

  List<Datum> data;
  Links ?links;
  Meta ?meta;

  factory SkilledModel.fromJson(Map<String, dynamic> json) => SkilledModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    links: Links.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "links": links?.toJson(),
    "meta": meta?.toJson(),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.hourlyCost,
    required this.minimumCost,
    required this.dailyCost,
    required this.avatar,
  });

  int id;
  String name;
  String hourlyCost;
  String minimumCost;
  String dailyCost;
  String avatar;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    hourlyCost: json["hourly_cost"],
    minimumCost: json["minimum_cost"],
    dailyCost: json["daily_cost"],
    avatar: json["avatar"] == null ? null : json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "hourly_cost": hourlyCost,
    "minimum_cost": minimumCost,
    "daily_cost": dailyCost,
    "avatar": avatar == null ? null : avatar,
  };
}

class Links {
  Links({
    required this.first,
    required this.last,
    required this.prev,
    required this.next,
  });

  String first;
  String last;
  dynamic prev;
  dynamic next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };
}

class Meta {
  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  int currentPage;
  int from;
  int lastPage;
  List<Link> links;
  String path;
  int perPage;
  int to;
  int total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}

class Link {
  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  String url;
  String label;
  bool active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"] == null ? null : json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url == null ? null : url,
    "label": label,
    "active": active,
  };
}
