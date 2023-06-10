// To parse this JSON data, do
//
//     final residence = residenceFromJson(jsonString);

import 'dart:convert';

Residence residenceFromJson(String str) => Residence.fromJson(json.decode(str));

String residenceToJson(Residence data) => json.encode(data.toJson());

class Residence {
  String? uid;
  String? name;
  String? longitude;
  String? latitude;
  String? addresse;
  String? city;

  Residence({
    this.uid,
    this.name,
    this.longitude,
    this.latitude,
    this.addresse,
    this.city,
  });

  factory Residence.fromJson(Map<String, dynamic> json) => Residence(
        uid: json["uid"],
        name: json["name"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        addresse: json["addresse"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "longitude": longitude,
        "latitude": latitude,
        "addresse": addresse,
        "city": city,
      };
}
