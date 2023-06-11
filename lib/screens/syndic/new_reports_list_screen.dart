import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:syndease/controllers/syndic/new_reports_list_controller.dart';
import 'package:syndease/screens/syndic/syndic_report_detail_screen.dart';
import 'package:syndease/utils/app_vars.dart';
import 'package:syndease/utils/loading_widget.dart';
import 'package:syndease/utils/widgets.dart';

import '../../utils/services.dart';
import '../profile_screen.dart';

class NewReportsListScreen extends StatelessWidget {
  const NewReportsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: GetBuilder<NewReportListController>(
            init: NewReportListController(),
            builder: (controller) {
              return controller.checkCheckBoxesTrue().isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.only(left: 40.0.w, bottom: 15.0.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          controller
                                      .reports2[
                                          controller.checkCheckBoxesTrue()[0]]
                                      .status ==
                                  'pending'
                              ? SizedBox(
                                  width: 167.w,
                                  height: 45.h,
                                  child: SecondaryButton(
                                      text: 'decline',
                                      onpress: () {
                                        controller.submit(
                                            "declined",
                                            controller
                                                .reports2[controller
                                                    .checkCheckBoxesTrue()[0]]
                                                .status);
                                      }),
                                )
                              : SizedBox(
                                  width: 167.w,
                                  height: 45.h,
                                ),
                          controller
                                          .reports2[controller
                                              .checkCheckBoxesTrue()[0]]
                                          .status !=
                                      'declined' &&
                                  controller
                                          .reports2[controller
                                              .checkCheckBoxesTrue()[0]]
                                          .status !=
                                      'completed'
                              ? SizedBox(
                                  width: 167.w,
                                  height: 45.h,
                                  child: SecondaryButton(
                                      text: 'approve',
                                      onpress: () {
                                        if (controller
                                                .reports2[controller
                                                    .checkCheckBoxesTrue()[0]]
                                                .status ==
                                            'pending') {
                                          controller.submit(
                                              "ongoing",
                                              controller
                                                  .reports2[controller
                                                      .checkCheckBoxesTrue()[0]]
                                                  .status);
                                        } else if (controller
                                                .reports2[controller
                                                    .checkCheckBoxesTrue()[0]]
                                                .status ==
                                            'ongoing') {
                                          controller.submit(
                                              "completed",
                                              controller
                                                  .reports2[controller
                                                      .checkCheckBoxesTrue()[0]]
                                                  .status);
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
        body: GetBuilder<NewReportListController>(
            init: NewReportListController(),
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
                                text: "reports",
                                style: blueTitleTextStyle),
                            24.verticalSpace,
                            SizedBox(
                              height: 27.h,
                              child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.selections.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      controller.categoryController.text = '';
                                      controller.changeSelection(
                                          controller.selections[index]);
                                    },
                                    child: Container(
                                      width: 79.w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(6.8.r),
                                        color: controller.selected ==
                                                controller.selections[index]
                                            ? primaryColor
                                            : primaryColor.withOpacity(0.5),
                                      ),
                                      child: Center(
                                          child: Text(
                                        controller.selections[index],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp),
                                      ).tr()),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return 8.horizontalSpace;
                                },
                              ),
                            ),
                            15.verticalSpace,
                            CustomDropdown.search(
                              borderSide: BorderSide(
                                  color: primaryColor.withOpacity(0.5),
                                  width: 1.0),
                              hintStyle: TextStyle(
                                  color:
                                      const Color(0xff14213D).withOpacity(0.5),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500),
                              onChanged: (value) {
                                controller.changeSelection(controller.selected);
                                controller.categoryController.text = value;
                                controller.update();
                              },
                              hintText: tr('selectcategory'),
                              items: controller.categoryList,
                              controller: controller.categoryController,
                            ),
                            16.verticalSpace,
                            SizedBox(
                              height: 1.sh - 289.h,
                              width: 1.sw,
                              child: ListView.builder(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: controller.reports2.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      21.verticalSpace,
                                      InkWell(
                                        onTap: () {
                                          Get.to(
                                              () =>
                                                  const SyndicReportDetailScreen(),
                                              transition: Transition.fadeIn,
                                              arguments: [
                                                controller.reports2[index]
                                              ],
                                              duration: const Duration(
                                                  milliseconds: 500));
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
                                              padding:
                                                  EdgeInsets.only(right: 18.w),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  controller.selected != "alls"
                                                      ? Checkbox(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4.r),
                                                          ),
                                                          activeColor:
                                                              primaryColor,
                                                          value: controller
                                                                  .allChecked[
                                                              index],
                                                          onChanged: (value) {
                                                            controller
                                                                .setChecked(
                                                                    index,
                                                                    value!);
                                                          },
                                                        )
                                                      : Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 50.w),
                                                          child: Container(),
                                                        ),
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
                                                            .reports2[index]
                                                            .title!,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                      SizedBox(
                                                        width: 140.w,
                                                        child: Text(
                                                          controller
                                                              .reports2[index]
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
                                                  const Spacer(),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      controller.selected !=
                                                              "alls"
                                                          ? SizedBox(
                                                              height: 23.h,
                                                              child:
                                                                  CategoryWidget(
                                                                category: controller
                                                                    .reports2[
                                                                        index]
                                                                    .category!,
                                                                isReversed:
                                                                    true,
                                                              ),
                                                            )
                                                          : SizedBox(
                                                              height: 23.h,
                                                              child:
                                                                  StatusWidget(
                                                                status: controller
                                                                    .reports2[
                                                                        index]
                                                                    .status!,
                                                              )),
                                                      8.verticalSpace,
                                                      SizedBox(
                                                        width: 70.w,
                                                        child: Text(
                                                          changeDateToText(
                                                              controller
                                                                  .reports2[
                                                                      index]
                                                                  .creationDate!),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
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
