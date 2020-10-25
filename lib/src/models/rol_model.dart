// To parse this JSON data, do
//
//     final rolModel = rolModelFromJson(jsonString);

import 'dart:convert';

RolModel rolModelFromJson(String str) => RolModel.fromJson(json.decode(str));

String rolModelToJson(RolModel data) => json.encode(data.toJson());

class RolModel {
  RolModel({
    this.id,
    this.mail = 'correo@gmail.com',
    this.rnca = '1-12',
    this.rrol = 'U',
  });

  String id;
  String mail;
  String rnca;
  String rrol;

  factory RolModel.fromJson(Map<String, dynamic> json) => RolModel(
        id: json["id"],
        mail: json["mail"],
        rnca: json["rnca"],
        rrol: json["rrol"],
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        "mail": mail,
        "rnca": rnca,
        "rrol": rrol,
      };
}
