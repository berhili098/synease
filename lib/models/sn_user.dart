// To parse this JSON data, do
//
//     final snUser = snUserFromJson(jsonString);

import 'dart:convert';

import 'package:syndease/models/position.dart';
import 'package:syndease/models/residence.dart';

SnUser snUserFromJson(String str) => SnUser.fromJson(json.decode(str));

String snUserToJson(SnUser data) => json.encode(data.toJson());

class SnUser {
    String? uid;
    String? fullname;
    int? type;
    String? phoneNumber;
    String? fcm;
    Position? position;
    List<Residence>? residence;

    SnUser({
        this.uid,
        this.fullname,
        this.type,
        this.phoneNumber,
        this.fcm,
        this.position,
        this.residence,
    });

    SnUser copyWith({
        String? uid,
        String? fullname,
        int? type,
        String? phoneNumber,
        String? fcm,
        Position? position,
        List<Residence>? residence,
    }) => 
        SnUser(
            uid: uid ?? this.uid,
            fullname: fullname ?? this.fullname,
            type: type ?? this.type,
            phoneNumber: phoneNumber ?? this.phoneNumber,
            fcm: fcm ?? this.fcm,
            position: position ?? this.position,
            residence: residence ?? this.residence,
        );

    factory SnUser.fromJson(Map<String, dynamic> json) => SnUser(
        uid: json["uid"],
        fullname: json["fullname"],
        type: json["type"],
        phoneNumber: json["phoneNumber"],
        fcm: json["fcm"],
        position: json["position"] == null ? null : Position.fromJson(json["position"]),
        residence: json["residence"] == null ? [] : List<Residence>.from(json["residence"]!.map((x) => Residence.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "fullname": fullname,
        "type": type,
        "phoneNumber": phoneNumber,
        "fcm": fcm,
        "position": position?.toJson(),
        "residence": residence == null ? [] : List<dynamic>.from(residence!.map((x) => x.toJson())),
    };
}


 