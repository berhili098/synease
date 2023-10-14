import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:syndease/controllers/client/home_controller.dart';
import 'package:syndease/screens/client/reports_list_screen.dart';
import 'package:syndease/screens/client/residence_reports_screen.dart';
import 'package:syndease/utils/app_vars.dart';
import 'package:syndease/utils/loading_widget.dart';
import 'package:syndease/utils/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/services.dart';
import '../profile_screen.dart';
import 'new_report_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backColor,
        body: GetBuilder<HomeController>(
            init: HomeController(),
            builder: (controller) {
              return controller.loading.value
                  ? Center(child: LoadingWidget())
                  : Padding(
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
                          121.verticalSpace,
                          GradientText(
                              text: plural('hello', 0, args: [
                                (capitalize(controller.snUser.fullname!
                                            .split(' ')
                                            .length >
                                        1
                                    ? controller.snUser.fullname!.split(' ')[1]
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () => Get.to(
                                    () => const ReportsListScreen(),
                                    transition: Transition.fadeIn,
                                    duration:
                                        const Duration(milliseconds: 500)),
                                child: Text(
                                  'yourreports',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    color: primaryColor,
                                  ),
                                ).tr(),
                              ),
                              InkWell(
                                onTap: () => Get.to(
                                    () => const ResidenceReportsScreen(),
                                    transition: Transition.fadeIn,
                                    duration:
                                        const Duration(milliseconds: 500)),
                                child: Text(
                                  plural('residencereports', 0, args: [
                                    controller.snUser.residence!.first.name!
                                  ]),
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    color: primaryColor,
                                  ),
                                ).tr(),
                              ),
                            ],
                          ),
                          16.verticalSpace,
                          controller.reports.isNotEmpty
                              ? Container(
                                  height: 309.h,
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30.h),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        27.verticalSpace,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              changeDateToText(controller
                                                  .reports[0].creationDate!),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 10.sp),
                                            ),
                                            StatusWidget(
                                                status: controller
                                                    .reports[0].status!)
                                          ],
                                        ),
                                        33.verticalSpace,
                                        SizedBox(
                                          width: 120.w,
                                          child: Text(
                                            controller.reports[0].title!,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                                fontSize: 17.sp),
                                          ),
                                        ),
                                        9.verticalSpace,
                                        SizedBox(
                                          height: 80.h,
                                          child: Text(
                                            controller.reports[0].description!,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13.sp),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 5,
                                          ),
                                        ),
                                        30.verticalSpace,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CategoryWidget(
                                                category: controller
                                                    .reports[0].category!),
                                            InkWell(
                                              onTap: () => Get.to(
                                                  () =>
                                                      const ReportsListScreen(),
                                                  transition: Transition.fadeIn,
                                                  duration: const Duration(
                                                      milliseconds: 500)),
                                              child: Container(
                                                  height: 59.w,
                                                  width: 59.w,
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                30)),
                                                    color: Colors.white,
                                                  ),
                                                  child: Center(
                                                    child: GradientText(
                                                      widget: const Icon(
                                                          Icons.arrow_forward),
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
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : SvgPicture.asset(
                                  'assets/images/not-found.svg',
                                  height: 309.h,
                                  width: double.infinity,
                                ),
                          85.verticalSpace,
                          Center(
                            child: SizedBox(
                              width: 187.w,
                              child: SecondaryButton(
                                widget:
                                    const Icon(Icons.add, color: Colors.white),
                                onpress: () {
                                  Get.to(() => const NewReportScreen(),
                                      transition: Transition.fadeIn,
                                      duration:
                                          const Duration(milliseconds: 500));
                                },
                                text: "newreport",
                              ),
                            ),
                          )
                        ],
                      ),
                    );
            }));
  }
}
