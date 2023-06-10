import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'appVars.dart';

class LoadingWidget extends StatelessWidget {
  bool hasHeight;
  bool isFullPage;
  LoadingWidget({
    super.key,
    this.hasHeight = false,
    this.isFullPage = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: hasHeight
          ? isFullPage
              ? 812.h
              : 610.h
          : 40.h,
      child: Center(
        child: LoadingAnimationWidget.inkDrop(
          color: primaryColor,
          size: 40.h,
        ),
      ),
    );
  }
}
