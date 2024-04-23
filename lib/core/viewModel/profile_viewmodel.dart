import 'package:aldlal/view/widget/color_constant.dart';
import 'package:aldlal/view/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileViewModel extends GetxController {
  logOut() {
    Get.dialog(
      Center(
        child: Container(
          height: 200,
          decoration: BoxDecoration(
              color: ColorConstant.backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          margin: EdgeInsets.symmetric(horizontal: 40),
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: ListView(
            shrinkWrap: true,
            children: [
              CustomButton(
                onPressed: () {},
                text: 'تسجيل الخروج',
              ),
              // إضافة زر آخر هنا إذا لزم الأمر
            ],
          ),
        ),
      ),
    );
  }
}
