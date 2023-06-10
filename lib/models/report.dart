// To parse this JSON data, do
//
//     final report = reportFromJson(jsonString);

import 'dart:convert';

import 'package:syndease/models/sn_user.dart';

Report reportFromJson(String str) => Report.fromJson(json.decode(str));

String reportToJson(Report data) => json.encode(data.toJson());

class Report {
  String? uid;
  SnUser? clientUid;
  SnUser? syndicUid;
  String? description;
  String? title;
  String? category;
  String? latitude;
  String? longitude;
  String? image;
  String? status;
  String? syndicDescription;
  String? creationDate;

  Report({
    this.uid,
    this.clientUid,
    this.syndicUid,
    this.description,
    this.title,
    this.category,
    this.latitude,
    this.longitude,
    this.image,
    this.status,
    this.syndicDescription,
    this.creationDate,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        uid: json["uid"],
        clientUid: json["client_uid"] == null
            ? null
            : SnUser.fromJson(json["client_uid"]),
        syndicUid: json["syndic_uid"] == null
            ? null
            : SnUser.fromJson(json["syndic_uid"]),
        description: json["description"],
        title: json["title"],
        category: json["category"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        image: json["image"],
        status: json["status"],
        syndicDescription: json["syndic_description"],
        creationDate: json["creation_date"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "client_uid": clientUid!.toJson(),
        "syndic_uid": syndicUid!.toJson(),
        "description": description,
        "title": title,
        "category": category,
        "latitude": latitude,
        "longitude": longitude,
        "image": image,
        "status": status,
        "syndic_description": syndicDescription,
        "creation_date": creationDate,
      };
}
