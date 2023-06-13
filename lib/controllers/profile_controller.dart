import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:get/get.dart';
import 'package:syndease/models/sn_user.dart';
import 'package:syndease/screens/client/my_syndic_screen.dart';
import 'package:syndease/utils/app_vars.dart';
import 'package:syndease/utils/services.dart';

import '../screens/welcome_screen.dart';

class ProfileController extends GetxController {
  RxBool loading = false.obs;
  SnUser snUser = SnUser();

  Future<Future> logout(context) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          "Confirmation",
          style: TextStyle(
            fontSize: 14.sp,
            color: primaryColor,
            height: 1.2,
          ),
        ).tr(),
        content: Text(
          "usure",
          style: TextStyle(
            fontSize: 14.sp,
            color: dark,
            height: 1.4,
          ),
        ).tr(),
        actions: <Widget>[
          TextButton(
            child: Text(
              "no",
              style: TextStyle(
                fontSize: 14.sp,
                color: primaryColor,
                height: 1.2,
              ),
            ).tr(),
            onPressed: () {
              Get.back();
            },
          ),
          TextButton(
            child: Text("yes",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: primaryColor,
                  height: 1.2,
                )).tr(),
            onPressed: () async {
              Get.back();
              // OneSignal().removeExternalUserId();
              await FirebaseAuth.instance.signOut();
              await SessionManager().destroy();
              Get.offAll(() => const WelcomeScreen(),
                  transition: Transition.fadeIn,
                  duration: const Duration(milliseconds: 500));
            },
          )
        ],
      ),
    );
  }

  @override
  void onInit() {
    loading.toggle();
    update();
    getUserFromSession().then((value) {
      snUser = value;
      loading.toggle();
      update();
    });
    super.onInit();
  }

  mySyndic() async {
    getSyndicByResidence(snUser.residence!.first).then((value) {
      Get.to(() => const MySyndicScreen(), arguments: value);
    });
  }
}
