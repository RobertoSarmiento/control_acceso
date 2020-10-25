// https://app.quicktype.io/?share=4Ik8Upww0mN33e2CBVmq

// To parse this JSON data, do
//
//     final vehicleModel = vehicleModelFromJson(jsonString);

import 'dart:convert';

VehicleModel vehicleModelFromJson(String str) =>
    VehicleModel.fromJson(json.decode(str));

String vehicleModelToJson(VehicleModel data) => json.encode(data.toJson());

class VehicleModel {
  VehicleModel({
    this.id,
    this.atpl = 'P',
    this.apla,
    this.amar = 'Mazda',
    this.alin,
    this.amod = 2005,
    this.atve,
    this.acol,
    this.aotr,
    this.anca,
    this.afcr,
    this.afmo,
    this.aidb = false,
    this.mail,
    this.aurl,
  });

  String id;
  String atpl;
  String apla;
  String amar;
  String alin;
  int amod;
  String atve;
  String acol;
  String aotr;
  String anca;
  String afcr;
  String afmo;
  bool aidb;
  String mail;
  String aurl;

  factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
        id: json["id"],
        atpl: json["atpl"],
        apla: json["apla"],
        amar: json["amar"],
        alin: json["alin"],
        amod: json["amod"],
        atve: json["atve"],
        acol: json["acol"],
        aotr: json["aotr"],
        anca: json["anca"],
        afcr: json["afcr"],
        afmo: json["afmo"],
        aidb: json["aidb"],
        mail: json["mail"],
        aurl: json["aurl"],
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        "atpl": atpl,
        "apla": apla,
        "amar": amar,
        "alin": alin,
        "amod": amod,
        "atve": atve,
        "acol": acol,
        "aotr": aotr,
        "anca": anca,
        "afcr": afcr,
        "afmo": afmo,
        "aidb": aidb,
        "mail": mail,
        "aurl": aurl,
      };
}
