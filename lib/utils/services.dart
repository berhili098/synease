import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syndease/models/category.dart';
import 'package:syndease/models/group_report.dart';
import 'package:syndease/models/residence.dart';
import 'package:syndease/models/sn_user.dart';
import 'package:syndease/screens/syndic/syndic_home_screen.dart';
import 'package:syndease/screens/welcome_screen.dart';
import 'package:syndease/screens/client/home_screen.dart';
import '../models/report.dart';
import '../screens/complete_profile.dart';

Future<Widget> initWidget() async {
  // generateSyndic();
  getResidencesBySyndic("46W6NkQbM1PcVSYPd7iYlPn0wJv2");
  String fcm = await SessionManager().get('fcm') ?? "";
  String progress = await SessionManager().get('progress') ?? "";
  Widget? main;

  SnUser snUser = await getUserFromSession();
  snUser.fcm = fcm;

  if (snUser.uid == null) {
    main = const WelcomeScreen();
  } else if (snUser.type == 0) {
    await resaveUser(snUser.uid);
    switch (progress) {
      case 'homeScreen':
        main = const HomeScreen();
        break;
      case 'completeProfile':
        main = const CompleteProfile();
        break;

      default:
        main = const WelcomeScreen();
    }
  } else {
    main = const SyndicHomeScreen();
  }

  return main;
}

resaveUser(uid) async {
  await getUserFromDb(uid).then((val) async {
    await saveToSession(val);
  });
}

getSyndicByResidence(Residence res) async {
  SnUser syndic = SnUser();
  await FirebaseFirestore.instance
      .collection('sn_users')
      .where('residence', arrayContains: res.toJson())
      .where('type', isEqualTo: 1)
      .get()
      .then((value) {
    if (value.docs.isNotEmpty) {
      syndic = SnUser.fromJson(value.docs.first.data());
    }
  });
  return syndic;
}

handlerPermission() async {
  var permission = await Permission.sensors.status;
  if (permission.isDenied) {
    await Permission.phone.request();
    await Permission.location.request();
    await Permission.notification.request();
  }
  if (permission.isRestricted) {
    await Permission.phone.request();
    await Permission.notification.request();
    await Permission.location.request();
  }
  if (permission.isPermanentlyDenied) {
    await Permission.phone.request();
    await Permission.location.request();
  }
  if (permission.isLimited) {
    await Permission.phone.request();
    await Permission.location.request();
    await Permission.notification.request();
  }
}

String generateRandomString(int len) {
  var r = Random();
  const chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
}

// generateSyndic() async {
//   await FirebaseFirestore.instance
//       .collection('sn_residences')
//       .get()
//       .then((value) async {
//     List<Residence> list = value.docs.map((e) {
//       return Residence.fromJson(e.data());
//     }).toList();
//     list = list.reversed.take(3).toList();

//     if (value.size != 0) {
//       SnUser snUser = SnUser();
//       snUser.uid = "EUN3yAnmf0bAEO1EUEniNYHxQT73";
//       snUser.phoneNumber = "+212666666665";
//       snUser.fcm =  await SessionManager().get('fcm');
//       snUser.type = 1;
//       snUser.fullname = "ahmed syncdic";
//       snUser.residence = list;
//       saveUserToDb(snUser);
//     }
//   });
// }

Future<String> checkPhoneNumber(uid) async {
  String message = "not-found";
  await FirebaseFirestore.instance
      .collection('sn_users')
      .doc(uid)
      .get()
      .then((value) {
    if (value.exists && value['fullname'] != '') message = "found-in-users";
  });
  // await FirebaseFirestore.instance
  //     .collection('sn_users')
  //     .where('uid', isEqualTo: "wR3PlhkC1WQ7lJlBFYkqAGCM6Sl2")
  //     .snapshots()
  //     .first
  //     .then((value) {
  //   if (value.size != 0) message = "found-in-users";
  // });
  return message;
}

saveUserToDb(SnUser user) async {
  await FirebaseFirestore.instance
      .collection('sn_users')
      .doc(user.uid)
      .set(user.toJson());
}

getUserFromDb(uid) async {
  SnUser snUser = SnUser();
  await FirebaseFirestore.instance
      .collection('sn_users')
      .doc(uid)
      .get()
      .then((value) {
    if (value.exists) snUser = SnUser.fromJson(value.data()!);
  });
  return snUser;
}

saveToSession(SnUser user) async {
  await SessionManager().set("user", user);
}

Future<SnUser> getUserFromSession() async {
  return SnUser.fromJson(await SessionManager().get("user") ?? {});
}

Future<List<Categories>> getAllCategories() async {
  List<Categories> categories = [];
  await FirebaseFirestore.instance.collection('categories').get().then((value) {
    for (var element in value.docs) {
      categories.add(Categories.fromJson(element.data()));
    }
  });
  return categories;
}

