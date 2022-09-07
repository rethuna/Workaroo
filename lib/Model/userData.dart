// To parse this JSON data, do
//
//     final UsersData = UsersDataFromJson(jsonString);

import 'dart:convert';

UsersData UsersDataFromJson(String str) => UsersData.fromJson(json.decode(str));

String UsersDataToJson(UsersData data) => json.encode(data.toJson());

class UsersData {
  UsersData({
    this.data,
    this.meta,
  });

  Data? data;
  Meta? meta;

  factory UsersData.fromJson(Map<String, dynamic> json) => UsersData(
    data: Data.fromJson(json["data"]),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "meta": meta?.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.name,
    this.media,
  });

  int? id;
  String? name;
  List<Media>? media;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "media": List<dynamic>.from(media!.map((x) => x.toJson())),
  };
}

class Media {
  Media({
    this.id,
    this.path,
  });

  int? id;
  String? path;

  factory Media.fromJson(Map<String, dynamic> json) => Media(
    id: json["id"],
    path: json["path"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "path": path,
  };
}

class Meta {
  Meta({
    this.token,
  });

  String? token;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
  };
}
