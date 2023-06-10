// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';

Categories categoriesFromJson(String str) => Categories.fromJson(json.decode(str));

String categoriesToJson(Categories data) => json.encode(data.toJson());

class Categories {
    String? nameEn;
    String? nameFr;

    Categories({
        this.nameEn,
        this.nameFr,
    });

    factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        nameEn: json["name_en"],
        nameFr: json["name_fr"],
    );

    Map<String, dynamic> toJson() => {
        "name_en": nameEn,
        "name_fr": nameFr,
    };
}
