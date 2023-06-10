// To parse this JSON data, do
//
//     final snUser = snUserFromJson(jsonString);

import 'dart:convert';

SnUser snUserFromJson(String str) => SnUser.fromJson(json.decode(str));

String snUserToJson(SnUser data) => json.encode(data.toJson());

class SnUser {
  String? uid;
  String? fullname;
  String? phoneNumber;
  int? type;  
  String? latitude;
  String? longitude;
  String? fcm;
  SnUser({
    this.uid,
    this.fullname,
    this.phoneNumber,
    this.type = 0,
    this.longitude,
    this.latitude,
    this.fcm,
  });

  factory SnUser.fromJson(Map<String, dynamic> json) => SnUser(
        uid: json["uid"],
        fullname: json["fullname"],
        phoneNumber: json["phone_number"],
        type: json["type"] ?? 0,
        latitude: json["latitude"].toString(),
        longitude: json["longitude"].toString(),
        fcm: json["fcm"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "fullname": fullname,
        "phone_number": phoneNumber,
        "type": type ?? 0,
        "latitude": latitude,
        "longitude": longitude,
        "fcm": fcm,
      };
}
