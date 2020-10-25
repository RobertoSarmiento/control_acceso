// To parse this JSON data, do
//
//     final paymentModel = paymentModelFromJson(jsonString);

import 'dart:convert';

PaymentModel paymentModelFromJson(String str) =>
    PaymentModel.fromJson(json.decode(str));

String paymentModelToJson(PaymentModel data) => json.encode(data.toJson());

class PaymentModel {
  PaymentModel({
    this.id,
    this.pnca = '2-12',
    this.pano = 2020,
    this.pmes = 02,
    this.pfec = '03/01/2020',
    this.phor = '17:23',
    this.pmon = 80,
  });

  String id;
  String pnca;
  int pano;
  int pmes;
  String pfec;
  String phor;
  int pmon;

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        id: json["id"],
        pnca: json["pnca"],
        pano: json["pano"],
        pmes: json["pmes"],
        pfec: json["pfec"],
        phor: json["phor"],
        pmon: json["pmon"],
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        "pnca": pnca,
        "pano": pano,
        "pmes": pmes,
        "pfec": pfec,
        "phor": phor,
        "pmon": pmon,
      };
}
