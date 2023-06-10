import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syndease/utils/widgets.dart';

const Color primaryColor = Color(0xff1E7FC3);
const Color secondaryColor = Color(0xff61d0ff);
const Color borderGreyColor = Color(0xFFBEBEBE);
const Color darkColor = Color(0xFF1d1d1d);
const dangerColor = Color(0xffEF233C);
const successColor = Color(0xff3ECB98);
const Color dark = Color(0xFF3D3D3D);
const backgroundColor = Color(0xffF1F4F5);
const orangeColor = Color(0xffFF9900);

final supportedLocales = [
  const Locale('en'),
  const Locale('fr'),
];

final titleTextStyle = TextStyle(
    fontSize: 22.sp, fontWeight: FontWeight.bold, color: Colors.white);
final blueTitleTextStyle = TextStyle(
    fontSize: 22.sp, fontWeight: FontWeight.bold, color: primaryColor);

const gradientColor = LinearGradient(colors: [primaryColor, secondaryColor]);

final textStyle = TextStyle(
  fontSize: 16.sp,
  fontWeight: FontWeight.bold,
);
const backColor = Color(0xffF1F4F5);

final labelTextStyle = TextStyle(
  fontSize: 14.sp,
  fontWeight: FontWeight.bold,
);

final whiteText = TextStyle(
  fontSize: 16.sp,
  fontWeight: FontWeight.bold,
  color: backgroundColor,
);


