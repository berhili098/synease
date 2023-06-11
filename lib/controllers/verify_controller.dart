import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:syndease/models/sn_user.dart';
import 'package:syndease/screens/verify_success.dart';
import 'package:syndease/utils/app_vars.dart';
import 'package:syndease/utils/services.dart';

class VerifyController extends GetxController {
  TextEditingController pinController = TextEditingController();
  var backgroundColor = Colors.transparent;
  String verificationCode = "";
  String phoneNumber = "";
  RxBool loading = false.obs;
  var smsListerner;
  String? fcm;

  validate() async {
    if (pinController.text.trim().length < 6) {
      Get.snackbar("Error", "Enter a valid code",
          colorText: Colors.white, backgroundColor: dangerColor);
      return false;
    } else {
      return true;
    }
  }

  submit() {
    validate().then((value) async {
      loading.toggle();
      update();
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationCode,
            smsCode: pinController.text.trim());
        UserCredential authResult =
            await FirebaseAuth.instance.signInWithCredential(credential);
        User? user = authResult.user;
        checkPhoneNumber(user!.uid).then((value) async {
          if (value == "found-in-users") {
            await getUserFromDb(user.uid).then((value) async {
              value.fcm = fcm!;
              await saveToSession(value);
              await saveUserToDb(value);
              if (value.type == 0) {
                await SessionManager().set('progress', 'homeScreen');
                Get.offAll(() => const VerifySuccess(),
                    transition: Transition.fadeIn,
                    arguments: "HomeScreen",
                    duration: const Duration(milliseconds: 500));
              } else {
                Get.offAll(() => const VerifySuccess(),
                    transition: Transition.fadeIn,
                    arguments: "SyndicHomeScreen",
                    duration: const Duration(milliseconds: 500));
              }
            });
          } else {
            SnUser snUser = SnUser(
                uid: user.uid,
                phoneNumber: user.phoneNumber,
                fullname: "",
                fcm: fcm!,
                type: 0);
            await saveUserToDb(snUser).then((value) async {
              await saveToSession(snUser);
              await SessionManager().set('progress', 'completeProfile');

              Get.offAll(() => const VerifySuccess(),
                  arguments: "CompleteProfile",
                  transition: Transition.fadeIn,
                  duration: const Duration(milliseconds: 500));
            });
          }
        });
        loading.toggle();
        update();
      } catch (e) {
        loading.toggle();
        update();
        Get.snackbar("Error", "Invalid code",
            colorText: Colors.white, backgroundColor: dangerColor);
      }
    });
  }

  @override
  Future<void> onInit() async {
    fcm = await OneSignal.shared.getDeviceState().then((value) async {
      return value!.userId!;
    });
    phoneNumber = await SessionManager().get('phone');
    verificationCode = Get.arguments;
    try {
      smsListerner = await AltSmsAutofill().listenForSms.then((value) {
        pinController.text == ""
            ? pinController.text =
                value!.replaceAll(RegExp(r'[^0-9]'), '').substring(0, 6)
            : null;

        update();
      });
    } catch (e) {}
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    smsListerner.cancel();
    // TODO: implement dispose
    super.dispose();
  }
}
