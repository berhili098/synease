import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syndease/utils/widgets.dart';

import 'package:get/get.dart';

import '../controllers/complete_profile_controller.dart';
import '../utils/appVars.dart';

class CompleteProfile extends StatelessWidget {
  const CompleteProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CompleteProfileController>(
        init: CompleteProfileController(),
        builder: (controller) {
          return Scaffold(
            extendBodyBehindAppBar: false,
            body: Container(
              width: double.infinity,
              height: double.infinity,
              color: backgroundColor,
              child: Center(
                child: SingleChildScrollView(
                  reverse: true,
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.only(left: 60.w, right: 60.w),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [logo],
                          ),
                          40.verticalSpace,
                          GradientText(text:"completeprofile",
                              gradient: gradientColor,
                              style: blueTitleTextStyle),
                          10.verticalSpace,
                          Text("plscomplete", style: textStyle).tr(),
                          70.verticalSpace,
                          PrimaryTextField(
                            controller: controller.firstnameController,
                            hintText: "plsenteryourname",
                            centered: false,
                            label: "firstname",
                          ),
                          30.verticalSpace,
                          PrimaryTextField(
                            controller: controller.lastnameController,
                            hintText: "plsenteryourlastname",
                            centered: false,
                            label: "lastname",
                          ),
                          80.verticalSpace,
                          SecondaryButton(
                            loading: controller.loading.value,
                            text: "save",
                            onpress: () => {controller.submit()},
                          ),
                          20.verticalSpace,
                        ]),
                  ),
                ),
              ), /* add child content here */
            ),
          );
        });
  }
}
