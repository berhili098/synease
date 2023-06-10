import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:syndease/controllers/syndic/group_report_controller.dart';
import 'package:syndease/utils/appVars.dart';
import 'package:syndease/utils/loading_widget.dart';
import 'package:syndease/utils/widgets.dart';

import '../../utils/services.dart';
import '../profile_screen.dart';

class GroupReportScreen extends StatelessWidget {
  const GroupReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: GetBuilder<GroupReportController>(
            init: GroupReportController(),
            builder: (controller) {
              return !controller.loading.value
                  ? Padding(
                      padding: EdgeInsets.only(left: 40.0.w, bottom: 15.0.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          controller.report.status == 'pending'
                              ? SizedBox(
                                  width: 167.w,
                                  height: 45.h,
                                  child: SecondaryButton(
                                      text: 'decline',
                                      onpress: () {
                                        controller.submit("declined",
                                            controller.report.status);
                                      }),
                                )
                              : SizedBox(
                                  width: 167.w,
                                  height: 45.h,
                                ),
                          controller.report.status != 'declined' &&
                                  controller.report.status != 'completed'
                              ? SizedBox(
                                  width: 167.w,
                                  height: 45.h,
                                  child: SecondaryButton(
                                      text: 'approve',
                                      onpress: () {
                                        if (controller.report.status ==
                                            'pending') {
                                          controller.submit("ongoing",
                                              controller.report.status);
                                        } else if (controller.report.status ==
                                            'ongoing') {
                                          controller.submit("completed",
                                              controller.report.status);
                                        }
                                      }),
                                )
                              : SizedBox(
                                  width: 167.w,
                                  height: 45.h,
                                ),
                        ],
                      ),
                    )
                  : Container();
            }),
        backgroundColor: backColor,
        body: GetBuilder<GroupReportController>(
            init: GroupReportController(),
            builder: (controller) {
              return controller.loading.value
                  ? Center(child: LoadingWidget())
                  : SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            50.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                    width: 29.w,
                                    height: 29.h,
                                    decoration: const BoxDecoration(
                                      border: Border.fromBorderSide(BorderSide(
                                          color: darkColor, width: 2.0)),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        IconlyLight.arrow_left_2,
                                        size: 19.sp,
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(() => const ProfileScreen(),
                                        transition: Transition.fadeIn,
                                        duration:
                                            const Duration(milliseconds: 500));
                                  },
                                  child: Container(
                                    width: 36.w,
                                    height: 36.h,
                                    decoration: const BoxDecoration(
                                      color: secondaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      IconlyLight.profile,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            43.verticalSpace,
                            GradientText(
                                gradient: gradientColor,
                                text: plural("statusreports", 0,
                                    args: [controller.report.status!]),
                                style: blueTitleTextStyle),
                            24.verticalSpace,
                            SizedBox(
                              height: 1.sh - 170.h,
                              width: 1.sw,
                              child: ListView.builder(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount:
                                    controller.reportgroup.reports!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      21.verticalSpace,
                                      InkWell(
                                        onTap: () {
                                          controller.goTo(controller
                                              .reportgroup.reports![index]);
                                        },
                                        child: Container(
                                            height: 80.h,
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.4),
                                                    spreadRadius: 0,
                                                    blurRadius: 10,
                                                    offset: const Offset(0,
                                                        4), // changes position of shadow
                                                  ),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(15.r),
                                                color: Colors.white),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 18.w),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        controller
                                                            .reportgroup
                                                            .reports![index]
                                                            .title!,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                      SizedBox(
                                                        width: 150.w,
                                                        child: Text(
                                                          controller
                                                              .reportgroup
                                                              .reports![index]
                                                              .description!,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                              controller
                                                                  .reportgroup
                                                                  .reports![
                                                                      index]
                                                                  .clientUid!
                                                                  .fullname!,
                                                              style: TextStyle(
                                                                fontSize: 11.sp,
                                                                color:
                                                                    darkColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              )),
                                                          7.horizontalSpace,
                                                          Container(
                                                            width: 20.w,
                                                            height: 20.h,
                                                            decoration:
                                                                const BoxDecoration(
                                                              color:
                                                                  primaryColor,
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child: const Icon(
                                                              IconlyLight
                                                                  .profile,
                                                              color:
                                                                  Colors.white,
                                                              size: 9,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      8.verticalSpace,
                                                      Text(
                                                        changeDateToText(
                                                            controller
                                                                .reportgroup
                                                                .reports![index]
                                                                .creationDate!),
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )),
                                      ),
                                    ],
                                  );
                                },
                                // separatorBuilder:
                                //     (BuildContext context, int index) {
                                //   return 21.verticalSpace;
                                // },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
            }));
  }
}
