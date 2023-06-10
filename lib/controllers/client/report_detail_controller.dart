import 'package:get/get.dart';
import 'package:syndease/models/report.dart';

class ReportDetailController extends GetxController {
  RxBool loading = false.obs;
  Report report = Report();
  @override
  void onInit() {
    loading.toggle();
    update();
    report = Get.arguments.first as Report;
    loading.toggle();
    update();
    super.onInit();
  }
}
