import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:syndease/controllers/syndic/syndic_home_controller.dart';
import 'package:syndease/models/report.dart';
import 'package:syndease/models/sn_user.dart';
import 'package:syndease/utils/services.dart';
import 'package:syndease/utils/widgets.dart';

import '../../models/group_report.dart';
import '../../screens/syndic/syndic_home_screen.dart';
import '../../screens/syndic/syndic_report_detail_screen.dart';
import '../../utils/app_vars.dart';

class GroupReportController extends GetxController {
  RxBool loading = false.obs;
  Reportgroup reportgroup = Reportgroup();
  Report report = Report();
  TextEditingController commentController = TextEditingController();
  SnUser snUser = SnUser();
  @override
  Future<void> onInit() async {
    loading.toggle();
    update();
    await getUserFromSession().then((value) async {
      snUser = value;

      reportgroup = Get.arguments.first;
      await getReportByid(reportgroup.reports![0].uid).then((value) async {
        report = value;
      });
      loading.toggle();
      update();
    });
    super.onInit();
  }

  void goTo(Report rep) async {
    rep.status = report.status;

    Get.to(() => const SyndicReportDetailScreen(),
        arguments: [rep],
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 500));
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
                              for (var element in reportgroup.reports!) {
                                element.status = status;
                                element.syndicDescription =
                                    commentController.text;
                                update();
                                selectedReports.add(element);
                                await FirebaseFirestore.instance
                                    .collection('reports')
                                    .doc(element.uid)
                                    .update({
                                  'status': status,
                                  'syndic_description': commentController.text
                                });
                                sendNotification(element.clientUid!.fcm,
                                    "report $status", commentController.text);
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
                              final syndicHomeSController = Get.put(
                                SyndicHomeController(),
                              );
                              syndicHomeSController.onInit();
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
