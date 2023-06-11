import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:syndease/controllers/verify_controller.dart';
import 'package:syndease/utils/widgets.dart';

import 'package:get/get.dart';

import '../utils/app_vars.dart';

class VerifyScreen extends StatelessWidget {
  const VerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerifyController>(
        init: VerifyController(),
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
                              text: "verifytext",
                              gradient: gradientColor,
                              style: blueTitleTextStyle),
                          10.verticalSpace,
                          Text("entercode", style: textStyle).tr(),
                          70.verticalSpace,
                          Center(
                             
                              child: Center(
                                  child: PinCodeTextField(
                            cursorColor: darkColor,
                            backgroundColor: Colors.transparent,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(6),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            length: 6,
                            obscureText: false,
                            animationType: AnimationType.fade,
                            textStyle: TextStyle(
                                color: darkColor,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold),
                            pinTheme: PinTheme(
                              disabledColor: Colors.transparent,
                              inactiveFillColor: Colors.transparent,
                              selectedColor: darkColor,
                              selectedFillColor: Colors.transparent,
                              errorBorderColor: Colors.transparent,
                              activeColor: darkColor,
                              inactiveColor: darkColor,
                              shape: PinCodeFieldShape.underline,
                              fieldHeight: 60,
                              fieldWidth: 40,
                              activeFillColor: Colors.transparent,
                            ),
                            animationDuration:
                                const Duration(milliseconds: 300),
                            enableActiveFill: true,
                            // errorAnimationController: errorController,
                            controller: controller.pinController,
                            onCompleted: (v) {
                              // controller.allowed = true;
                              controller.pinController.text = v;
                              controller.update();
                            },
                            onChanged: (value) {
                              // controller.allowed = false;
                              controller.update();
                            },

                            beforeTextPaste: (text) {
                              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                              //but you can show anything you want here, like your pop up saying wrong paste format or etc
                              return true;
                            },
                            appContext: context,
                          ))),
                          80.verticalSpace,
                          SecondaryButton(
                            loading: controller.loading.value,
                            text: "verifynumber",
                            onpress: () => {controller.submit()},
                          ),
                          80.verticalSpace,
                        ]),
                  ),
                ),
              ), /* add child content here */
            ),
          );
        });
  }
}
