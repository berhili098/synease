// To parse this JSON data, do
//
//     final reportgroup = reportgroupFromJson(jsonString);

import 'dart:convert';

import 'package:syndease/models/report.dart';

Reportgroup reportgroupFromJson(String str) =>
    Reportgroup.fromJson(json.decode(str));

String reportgroupToJson(Reportgroup data) => json.encode(data.toJson());

class Reportgroup {
  String? uid;
  List<Report>? reports;
  String? syndicUid;
  String? creationDate;

  Reportgroup({
    this.uid,
    this.reports,
    this.syndicUid,
    this.creationDate,
  });

  factory Reportgroup.fromJson(Map<String, dynamic> json) => Reportgroup(
        uid: json["uid"],
        reports: json["reports"] == null
            ? []
            : List<Report>.from(
                json["reports"]!.map((x) => Report.fromJson(x))),
        syndicUid: json["syndic_uid"],
        creationDate: json["creation_date"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "reports": reports == null
            ? []
            : List<dynamic>.from(reports!.map((x) => x.toJson())),
        "syndic_uid": syndicUid,
        "creation_date": creationDate,
      };
}
