import 'package:aldlal/core/service/show_diloag_alret.dart';
import 'package:aldlal/main.dart';
import 'package:aldlal/view/auth/auth.dart';
import 'package:aldlal/view/home/control_view.dart';
import 'package:aldlal/view/widget/color_constant.dart';
import 'package:aldlal/view/widget/custom_button.dart';
import 'package:aldlal/view/widget/custom_text.dart';
import 'package:aldlal/view/widget/storag_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProfileViewModel extends GetxController {
  logOut() {
    ShowDiloagAlretService().showDiloagAlret(
      text: 'تسجيل الخروج',
      onPressed: () {
        if (box.read(StoragConstant.token) == null) {
          Get.back();
          Get.snackbar(
            'خطـــأ',
            'لم تقم بتسجيل الدخول من الاساس',
            colorText: Colors.white,
            duration: Duration(seconds: 10),
            snackPosition: SnackPosition.BOTTOM,
          );
        } else {
          box.erase();
          Get.offAll(ControlView());
        }

        update();
      },
      text2: 'رجوع',
      onPressed2: () {
        Get.back();
      },
      title: 'هل انت متاكد من الخروج',
      height: 180,
    );
  }

  delete() async {
    ShowDiloagAlretService().showDiloagAlret(
        height: 200,
        onPressed2: () {
          Get.back();
        },
        onPressed: () async {
          if (box.read(StoragConstant.token)) {
            Get.snackbar('خطـــأ', 'انت غير مسجل',
                colorText: Colors.white,
                duration: Duration(seconds: 20),
                snackPosition: SnackPosition.BOTTOM);
          }

          // make request here
          var response = await http.delete(Uri.parse(''), headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${box.read(StoragConstant.token)}',
          });

          if (response.statusCode == 200) {
            box.erase();
            Get.back();
            Get.dialog(Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: ColorConstant.backgroundColor,
                ),
                height: 180,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    CustomText(
                        text: 'تم حذف حسابك',
                        alignment: Alignment.center,
                        color: ColorConstant.warning,
                        fontSize: 24,
                        fontWeight: FontWeight.w400),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      onPressed: () {
                        Get.back();
                      },
                      text: 'الرجوع',
                      color: ColorConstant.secondTextColor,
                      buttonColor: ColorConstant.textColor,
                    )
                  ],
                ),
              ),
            ));
          } else {
            Get.back();
            Get.dialog(Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: ColorConstant.backgroundColor,
                ),
                height: 180,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    CustomText(
                        text: 'لا يمكن حذف هذا الحساب',
                        alignment: Alignment.center,
                        color: ColorConstant.warning,
                        fontSize: 24,
                        fontWeight: FontWeight.w400),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      onPressed: () {
                        Get.back();
                      },
                      text: 'الرجوع',
                      color: ColorConstant.secondTextColor,
                      buttonColor: ColorConstant.textColor,
                    )
                  ],
                ),
              ),
            ));
          }
        },
        text2: 'الرجوع',
        text: 'حذف الحساب',
        title: 'هل انت متاكد من حذف\n الحساب');
  }

  moveToMyPosts() {
    try {
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
      }
    } catch (e) {
      print(e);
    }
  }
}
