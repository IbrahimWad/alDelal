import 'package:aldlal/core/service/show_diloag_alret.dart';
import 'package:aldlal/main.dart';
import 'package:aldlal/view/auth/auth.dart';
import 'package:aldlal/view/home/home_view.dart';
import 'package:aldlal/view/profile/profile.dart';
import 'package:aldlal/view/search/search_view.dart';
import 'package:aldlal/view/widget/color_constant.dart';
import 'package:aldlal/view/widget/custom_button.dart';
import 'package:aldlal/view/widget/storag_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControlViewModel extends GetxController {
  int _navigatorValue = 0;

  get navigatorValue => _navigatorValue;

  Widget currentScreen = HomeView();

  void changeSelectedValue(int selectedValue) {
    _navigatorValue = selectedValue;
    switch (selectedValue) {
      case 0:
        currentScreen = HomeView();

        break;
      case 1:
        Get.to(SearchView());
        // currentScreen = // Set your search view widget here
        break;
      case 2:
        // BottomSheetMethod();
        // currentScreen = // Set your add house view widget here
        break;
      case 3:

        // currentScreen = // Set your favorite house view widget here
        break;
      case 4:
        currentScreen = ProfileView();
        break;
    }
    update();
  }

  BottomSheetMethod() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 28),
        margin: EdgeInsets.symmetric(horizontal: 5),
        height: Get.height * 0.45,
        width: Get.width,
        decoration: BoxDecoration(
          color: ColorConstant.backgroundColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            const SizedBox(height: 11),
            Container(
                width: 23,
                height: 3,
                decoration: BoxDecoration(
                  color: ColorConstant.secondTextColor,
                  borderRadius: BorderRadius.circular(18),
                )),
            const SizedBox(height: 41),
            CustomButton(
              onPressed: () {},
              text: 'أضافة منشور مميز',
              fontSize: 20,
              fontWeight: FontWeight.w400,
              buttonColor: ColorConstant.backgroundColor,
              borderColor: ColorConstant.secondTextColor,
            ),
            const SizedBox(height: 16),
            CustomButton(
              onPressed: () {},
              text: 'اضافة عرض بيع',
              fontSize: 20,
              fontWeight: FontWeight.w400,
              buttonColor: ColorConstant.backgroundColor,
              borderColor: ColorConstant.secondTextColor,
            ),
            const SizedBox(height: 16),
            CustomButton(
              onPressed: () {},
              text: 'اضافة عرض ايجار',
              fontSize: 20,
              fontWeight: FontWeight.w400,
              buttonColor: ColorConstant.backgroundColor,
              borderColor: ColorConstant.secondTextColor,
            ),
            const SizedBox(height: 16),
            CustomButton(
              onPressed: () {},
              text: 'اضافة عرض استثمار',
              fontSize: 20,
              fontWeight: FontWeight.w400,
              buttonColor: ColorConstant.backgroundColor,
              borderColor: ColorConstant.secondTextColor,
            )
          ],
        ),
      ),
    ).then((value) {
      onClose();
    });
  }

  onTapMethod(val) {
    if (val == 2) {
      BottomSheetMethod();
    } else {
      if (val == 3) {
        print(val);
        if (box.read(StoragConstant.token) == null) {
          ShowDiloagAlretService().showDiloagAlret(
              text: 'تسجيل الدخول',
              onPressed: () {
                Get.to(Auth());
              },
              text2: 'الرجوع',
              onPressed2: () {
                Get.back();
              },
              title: 'يرجى تسجيل الدخول اولا',
              height: 180);
        } else {
          changeSelectedValue(val); // Move this inside the else block
        }
      } else if (val == 1) {
        Get.to(SearchView());
      } else {
        changeSelectedValue(val);
      }
    }
  }
}
