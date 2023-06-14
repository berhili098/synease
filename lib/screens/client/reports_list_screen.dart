import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:syndease/controllers/client/reports_list_controller.dart';
import 'package:syndease/screens/client/new_report_screen.dart';
import 'package:syndease/screens/client/report_detail_screen.dart';
import 'package:syndease/utils/app_vars.dart';
import 'package:syndease/utils/loading_widget.dart';
import 'package:syndease/utils/widgets.dart';

import '../../utils/services.dart';
import '../profile_screen.dart';

class ReportsListScreen extends StatelessWidget {
  const ReportsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => const NewReportScreen(),
                transition: Transition.fadeIn,
                duration: const Duration(milliseconds: 500));
          },
          backgroundColor: Colors.transparent,
          child: Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                gradient: gradientColor),
            child: const Icon(IconlyLight.plus),
          ),
        ),
        backgroundColor: backColor,
        body: GetBuilder<ReportsListController>(
            init: ReportsListController(),
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
                                      controller.changeSelection(
                                          controller.selections[index]);
                                    },
                                    child: Container(
                                      width: 64.w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(6.8.r),
                                        color: controller.selected ==
                                                controller.selections[index]
                                            ? controller.changeColor()
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
                                itemCount: controller.filterReports().length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.to(
                                              () => const ReportDetailScreen(),
                                              transition: Transition.fadeIn,
                                              arguments: [
                                                controller
                                                    .filterReports()[index]
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
                                                            .filterReports()[
                                                                index]
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
                                                              .filterReports()[
                                                                  index]
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
                                                      SizedBox(
                                                        height: 23.h,
                                                        child: CategoryWidget(
                                                          category: controller
                                                              .filterReports()[
                                                                  index]
                                                              .category!,
                                                          isReversed: true,
                                                        ),
                                                      ),
                                                      8.verticalSpace,
                                                      Text(
                                                        changeDateToText(
                                                            controller
                                                                .filterReports()[
                                                                    index]
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
                                      20.verticalSpace,
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
