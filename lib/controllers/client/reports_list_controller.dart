import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:syndease/models/sn_user.dart';

import '../../models/category.dart';
import '../../models/report.dart';
import '../../utils/services.dart';

class ReportsListController extends GetxController {
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
        await getAllReports(snUser).then((value) async {
          reports = value;
          loading.toggle();
          update();
        });
      });
    });
    super.onInit();
  }
}
