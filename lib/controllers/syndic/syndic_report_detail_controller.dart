import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:syndease/utils/services.dart';
import 'package:syndease/utils/widgets.dart';

import '../../models/group_report.dart';
import '../../models/report.dart';
import '../../utils/app_vars.dart';

class SyndicReportDetailController extends GetxController {
  RxBool loading = false.obs;
  Report report = Report();
  TextEditingController commentController = TextEditingController();
  submit(status) {
    print(status);
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
                              Get.back();

                              await FirebaseFirestore.instance
                                  .collection('reports')
                                  .doc(report.uid)
                                  .update({
                                'status': status,
                                'syndic_description': commentController.text
                              });
                              Reportgroup reportGroup = Reportgroup(
                                  syndicUid: report.syndicUid!.uid,
                                  reports: [report],
                                  creationDate: DateTime.now().toString());

                              if (report.status == 'pending' ||
                                  report.status == 'declined') {
                                report.status = status;
                                report.syndicDescription =
                                    commentController.text;
                                report.status = status;
                                update();
                                await FirebaseFirestore.instance
                                    .collection('group_reports')
                                    .add(reportGroup.toJson());
                              } else {
                                report.status = status;
                                report.syndicDescription =
                                    commentController.text;
                                report.status = status;
                                update();
                              }

                              sendNotification(report.clientUid!.fcm,
                                  "report $status", commentController.text);
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

  @override
  void onInit() {
    loading.toggle();
    update();
    report = Get.arguments.first;
    loading.toggle();
    update();
    super.onInit();
  }
}
