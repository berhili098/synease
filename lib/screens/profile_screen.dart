import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:iconly/iconly.dart';
import 'package:syndease/controllers/profile_controller.dart';
import 'package:syndease/utils/appVars.dart';
import 'package:syndease/utils/services.dart';

import '../utils/loading_widget.dart';
import '../utils/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backColor,
        body: GetBuilder<ProfileController>(
            init: ProfileController(),
            builder: (controller) {
              return controller.loading.value
                  ? LoadingWidget()
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 38.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          82.verticalSpace,
                          Image.asset(
                            'assets/images/syndease.png',
                            height: 33.h,
                          ),
                          64.verticalSpace,
                          GradientText(
                              text: 'accountinformation',
                              gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [primaryColor, Color(0xff61d0ff)]),
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                              )),
                          62.verticalSpace,
                          Center(
                            child: Container(
                              width: 109.w,
                              height: 109.w,
                              decoration: const BoxDecoration(
                                color: primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                IconlyLight.profile,
                                color: Colors.white,
                                size: 56.sp,
                              ),
                            ),
                          ),
                          64.verticalSpace,
                          Text('firstname',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              )).tr(),
                          12.verticalSpace,
                          PrimaryTextField(
                              disabled: true,
                              controller: TextEditingController(
                                  text: capitalize(controller.snUser.fullname!
                                      .split(' ')[0])),
                              centered: false,
                              hintText: 'firstname'.tr()),
                          16.verticalSpace,
                          Text('lastname',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              )).tr(),
                          12.verticalSpace,
                          PrimaryTextField(
                              disabled: true,
                              controller: TextEditingController(
                                  text: capitalize(controller.snUser.fullname!
                                              .split(' ')
                                              .length >
                                          1
                                      ? controller.snUser.fullname!
                                          .split(' ')[1]
                                      : ' ')),
                              centered: false,
                              hintText: 'lastname'.tr()),
                          16.verticalSpace,
                          Text('phone',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              )).tr(),
                          12.verticalSpace,
                          PrimaryTextField(
                              prefixIcon: const Icon(
                                IconlyLight.call,
                                color: Colors.black,
                              ),
                              disabled: true,
                              controller: TextEditingController(
                                  text: controller.snUser.phoneNumber),
                              centered: false,
                              hintText: 'phone'.tr()),
                          20.verticalSpace,
                          Center(
                            child: SizedBox(
                              width: 115.w,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: dangerColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r))),
                                  onPressed: () {
                                    controller.logout(context);
                                  },
                                  child: const Text(
                                    'logout',
                                    style: TextStyle(color: Colors.white),
                                  ).tr()),
                            ),
                          )
                        ],
                      ),
                    );
            }));
  }
}
