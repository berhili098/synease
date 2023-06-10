import 'package:get/get.dart';
import 'package:syndease/models/report.dart';
import 'package:syndease/models/sn_user.dart';
import 'package:syndease/utils/services.dart';

import '../../models/group_report.dart';

class SyndicHomeController extends GetxController {
  SnUser snUser = SnUser();
  RxBool loading = false.obs;

  List<Report> reports = [];
  List<Reportgroup> reportgroup = [];

  @override
  Future<void> onInit() async {
    loading.toggle();
    update();
    await getUserFromSession().then((value) async {
      snUser = value;
      await getSyndicPendingReports(snUser).then((value) async {
        reports = value;
        await getGroupReportsSyndic(snUser).then((value) async {
          reportgroup = value;
          loading.toggle();
          update();
        });
      });
    });
    super.onInit();
  }
}
