// https://app.quicktype.io/?share=4Ik8Upww0mN33e2CBVmq

// To parse this JSON data, do
//
//     final houseModel = houseModelFromJson(jsonString);

import 'dart:convert';

HouseModel houseModelFromJson(String str) =>
    HouseModel.fromJson(json.decode(str));

String houseModelToJson(HouseModel data) => json.encode(data.toJson());

class HouseModel {
  HouseModel({
    this.id,
    this.cdep = 'Guatemala',
    this.cdir = '1ra. Calle, 2da. Avenida "A"',
    this.cmun = 'Villa Nueva',
    this.cnca = '10-',
    this.cres = 'San Leónidas',
    this.ctip = 'Propia',
    this.czon = 4,
  });

  String id;
  String cdep;
  String cdir;
  String cmun;
  String cnca;
  String cres;
  String ctip;
  int czon;

  factory HouseModel.fromJson(Map<String, dynamic> json) => HouseModel(
        id: json["id"],
        cdep: json["cdep"],
        cdir: json["cdir"],
        cmun: json["cmun"],
        cnca: json["cnca"],
        cres: json["cres"],
        ctip: json["ctip"],
        czon: json["czon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cdep": cdep,
        "cdir": cdir,
        "cmun": cmun,
        "cnca": cnca,
        "cres": cres,
        "ctip": ctip,
        "czon": czon,
      };
}
