import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syndease/models/category.dart';
import 'package:syndease/models/report.dart';
import 'package:syndease/models/sn_user.dart';

import '../../utils/app_vars.dart';
import '../../utils/services.dart';

class ResidenceReportsController extends GetxController {
  RxBool loading = false.obs;
  String selected = 'alls';
  SnUser snUser = SnUser();
  List<Report> reports = [];
  List<String> selections = [
    'alls',
    'pending',
    'completed',
    'declined',
    'ongoing'
  ];
  TextEditingController categoryController = TextEditingController();
  List<String> categoryList = [];
  List<Categories> categoryItems = [];

  changeSelection(String newSelection) {
    selected = newSelection;
    update();
  }

  filterReports() {
    if (selected == 'alls') {
      return reports;
    } else {
      if (categoryController.text.isEmpty) {
        return reports.where((element) => element.status == selected).toList();
      } else {
        return reports
            .where((element) =>
                element.status == selected &&
                element.category == categoryController.text)
            .toList();
      }
    }
  }

  changeColor() {
    Color color = Colors.white;
    switch (selected) {
      case "alls":
        color = primaryColor;
        break;
      case "pending":
        color = orangeColor;
        break;
      case "completed":
        color = successColor;
        break;
      case "declined":
        color = dangerColor;
        break;
      case "ongoing":
        color = successColor;
        break;

      default:
        color = primaryColor;
    }
    return color;
  }

  @override
  Future<void> onInit() async {
    loading.toggle();
    update();
    await getAllCategories().then((value) async {
      categoryItems = value;
      for (var element in categoryItems) {
        Get.locale!.languageCode == 'fr'
            ? categoryList.add(element.nameFr!)
            : categoryList.add(element.nameEn!);
      }
      await getUserFromSession().then((value) async {
        snUser = value;
        await getReportsByResidence(snUser).then((value) async {
          reports = value;
          loading.toggle();
          update();
        });
      });
    });
    super.onInit();
  }
}
