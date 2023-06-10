import 'dart:async';

import 'package:get/get.dart';
import 'package:syndease/screens/client/home_screen.dart';

import '../screens/complete_profile.dart';
import '../screens/syndic/syndic_home_screen.dart';

class VerifySuccessController extends GetxController {
  var current = 10;
  String? main;
  Timer? _timer;
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (current == 0) {
          switch (main.toString()) {
            case 'HomeScreen':
              Get.offAll(() => const HomeScreen(),
                  transition: Transition.fadeIn,
                  duration: const Duration(milliseconds: 500));
              break;
            case 'SyndicHomeScreen':
              Get.offAll(() => const SyndicHomeScreen(),
                  transition: Transition.fadeIn,
                  duration: const Duration(milliseconds: 500));
              break;
            case 'CompleteProfile':
              Get.offAll(() => const CompleteProfile(),
                  transition: Transition.fadeIn,
                  duration: const Duration(milliseconds: 500));
              break;
            default:
          }

          timer.cancel();
        } else {
          current--;
          update();
        }
      },
    );
  }

  @override
  Future<void> onInit() async {
    main = Get.arguments;

    startTimer();

    super.onInit();
  }

  @override
  void onClose() {
    _timer!.cancel();
    super.onClose();
  }

  submit() {
    switch (main) {
      case 'HomeScreen':
        Get.offAll(() => const HomeScreen(),
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 500));
        break;
      case 'SyndicHomeScreen':
        Get.offAll(() => const SyndicHomeScreen(),
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 500));
        break;
      case 'CompleteProfile':
        Get.offAll(() => const CompleteProfile(),
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 500));
        break;
      default:
    }
  }
}