String capitalize(name) {
  return "${name[0].toUpperCase()}${name.substring(1).toLowerCase()}";
}

changeDateToText(String date) {
  String finaldate = date;

  DateTime finaldatee = DateTime.parse(finaldate);
  String test = DateFormat('EEEE, MMM d, yyyy ').format(finaldatee);
  return test;
}

Future<Report> getReportByid(id) async {
  Report report = Report();
  await FirebaseFirestore.instance
      .collection('reports')
      .doc(id)
      .get()
      .then((value) {
    report = Report.fromJson(value.data()!);
  });
  return report;
}

getPendingReports(SnUser snUser) async {
  List<Report> reports = [];
  await FirebaseFirestore.instance
      .collection('reports')
      .where('status', isEqualTo: 'pending')
      .where('client_uid.uid', isEqualTo: snUser.uid)
      .orderBy('creation_date', descending: true)
      .get()
      .then((value) {
    for (var element in value.docs) {
      reports.add(Report.fromJson(element.data()));
    }
  });
  return reports;
}

getSyndicPendingReports(SnUser snUser) async {
  List<Report> reports = [];
  await FirebaseFirestore.instance
      .collection('reports')
      .where('status', isEqualTo: 'pending')
      .where('syndic_uid.uid', isEqualTo: snUser.uid)
      .orderBy('creation_date', descending: true)
      .get()
      .then((value) {
    for (var element in value.docs) {
      reports.add(Report.fromJson(element.data()));
    }
  });

  return reports;
}

getReportsByResidence(SnUser snUser) async {
  List<Report> reports = [];
  await FirebaseFirestore.instance
      .collection('reports')
      .where('client_uid.residence',
          arrayContains: snUser.residence![0].toJson())
      .orderBy('creation_date', descending: true)
      .get()
      .then((value) {
    for (var element in value.docs) {
      reports.add(Report.fromJson(element.data()));
    }
  });
  return reports;
}

getAllReports(SnUser snUser) async {
  List<Report> reports = [];
  await FirebaseFirestore.instance
      .collection('reports')
      .where('client_uid.uid', isEqualTo: snUser.uid)
      .orderBy('creation_date', descending: true)
      .get()
      .then((value) {
    for (var element in value.docs) {
      reports.add(Report.fromJson(element.data()));
    }
  });
  return reports;
}

getSyndicReports(SnUser snUser) async {
  List<Report> reports = [];
  await FirebaseFirestore.instance
      .collection('reports')
      .where('syndic_uid.uid', isEqualTo: snUser.uid)
      .orderBy('creation_date', descending: true)
      .get()
      .then((value) {
    for (var element in value.docs) {
      reports.add(Report.fromJson(element.data()));
    }
  });
  return reports;
}

getGroupReportsSyndic(SnUser snUser) async {
  List<Reportgroup> reportgroup = [];
  await FirebaseFirestore.instance
      .collection('group_reports')
      .orderBy('creation_date', descending: true)
      .where('syndic_uid', isEqualTo: snUser.uid)
      .get()
      .then((value) {
    for (var element in value.docs) {
      reportgroup.add(Reportgroup.fromJson(element.data()));
    }
  });
  return reportgroup;
}

Future<void> initOneSignal() async {
  await OneSignal.shared.setAppId('e285b13b-d2da-4cec-ac90-4454e7a811e1');
  String osUserID = 'userID';
  OneSignal.shared.setSubscriptionObserver((changes) async {
    osUserID = changes.to.userId ?? '';
    String playerid = osUserID;
    await SessionManager().set('fcm', playerid);
  });
  await OneSignal.shared.promptUserForPushNotificationPermission(
    fallbackToSettings: true,
  );

  OneSignal.shared.setNotificationWillShowInForegroundHandler(
      (OSNotificationReceivedEvent event) {
    // Will be called whenever a notification is received in foreground
    // Display Notification, pass null param for not displaying the notification
    event.complete(event.notification);
  });
  OneSignal.shared
      .setNotificationOpenedHandler((OSNotificationOpenedResult result) {});
  OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {});
  await OneSignal.shared.getDeviceState();
}

sendNotification(String? fcm, heading, content) async {
  await OneSignal.shared.postNotification(OSCreateNotification(
    playerIds: [fcm!],
    content: content,
    heading: heading,
  ));
}

getAllSyndics() async {
  List<SnUser> syndics = [];
  await FirebaseFirestore.instance
      .collection('sn_users')
      .where('type', isEqualTo: 1)
      .get()
      .then((value) {
    for (var element in value.docs) {
      syndics.add(SnUser.fromJson(element.data()));
    }
  });
  return syndics;
}

getResidencesBySyndic(String uid) async {
  List<Residence> residences = [];
  await FirebaseFirestore.instance
      .collection('sn_users')
      .doc(uid)
      .get()
      .then((value) {
    for (var element in value.data()!['residence']) {
      residences.add(Residence.fromJson(element));
    }
  });
  return residences;
}
