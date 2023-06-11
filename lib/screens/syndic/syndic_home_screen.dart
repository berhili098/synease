import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:syndease/controllers/syndic/syndic_home_controller.dart';
import 'package:syndease/screens/syndic/new_reports_list_screen.dart';
import 'package:syndease/screens/syndic/syndic_report_detail_screen.dart';
import 'package:syndease/utils/widgets.dart';

import '../../utils/app_vars.dart';
import '../../utils/loading_widget.dart';
import '../../utils/services.dart';
import '../profile_screen.dart';
import 'group_reports_screen.dart';

class SyndicHomeScreen extends StatelessWidget {
  const SyndicHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backColor,
        body: GetBuilder<SyndicHomeController>(
            init: SyndicHomeController(),
            builder: (controller) {
              return controller.loading.value
                  ? Center(child: LoadingWidget())
                  : SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 38.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            82.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  'assets/images/syndease.png',
                                  height: 33.h,
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
                            33.verticalSpace,
                            GradientText(
                                text: plural('hello', 0, args: [
                                  (capitalize(controller.snUser.fullname!
                                              .split(' ')
                                              .length >
                                          1
                                      ? controller.snUser.fullname!
                                          .split(' ')[1]
                                      : controller.snUser.fullname!))
                                ]),
                                gradient: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [primaryColor, Color(0xff61d0ff)]),
                                style: TextStyle(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w700,
                                )),
                            Text(
                              plural('youhavepending', 0,
                                  args: [controller.reports.length.toString()]),
                              style: TextStyle(
                                fontSize: 19.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff545454),
                              ),
                            ),
                            32.verticalSpace,
                            controller.reports.isNotEmpty
                                ? Text('mostrecent',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w700,
                                    )).tr()
                                : Container(),
                            16.verticalSpace,
                            controller.reports.isNotEmpty
                                ? Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.r),
                                      gradient: const LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                            primaryColor,
                                            Color(0xff61d0ff)
                                          ]),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30.h),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          27.verticalSpace,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              CategoryWidget(
                                                  category: controller
                                                      .reports[0].category!),
                                              const Spacer(),
                                              Text(
                                                  controller.reports[0]
                                                      .clientUid!.fullname!,
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                  )),
                                              7.horizontalSpace,
                                              Container(
                                                width: 20.w,
                                                height: 20.h,
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(
                                                  IconlyLight.profile,
                                                  color: primaryColor,
                                                  size: 9,
                                                ),
                                              ),
                                            ],
                                          ),
                                          33.verticalSpace,
                                          Text(
                                            controller.reports[0].title!,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                                fontSize: 17.sp),
                                          ),
                                          9.verticalSpace,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 198.w,
                                                child: Text(
                                                  controller
                                                      .reports[0].description!,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 13.sp),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 3,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Get.to(
                                                      () =>
                                                          const SyndicReportDetailScreen(),
                                                      arguments: [
                                                        controller.reports[0]
                                                      ],
                                                      transition:
                                                          Transition.fadeIn,
                                                      duration: const Duration(
                                                          milliseconds: 500));
                                                },
                                                child: Container(
                                                    height: 59.w,
                                                    width: 59.w,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  30.r)),
                                                      color: Colors.white,
                                                    ),
                                                    child: Center(
                                                      child: GradientText(
                                                        widget: const Icon(Icons
                                                            .arrow_forward),
                                                        gradient:
                                                            const LinearGradient(
                                                                begin: Alignment
                                                                    .topLeft,
                                                                end: Alignment
                                                                    .bottomRight,
                                                                colors: [
                                                              primaryColor,
                                                              Color(0xff61d0ff)
                                                            ]),
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          ),
                                          23.verticalSpace,
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(),
                            37.verticalSpace,
                            controller.reportgroup.isNotEmpty ||
                                    controller.reports.isNotEmpty
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('approvedreports',
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w700,
                                          )).tr(),
                                      InkWell(
                                        onTap: () {
                                          Get.to(
                                              () =>
                                                  const NewReportsListScreen(),
                                              transition: Transition.fadeIn,
                                              duration: const Duration(
                                                  milliseconds: 500));
                                        },
                                        child: Text(
                                          'seeall',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700,
                                            color: primaryColor,
                                          ),
                                        ).tr(),
                                      ),
                                    ],
                                  )
                                : SvgPicture.asset(
                                    'assets/images/not-found.svg',
                                    height: 309.h,
                                    width: double.infinity,
                                  ),
                            16.verticalSpace,
                            controller.reportgroup.isNotEmpty
                                ? Text('clickoneach',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    )).tr()
                                : Container(),
                            controller.reportgroup.isNotEmpty
                                ? SizedBox(
                                    height: 1.sh - 550.h,
                                    width: 1.sw,
                                    child: ListView.builder(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: controller.reportgroup.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Column(
                                          children: [
                                            21.verticalSpace,
                                            InkWell(
                                              onTap: () {
                                                Get.to(
                                                    () =>
                                                        const GroupReportScreen(),
                                                    transition:
                                                        Transition.fadeIn,
                                                    arguments: [
                                                      controller
                                                          .reportgroup[index]
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
                                                          offset: const Offset(
                                                              0,
                                                              4), // changes position of shadow
                                                        ),
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.r),
                                                      color: Colors.white),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
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
                                                                  .reportgroup[
                                                                      index]
                                                                  .reports![0]
                                                                  .title!,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      16.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            ),
                                                            SizedBox(
                                                              width: 150.w,
                                                              child: Text(
                                                                controller
                                                                    .reportgroup[
                                                                        index]
                                                                    .reports![0]
                                                                    .description!,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 2,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        12.sp,
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
                                                              child:
                                                                  CategoryWidget(
                                                                category: controller
                                                                    .reportgroup[
                                                                        index]
                                                                    .reports![0]
                                                                    .category!,
                                                                isReversed:
                                                                    true,
                                                              ),
                                                            ),
                                                            8.verticalSpace,
                                                            Text(
                                                              changeDateToText(
                                                                  controller
                                                                      .reportgroup[
                                                                          index]
                                                                      .reports![
                                                                          0]
                                                                      .creationDate!),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      12.sp,
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
                                  )
                                : Container()
                          ],
                        ),
                      ),
                    );
            }));
  }
}
