import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:syndease/controllers/syndic/syndic_home_controller.dart';
import 'package:syndease/models/group_report.dart';
import 'package:syndease/models/sn_user.dart';
import 'package:syndease/screens/syndic/syndic_home_screen.dart';

import '../../models/category.dart';
import '../../models/report.dart';
import '../../utils/app_vars.dart';
import '../../utils/services.dart';
import '../../utils/widgets.dart';

class NewReportListController extends GetxController {
  RxBool loading = false.obs;
  bool? valueChecked = false;
  List<Report> reports = [];
  List<Report> reports2 = [];
  SnUser snUser = SnUser();
  List<bool> allChecked = [];
  TextEditingController commentController = TextEditingController();
  String selected = 'alls';
  List<String> selections = [
    'alls',
    'pending',
    'completed',
    'declined',
    'ongoing'
  ];

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

  TextEditingController categoryController = TextEditingController();
  List<String> categoryList = [];
  List<Categories> categoryItems = [];

  changeSelection(String newSelection) {
    selected = newSelection;
    changeReportList();
    update();
  }

  List<int> checkCheckBoxesTrue() {
    List<int> indexes = [];
    int i = 0;
    for (var element in allChecked) {
      if (element == true) {
        indexes.add(i);
      }
      i++;
    }

    return indexes;
  }

  List<Report> filterReports() {
    if (selected == 'alls') {
      allChecked = List<bool>.filled(reports.length, false);
      // update();
      return reports;
    } else {
      if (categoryController.text.isEmpty) {
        allChecked = List<bool>.filled(
            reports
                .where((element) => element.status == selected)
                .toList()
                .length,
            false);

        return reports.where((element) => element.status == selected).toList();
      } else {
        allChecked = List<bool>.filled(
            reports
                .where((element) =>
                    element.status == selected &&
                    element.category == categoryController.text)
                .toList()
                .length,
            false);
        return reports
            .where((element) =>
                element.status == selected &&
                element.category == categoryController.text)
            .toList();
      }
    }
  }

  changeReportList() {
    reports2 = filterReports();
    update();
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
        await getSyndicReports(snUser).then((value) async {
          reports = value;
          reports2 = value;
          allChecked = List<bool>.filled(reports.length, false);
          loading.toggle();
          update();
        });
      });
    });
    super.onInit();
  }

  void setChecked(int index, bool value) {
    allChecked[index] = value;
    update();
  }

  submit(status, firstStatus) {
    showDialog(
        context: Get.context!,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: Colors.white,
            contentPadding: EdgeInsets.fromLTRB(23.w, 26.h, 23.w, 0),
            title: Row(
              children: [
                const Icon(IconlyLight.paper),
                15.horizontalSpace,
                Text(
                  'yournote',
                  style: TextStyle(
                      color: darkColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600),
                ).tr(),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    IconlyLight.close_square,
                    color: dangerColor,
                    size: 30.sp,
                  ),
                )
              ],
            ),
            content: TextFormField(
              controller: commentController,
              maxLines: 4,
              decoration: InputDecoration(
                  hintStyle: TextStyle(
                      color: darkColor.withOpacity(0.5), fontSize: 14.sp),
                  fillColor: const Color(0xffEFEFEF),
                  filled: true,
                  hintText: tr(
                    "briefcomment",
                  ),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(15.r))),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(top: 21.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 129.w,
                      height: 35.h,
                      child: SecondaryButton(
                          text: 'confirm',
                          onpress: () async { 
                            if (commentController.text.trim().isEmpty) {
                              Get.snackbar(tr('error'), tr('emptycomment'));
                              return;
                            } else {
                              List<Report> selectedReports = [];
                              for (var element in checkCheckBoxesTrue()) {
                                reports2[element].status = status;
                                reports2[element].syndicDescription =
                                    commentController.text;
                                update();
                                selectedReports.add(reports2[element]);
                                await FirebaseFirestore.instance
                                    .collection('reports')
                                    .doc(reports2[element].uid)
                                    .update({
                                  'status': status,
                                  'syndic_description': commentController.text
                                });
                                sendNotification(
                                    reports2[element].clientUid!.fcm,
                                    "report $status",
                                    commentController.text);
                              }
                              if (firstStatus == 'pending' ||
                                  firstStatus == 'declined') {
                                Reportgroup reportGroup = Reportgroup();
                                reportGroup.reports = selectedReports;
                                reportGroup.syndicUid = snUser.uid;
                                reportGroup.creationDate =
                                    DateTime.now().toString();
                                update();
                                await FirebaseFirestore.instance
                                    .collection('group_reports')
                                    .add(reportGroup.toJson());
                              } else {
                                update();
                              }
                              final SyndicHomeSController = Get.put(
                                SyndicHomeController(),
                              );
                              SyndicHomeSController.onInit();
                              Get.offAll(() => const SyndicHomeScreen(),
                                  transition: Transition.fadeIn,
                                  duration: const Duration(milliseconds: 500));
                            }
                          }),
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }
}
