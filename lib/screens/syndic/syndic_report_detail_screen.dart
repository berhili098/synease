import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:syndease/utils/app_vars.dart';
import 'package:syndease/utils/loading_widget.dart';
import 'package:syndease/utils/widgets.dart';

import '../../controllers/syndic/syndic_report_detail_controller.dart';
import '../../utils/services.dart';
import '../profile_screen.dart';

class SyndicReportDetailScreen extends StatelessWidget {
  const SyndicReportDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backColor,
        body: GetBuilder<SyndicReportDetailController>(
            init: SyndicReportDetailController(),
            builder: (controller) {
              return controller.loading.value
                  ? Center(child: LoadingWidget())
                  : Padding(
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                changeDateToText(
                                    controller.report.creationDate!),
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12.sp),
                              ),
                              const Spacer(),
                              Text(controller.report.clientUid!.fullname!,
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: darkColor,
                                    fontWeight: FontWeight.w700,
                                  )),
                              7.horizontalSpace,
                              Container(
                                width: 20.w,
                                height: 20.h,
                                decoration: const BoxDecoration(
                                  color: primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  IconlyLight.profile,
                                  color: Colors.white,
                                  size: 9,
                                ),
                              ),
                            ],
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
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              controller.report.status == 'pending'
                                  ? SizedBox(
                                      width: 167.w,
                                      height: 45.h,
                                      child: SecondaryButton(
                                          text: 'decline',
                                          onpress: () {
                                            controller.submit("declined");
                                          }),
                                    )
                                  : Container(),
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
                                              controller.submit("ongoing");
                                            } else if (controller
                                                    .report.status ==
                                                'ongoing') {
                                              controller.submit("completed");
                                            }
                                          }),
                                    )
                                  : Container(),
                            ],
                          ),
                          55.verticalSpace,
                        ],
                      ),
                    );
            }));
  }
}
