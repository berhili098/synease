import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syndease/utils/appVars.dart';
import 'package:syndease/utils/widgets.dart';
import '../controllers/verify_success_controller.dart';

class VerifySuccess extends StatelessWidget {
  const VerifySuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerifySuccessController>(
        init: VerifySuccessController(),
        builder: (controller) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            body: Container(
              width: double.infinity,
              height: double.infinity,
              color: backgroundColor,
              child: Center(
                child: SingleChildScrollView(
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
                          GradientText(
                              text: "success",
                              gradient: gradientColor,
                              style: blueTitleTextStyle),
                          10.verticalSpace,
                          Text("verifiednumber", style: textStyle).tr(),
                          70.verticalSpace,
                          Center(child: successImage),
                          80.verticalSpace,
                          SecondaryButton(
                              text: "continue (${controller.current})",
                              onpress: () => {controller.submit()}),
                        ]),
                  ),
                ),
              ), /* add child content here */
            ),
          );
        });
  }
}
