import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:syndease/controllers/welcome_controller.dart';

import 'package:get/get.dart';
import 'package:syndease/utils/appVars.dart';
import 'package:syndease/utils/widgets.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WelcomeController>(
        init: WelcomeController(),
        builder: (controller) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            body: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 60.w, right: 60.w),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [logoWhite],
                      ),
                      70.verticalSpace,
                      Text("welcometext", style: titleTextStyle).tr(),
                      30.verticalSpace,
                      IntlPhoneField(
                        onCountryChanged: (value) {
                          controller.phoneController.text = value.dialCode;
                          controller.range = value.maxLength;
                          controller.phoneController.clear();
                          controller.update();
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(controller.range),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        controller: controller.phoneController,
                        key: super.key,
                        dropdownTextStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold),
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(
                            IconlyLight.call,
                            color: Colors.white,
                          ),
                          hintStyle: TextStyle(
                            fontSize: 21.sp,
                            color: Colors.white,
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.5),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.r),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.r),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.r),
                            borderSide:
                                const BorderSide(color: Colors.white, width: 1),
                          ),
                        ),
                        initialCountryCode: 'MA',
                        invalidNumberMessage: '',
                      ),
                      30.verticalSpace,
                      PrimaryButton(
                          loading: controller.loading.value,
                          text: "login",
                          onpress: () => {controller.submit()})
                    ]),
              ), /* add child content here */
            ),
          );
        });
  }
}
