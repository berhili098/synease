import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart'; 
import 'package:google_fonts/google_fonts.dart';
import 'package:syndease/utils/app_vars.dart';
import 'package:syndease/utils/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async { 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await handlerPermission();
  await initOneSignal();
  Widget? main;
  await initWidget().then(
    (value) {
      main = value;
    },
  );
  runApp(EasyLocalization(
    supportedLocales: supportedLocales,
    path: 'assets/translations',
    fallbackLocale: const Locale('en'),
    startLocale: const Locale("en"),
    child: ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        return GetMaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          title: 'SyndEase',
          theme: ThemeData(
            useMaterial3: true,
            textTheme: GoogleFonts.dmSansTextTheme(),
            colorScheme: ThemeData().colorScheme.copyWith(
                  primary: primaryColor,
                ),
            primaryColor: primaryColor,
            scaffoldBackgroundColor: Colors.white,
            buttonTheme: ButtonThemeData(
              colorScheme: ThemeData().colorScheme.copyWith(
                    primary: primaryColor,
                  ),
                  buttonColor: primaryColor
            )
          ),
          home: main,
        );
      },
    ),
  ));
}
