import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:get/get.dart';
import 'package:syndease/models/sn_user.dart';
import 'package:syndease/screens/client/home_screen.dart';
import 'package:syndease/utils/services.dart';

import '../utils/app_vars.dart';

class CompleteProfileController extends GetxController {
  var backgroundColor = Colors.transparent;

  RxBool loading = false.obs;
  SnUser snUser = SnUser();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();

  verify() async {
    if (firstnameController.text.trim().length < 3) {
      Get.snackbar("Error", "Enter a valid first name",
          colorText: Colors.white, backgroundColor: dangerColor);
      return false;
    } else if (lastnameController.text.trim().length < 3) {
      Get.snackbar("Error", "Enter a valid last name",
          colorText: Colors.white, backgroundColor: dangerColor);
      return false;
    } else {
      return true;
    }
  }

  submit() {
    verify().then((value) async {
      if (value) {
        loading.toggle();
        update();
        snUser.fullname =
            "${firstnameController.text.trim().toLowerCase()} ${lastnameController.text.trim().toLowerCase()}";
        await saveUserToDb(snUser).then((value) async {
          await SessionManager().set('progress', 'homeScreen');
          saveToSession(snUser);
          Get.snackbar("Success", "User saved",
              colorText: Colors.green, backgroundColor: successColor);
          Get.offAll(() => const HomeScreen(),
              transition: Transition.fadeIn,
              duration: const Duration(milliseconds: 500));
          loading.toggle();
          update();
        });
      }
    });
  }

  @override
  void onInit() {
    getUserFromSession().then((value) {
      snUser = value;
 
    });
    // TODO: implement onInit
    super.onInit();
  }
}
