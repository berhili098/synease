import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:syndease/utils/app_vars.dart';
import 'package:syndease/utils/loading_widget.dart';
import 'package:syndease/utils/widgets.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import '../../controllers/client/new_report_controller.dart';
import '../../utils/services.dart';

class NewReportScreen extends StatelessWidget {
  const NewReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backColor,
        body: GetBuilder<NewReportController>(
            init: NewReportController(),
            builder: (controller) {
              return controller.loading.value
                  ? Center(child: LoadingWidget())
                  : SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            50.verticalSpace,
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                width: 29.w,
                                height: 29.h,
                                decoration: const BoxDecoration(
                                  border: Border.fromBorderSide(
                                      BorderSide(color: darkColor, width: 2.0)),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Icon(
                                    IconlyLight.arrow_left_2,
                                    size: 19.sp,
                                  ),
                                ),
                              ),
                            ),
                            43.verticalSpace,
                            GradientText(
                                gradient: gradientColor,
                                text: "newreport",
                                style: blueTitleTextStyle),
                            26.verticalSpace,
                            Center(
                              child: controller.file == null
                                  ? Container(
                                      width: 194.w,
                                      height: 194.w,
                                      decoration: const BoxDecoration(
                                        color: Colors.blueGrey,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20.0),
                                        ),
                                      ),
                                      child: Icon(
                                        IconlyLight.camera,
                                        color: Colors.white,
                                        size: 50.sp,
                                      ))
                                  : SizedBox(
                                      width: 194.w,
                                      height: 194.w,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.file(
                                          controller.image!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                            ),
                            17.verticalSpace,
                            Center(
                              child: Container(
                                height: 45.h,
                                constraints: BoxConstraints(
                                  minWidth: 140.w,
                                  maxWidth: 156.w,
                                ),
                                child: SecondaryButton(
                                    text: 'addpicture',
                                    widget: Icon(
                                      IconlyLight.camera,
                                      color: Colors.white,
                                      size: 20.sp,
                                    ),
                                    onpress: () {
                                      controller.selectImage();
                                    }),
                              ),
                            ),
                            40.verticalSpace,
                            Text(
                              changeDateToText(DateTime.now().toString()),
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 12.sp),
                            ),
                            24.verticalSpace,
                            PrimaryTextField(
                              controller: controller.titleController,
                              hintText: 'title',
                              centered: false,
                            ),
                            10.verticalSpace,
                            PrimaryTextField(
                              controller: controller.descriptionController,
                              hintText: 'Description',
                              isDescription: true,
                              centered: false,
                            ),
                            12.verticalSpace,
                            CustomDropdown.search(
                              hintStyle: TextStyle(
                                  color:
                                      const Color(0xff14213D).withOpacity(0.5),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500),
                              onChanged: (value) {},
                              hintText: tr('selectcategory'),
                              items: controller.categoryList,
                              controller: controller.categoryController,
                            ),
                            50.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 167.w,
                                  height: 45.h,
                                  child: SecondaryButton(
                                      text: 'cancel',
                                      onpress: () {
                                        Get.back();
                                      }),
                                ),
                                SizedBox(
                                  width: 167.w,
                                  height: 45.h,
                                  child: SecondaryButton(
                                      text: 'submit',
                                      onpress: () {
                                        controller.beforeSubmit();
                                      }),
                                ),
                              ],
                            ),
                            20.verticalSpace,
                          ],
                        ),
                      ),
                    );
            }));
  }
}
