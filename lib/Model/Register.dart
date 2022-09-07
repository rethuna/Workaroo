// To parse this JSON data, do
//
//     final register = registerFromJson(jsonString);

import 'dart:convert';

Register registerFromJson(String str) => Register.fromJson(json.decode(str));

String registerToJson(Register data) => json.encode(data.toJson());

class Register {
  Register({
    this.data,
    this.meta,
  });

  Data? data;
  Meta? meta;

  factory Register.fromJson(Map<String, dynamic> json) => Register(
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
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Meta {
  Meta({
    required this.token,
  });

  String token;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
