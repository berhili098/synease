import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:get/get.dart';
import 'package:syndease/utils/app_vars.dart';
import 'package:syndease/utils/services.dart';

import '../screens/verify_screen.dart';

class WelcomeController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  String countryCode = "+212";
  int range = 9;
  RxBool loading = false.obs;

  verifyPhone() async {
    if (phoneController.text.length < range) {
      Get.snackbar(tr('error'), tr('entervalidnumber'),
          colorText: Colors.white, backgroundColor: dangerColor);
      return false;
    } else {
      return true;
    }
  }

  @override
  void onInit() {
    super.onInit();
    initOneSignal();
  }

  submit() {
    verifyPhone().then((value) async {
      loading.toggle();
      update();
      if (value) {
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: "$countryCode${phoneController.text}",
          verificationCompleted: (phonesAuthCredentials) async {},
          verificationFailed: (FirebaseAuthException e) async {
            loading.toggle();
            update();
            Get.snackbar(tr('error'), e.message!,
                colorText: Colors.white, backgroundColor: dangerColor);
          },
          codeSent: (verificationId, resendingToken) async {
            await SessionManager()
                .set('phone', "$countryCode${phoneController.text}");

            loading.toggle();
            update();
            Get.to(() => const VerifyScreen(),
                arguments: verificationId,
                transition: Transition.fadeIn,
                duration: const Duration(milliseconds: 500));
          },
          codeAutoRetrievalTimeout: (verificationId) async {
            loading.toggle();
            update();
            Get.snackbar(tr('error'), tr('timeout'),
                colorText: Colors.white, backgroundColor: dangerColor);
          },
        );
      } else {
        loading.toggle();
        update();
      }
    });
  }
}
