import 'package:get/get.dart';
import 'package:syndease/models/report.dart';
import 'package:syndease/models/sn_user.dart';
import 'package:syndease/utils/services.dart';

class HomeController extends GetxController {
  SnUser snUser = SnUser();
  RxBool loading = false.obs;
  List<Report> reports = [];

  @override
  void onInit() async {
    loading.toggle();
    update();
    await getUserFromSession().then((value) async {
      snUser = value;
      await getPendingReports(snUser).then((value) async {
        reports = value; 
        loading.toggle();
        update();
      });
    });
    super.onInit();
  }
}
