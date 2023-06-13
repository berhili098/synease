import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:get/get.dart';
import 'package:syndease/models/residence.dart';
import 'package:syndease/models/sn_user.dart';
import 'package:syndease/screens/client/home_screen.dart';
import 'package:syndease/utils/services.dart';

import '../models/position.dart';
import '../utils/app_vars.dart';

class CompleteProfileController extends GetxController {
  var backgroundColor = Colors.transparent;
  List<SnUser> allSyndics = [];
  bool loading = false;
  SnUser snUser = SnUser();
  List<Residence> residences = [];

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController syndicSelected = TextEditingController();
  TextEditingController addressSelected = TextEditingController();
  TextEditingController stage = TextEditingController();
  TextEditingController apt = TextEditingController();

  verify() async {
    if (firstnameController.text.trim().length < 3) {
      Get.snackbar("Error", "Enter a valid first name",
          colorText: Colors.white, backgroundColor: dangerColor);
      return false;
    } else if (lastnameController.text.trim().length < 3) {
      Get.snackbar("Error", "Enter a valid last name",
          colorText: Colors.white, backgroundColor: dangerColor);
      return false;
    } else if (syndicSelected.text.trim().isEmpty) {
      Get.snackbar("Error", "Select a your syndic",
          colorText: Colors.white, backgroundColor: dangerColor);
      return false;
    } else if (addressSelected.text.trim().isEmpty) {
      Get.snackbar("Error", "Select a your Residence",
          colorText: Colors.white, backgroundColor: dangerColor);
      return false;
    } else if (stage.text.trim().isEmpty) {
      Get.snackbar("Error", "Enter your stage",
          colorText: Colors.white, backgroundColor: dangerColor);
      return false;
    } else if (apt.text.trim().isEmpty) {
      Get.snackbar("Error", "Enter your apartment",
          colorText: Colors.white, backgroundColor: dangerColor);
      return false;
    } else {
      return true;
    }
  }

  changeResidence(value) {
    addressSelected.text = value;
    update();
  }

  submit() {
    verify().then((value) async {
      if (value) {
        loading = true;
        update();
        Residence res = residences
            .firstWhere((element) => element.name == addressSelected.text);
        snUser.fullname =
            "${firstnameController.text.trim().toLowerCase()} ${lastnameController.text.trim().toLowerCase()}";
        snUser.residence = [res];

        Position postition = Position(
          stage: stage.text.trim(),
          apt: apt.text.trim(),
        );
        snUser.position = postition;
        await saveUserToDb(snUser).then((value) async {
          await SessionManager().set('progress', 'homeScreen');
          saveToSession(snUser);
          Get.snackbar("Success", "User saved",
              colorText: Colors.green, backgroundColor: successColor);
          Get.offAll(() => const HomeScreen(),
              transition: Transition.fadeIn,
              duration: const Duration(milliseconds: 500));
          loading = false;
          update();
        });
      }
    });
  }

  @override
  void onInit() {
    loading = true;
    update();
    getUserFromSession().then((value) {
      snUser = value;
      getAllSyndics().then((value) {
        allSyndics = value;
        print(allSyndics.length);
        loading = false;
        update();
      });
    });
    // TODO: implement onInit
    super.onInit();
  }

  changeSyndic(String value) async {
    loading = true;
    update();
    SnUser syndic =
        allSyndics.firstWhere((element) => element.fullname == value);
    await getResidencesBySyndic(syndic.uid!).then((value) {
      residences = value;
      addressSelected.clear();
      loading = false;
      update();
    });
  }
}
