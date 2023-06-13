// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';

Categories categoriesFromJson(String str) =>
    Categories.fromJson(json.decode(str));

String categoriesToJson(Categories data) => json.encode(data.toJson());

class Procedure {}

class Categories {
  String? nameEn;
  String? nameFr;
  String? automatedAdviceEn;
  String? automatedAdviceFr;
  Procedure? procedure;
  Categories({
    this.nameEn,
    this.nameFr,
    this.automatedAdviceEn,
    this.automatedAdviceFr,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        nameEn: json["name_en"],
        nameFr: json["name_fr"],
        automatedAdviceEn: json["automated_advice_en"],
        automatedAdviceFr: json["automated_advice_fr"],
      );

  Map<String, dynamic> toJson() => {
        "name_en": nameEn,
        "name_fr": nameFr,
        "automated_advice_en": automatedAdviceEn,
        "automated_advice_fr": automatedAdviceFr,
      };
}
