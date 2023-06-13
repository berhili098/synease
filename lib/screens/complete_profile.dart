import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syndease/utils/widgets.dart';

import 'package:get/get.dart';

import '../controllers/complete_profile_controller.dart';
import '../utils/app_vars.dart';

class CompleteProfile extends StatelessWidget {
  const CompleteProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CompleteProfileController>(
        init: CompleteProfileController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: backgroundColor,
            body: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.w,
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        logo,
                        40.verticalSpace,
                        GradientText(
                            text: "completeprofile",
                            gradient: gradientColor,
                            style: blueTitleTextStyle),
                        10.verticalSpace,
                        Text("plscomplete", style: textStyle).tr(),
                        50.verticalSpace,
                        PrimaryTextField(
                          controller: controller.firstnameController,
                          hintText: "plsenteryourname",
                          centered: false,
                          label: "firstname",
                        ),
                        15.verticalSpace,
                        PrimaryTextField(
                          controller: controller.lastnameController,
                          hintText: "plsenteryourlastname",
                          centered: false,
                          label: "lastname",
                        ),
                        15.verticalSpace,
                        controller.allSyndics.isEmpty
                            ? Container()
                            : Text(
                                tr('selectyoursyndic'),
                                textAlign: TextAlign.start,
                                style: labelTextStyle,
                              ),
                        10.verticalSpace,
                        controller.allSyndics.isEmpty
                            ? Container()
                            : Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.50),
                                      spreadRadius: -1,
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 0), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: CustomDropdown.search(
                                  borderSide: BorderSide.none,
                                  errorBorderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(14.r),
                                  // filled: true,
                                  fillColor:
                                      const Color.fromARGB(255, 243, 243, 243),
                                  hintStyle: TextStyle(
                                      color: const Color(0xff14213D)
                                          .withOpacity(0.5),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500),
                                  onChanged: (value) {
                                    controller.changeSyndic(value);
                                  },
                                  hintText: tr('selectyoursyndic'),
                                  items: controller.allSyndics.map((e) {
                                    return e.fullname!;
                                  }).toList(),
                                  controller: controller.syndicSelected,
                                ),
                              ),
                        15.verticalSpace,
                        controller.residences.isEmpty
                            ? Container()
                            : Text(
                                tr('selectyourresidence'),
                                textAlign: TextAlign.start,
                                style: labelTextStyle,
                              ),
                        10.verticalSpace,
                        controller.residences.isEmpty
                            ? Container()
                            : Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.50),
                                      spreadRadius: -1,
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 0), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: GetBuilder<CompleteProfileController>(
                                    init: CompleteProfileController(),
                                    builder: (cont) {
                                      return CustomDropdown.search(
                                        borderSide: BorderSide.none,
                                        errorBorderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(14.r),
                                        // filled: true,
                                        fillColor: const Color.fromARGB(
                                            255, 243, 243, 243),
                                        hintStyle: TextStyle(
                                            color: const Color(0xff14213D)
                                                .withOpacity(0.5),
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500),
                                        onChanged: (value) {
                                          cont.changeResidence(value);
                                        },
                                        hintText: tr('selectyourresidence'),
                                        items: cont.residences.map((e) {
                                          return e.name!;
                                        }).toList(),
                                        controller: cont.addressSelected,
                                      );
                                    }),
                              ),
                        15.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 0.4.sw,
                              child: PrimaryTextField(
                                isNumber: true,
                                controller: controller.stage,
                                hintText: "pleaseenteryourstage",
                                centered: false,
                                label: "stage",
                              ),
                            ),
                            SizedBox(
                              width: 0.4.sw,
                              child: PrimaryTextField(
                                isNumber: true,
                                controller: controller.apt,
                                hintText: "pleaseenteryourapt",
                                centered: false,
                                label: "apt",
                              ),
                            ),
                          ],
                        ),
                        80.verticalSpace,
                        SecondaryButton(
                          loading: controller.loading,
                          text: "save",
                          onpress: () => {controller.submit()},
                        ),
                        20.verticalSpace,
                      ]),
                ),
              ),
            ),
          );
        });
  }
}
