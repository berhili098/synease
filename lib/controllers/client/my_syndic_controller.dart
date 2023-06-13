import 'package:get/get.dart';
import 'package:syndease/models/sn_user.dart';
import 'package:url_launcher/url_launcher.dart';

class MySyndicController extends GetxController {
  RxBool loading = false.obs;
  SnUser syndic = SnUser();

  @override
  void onInit() {
    syndic = Get.arguments;
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> call() async {
    final uril = Uri(scheme: 'tel', path: syndic.phoneNumber);
    if (await canLaunchUrl(uril)) {
      await launchUrl(uril);
    } else {
      throw 'Could not launch $uril';
    }
  }
}
