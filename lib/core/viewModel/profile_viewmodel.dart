import 'package:aldlal/core/service/show_diloag_alret.dart';
import 'package:aldlal/main.dart';
import 'package:aldlal/view/home/control_view.dart';
import 'package:aldlal/view/widget/storag_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  delete() {
    ShowDiloagAlretService().showDiloagAlret(
        height: 200,
        onPressed2: () {},
        onPressed: () {},
        text2: 'الرجوع',
        text: 'حذف الحساب',
        title: 'هل انت متاكد من حذف\n الحساب');
  }
}
