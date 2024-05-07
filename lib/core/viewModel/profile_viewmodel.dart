import 'package:aldlal/core/service/show_diloag_alret.dart';
import 'package:aldlal/main.dart';
import 'package:aldlal/view/auth/auth.dart';
import 'package:aldlal/view/home/control_view.dart';
import 'package:aldlal/view/widget/color_constant.dart';
import 'package:aldlal/view/widget/custom_button.dart';
import 'package:aldlal/view/widget/custom_text.dart';
import 'package:aldlal/view/widget/storag_constant.dart';
import 'package:aldlal/view/widget/urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProfileViewModel extends GetxController {
  Future<void> logOut() async {
    if (box.read(StoragConstant.token) == null) {
      Get.snackbar(
        'خطـــأ',
        'لم تقم بتسجيل الدخول من الاساس',
        colorText: Colors.white,
        duration: Duration(seconds: 10),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    ShowDiloagAlretService().showDiloagAlret(
        text: 'تسجيل الخروج',
        onPressed: () {
          box.erase();
          Get.offAll(ControlView());
        },
        text2: 'الرجوع',
        onPressed2: () {
          Get.back();
        },
        title: 'هل انت متأكد من تسجيل الخروج',
        height: 210);
  }

  Future<void> deleteAccount() async {
    if (box.read(StoragConstant.token) == null) {
      Get.snackbar('خطـــأ', 'انت غير مسجل',
          colorText: Colors.white,
          duration: Duration(seconds: 20),
          snackPosition: SnackPosition.BOTTOM);
    }

    try {
      /// change this
      var response = await http.delete(Uri.parse(Urls.deleteUser), headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read(StoragConstant.token)}',
      });

      if (response.statusCode == 200) {
        box.erase();
        Get.dialog(
          _buildDialog('تم حذف حسابك', 'الرجوع'),
        );
      } else {
        Get.dialog(
          _buildDialog('لا يمكن حذف هذا الحساب', 'الرجوع'),
        );
      }
    } catch (e) {
      print(e);
      Get.snackbar('خطأ', 'حدث خطأ أثناء محاولة حذف الحساب');
    }
  }

  void moveToMyPosts() {
    if (box.read(StoragConstant.token) == null) {
      Get.snackbar('خطـــأ', 'لم تقم بتسجيل الدخول من الاساس',
          colorText: Colors.white,
          duration: Duration(seconds: 20),
          snackPosition: SnackPosition.BOTTOM);
    }

    Get.to(Auth());
  }

  Widget _buildDialog(String message, String buttonText) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ColorConstant.backgroundColor,
        ),
        height: 180,
        child: Column(
          children: [
            SizedBox(height: 50),
            CustomText(
              text: message,
              alignment: Alignment.center,
              color: ColorConstant.warning,
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: 20),
            CustomButton(
              onPressed: () {
                Get.back();
              },
              text: buttonText,
              color: ColorConstant.secondTextColor,
              buttonColor: ColorConstant.textColor,
            )
          ],
        ),
      ),
    );
  }

  delete() async {
    ShowDiloagAlretService().showDiloagAlret(
      height: 200,
      onPressed2: () {
        Get.back();
      },
      onPressed: () async {
        if (box.read(StoragConstant.token) == null) {
          showSnackbar('خطـــأ', 'انت غير مسجل');
          return;
        }

        var response = await deleteAccountRequest();

        if (response.statusCode == 200) {
          box.erase();
          showDeleteSuccessDialog();
        } else {
          showDeleteFailedDialog();
        }
      },
      text2: 'الرجوع',
      text: 'حذف الحساب',
      title: 'هل انت متاكد من حذف\n الحساب',
    );
  }

  Future<http.Response> deleteAccountRequest() async {
    return http.delete(Uri.parse(''), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${box.read(StoragConstant.token)}',
    });
  }

  void showSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      colorText: Colors.white,
      duration: Duration(seconds: 20),
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void showDeleteSuccessDialog() {
    Get.dialog(
      _buildDialog('تم حذف حسابك', 'الرجوع'),
    );
  }

  void showDeleteFailedDialog() {
    Get.dialog(
      _buildDialog('لا يمكن حذف هذا الحساب', 'الرجوع'),
    );
  }
}
