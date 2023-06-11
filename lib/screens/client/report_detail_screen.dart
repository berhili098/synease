import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:syndease/controllers/client/report_detail_controller.dart';
import 'package:syndease/utils/app_vars.dart';
import 'package:syndease/utils/loading_widget.dart';
import 'package:syndease/utils/widgets.dart';

import '../../utils/services.dart';
import '../profile_screen.dart';

class ReportDetailScreen extends StatelessWidget {
  const ReportDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backColor,
        body: GetBuilder<ReportDetailController>(
            init: ReportDetailController(),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GradientText(
                                    gradient: gradientColor,
                                    text: "reportdetails",
                                    style: blueTitleTextStyle),
                                SizedBox(
                                    width: 107.w,
                                    height: 30.h,
                                    child: StatusWidget(
                                        status: controller.report.status!))
                              ],
                            ),
                            26.verticalSpace,
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(9.r),
                                child: CachedNetworkImage(
                                  imageUrl: controller.report.image!,
                                  height: 240.h,
                                  width: 240.w,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                            40.verticalSpace,
                            Text(
                              changeDateToText(controller.report.creationDate!),
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 12.sp),
                            ),
                            24.verticalSpace,
                            Text(
                              controller.report.title!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 20.sp),
                            ),
                            10.verticalSpace,
                            Text(
                              controller.report.description!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14.sp),
                            ),
                            31.verticalSpace,
                            Row(
                              children: [
                                Icon(
                                  IconlyLight.bookmark,
                                  size: 20.sp,
                                  color: primaryColor,
                                ),
                                22.horizontalSpace,
                                SizedBox(
                                  height: 27.h,
                                  child: CategoryWidget(
                                    category: controller.report.category!,
                                    isReversed: true,
                                  ),
                                )
                              ],
                            ),
                            60.verticalSpace,
                            controller.report.syndicDescription != null
                                ? Container(
                                    // height: 154.h,
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
                                          16.verticalSpace,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Icon(
                                                IconlyLight.paper,
                                                color: Colors.white,
                                                size: 20.sp,
                                              ),
                                            ],
                                          ),
                                          15.verticalSpace,
                                          Text(
                                            'syndicnote',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                                fontSize: 17.sp),
                                          ).tr(),
                                          9.verticalSpace,
                                          Text(
                                            controller.report.syndicDescription!
                                            // overflow: TextOverflow.ellipsis,
                                            ,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13.sp),
                                            // overflow: TextOverflow.ellipsis,
                                          ),
                                          31.verticalSpace
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(),
                            20.verticalSpace,
                          ],
                        ),
                      ),
                    );
            }));
  }
}
