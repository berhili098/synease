// To parse this JSON data, do
//
//     final residence = residenceFromJson(jsonString);

import 'dart:convert';

Residence residenceFromJson(String str) => Residence.fromJson(json.decode(str));

String residenceToJson(Residence data) => json.encode(data.toJson());

class Residence {
  String? uid;
  String? name;
  String? address;
  String? city;

  Residence({
    this.uid,
    this.name,
    this.address,
    this.city,
  });

  Residence copyWith({
    String? uid,
    String? name,
    String? address,
    String? city,
  }) =>
      Residence(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        address: address ?? this.address,
        city: city ?? this.city,
      );

  factory Residence.fromJson(Map<String, dynamic> json) => Residence(
        uid: json["uid"],
        name: json["name"],
        address: json["address"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "address": address,
        "city": city,
      };
}
