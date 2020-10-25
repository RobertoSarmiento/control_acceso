// To parse this JSON data, do
//
//     final personModel = personModelFromJson(jsonString);

import 'dart:convert';

PersonModel personModelFromJson(String str) =>
    PersonModel.fromJson(json.decode(str));

String personModelToJson(PersonModel data) => json.encode(data.toJson());

class PersonModel {
  PersonModel({
    this.id,
    this.vdpi = 8476925470101,
    this.vnom = 'Juan José',
    this.vape = 'Castillo Flores',
    this.vnca = '12-02',
    this.vpla,
    this.vce1 = 54636457,
    this.vce2 = 43940390,
    this.vfcr,
    this.vfmo,
    this.vidb,
    this.mail,
    this.vurl,
  });

  String id;
  int vdpi;
  String vnom;
  String vape;
  String vnca;
  String vpla;
  int vce1;
  int vce2;
  String vfcr;
  String vfmo;
  bool vidb;
  String mail;
  String vurl;

  factory PersonModel.fromJson(Map<String, dynamic> json) => PersonModel(
        id: json["id"],
        vdpi: json["vdpi"],
        vnom: json["vnom"],
        vape: json["vape"],
        vnca: json["vnca"],
        vpla: json["vpla"],
        vce1: json["vce1"],
        vce2: json["vce2"],
        vfcr: json["vfcr"],
        vfmo: json["vfmo"],
        vidb: json["vidb"],
        mail: json["mail"],
        vurl: json["vurl"],
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        "vdpi": vdpi,
        "vnom": vnom,
        "vape": vape,
        "vnca": vnca,
        "vpla": vpla,
        "vce1": vce1,
        "vce2": vce2,
        "vfcr": vfcr,
        "vfmo": vfmo,
        "vidb": vidb,
        "mail": mail,
        "vurl": vurl,
      };
}
