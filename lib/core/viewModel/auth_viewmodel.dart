import 'package:aldlal/core/service/auth_services.dart';
import 'package:aldlal/view/auth/verification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AuthViewModel extends GetxController {
  TextEditingController phone = TextEditingController();
  final key = GlobalKey<FormState>();

  @override
  void onInit() {
    phone;
    super.onInit();
  }

  login({required String phone}) async {
    try {
      if (!key.currentState!.validate() || phone.length != 13) {
        return 'You data is null';
      }
      EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.fadingGrid;
      EasyLoading.show();
      var response = await AuthServices().auth(phone: phone);

      print(response);

      if (response['status'] == false) {
        EasyLoading.dismiss();

        if (response['message'] == 'You are blocked. Please try again later.') {
          var remainingTime = response['remaining_time'];

          var roundedTime = remainingTime.round();
          Get.snackbar('حظر مؤقت', 'تم حظرك لمدة $roundedTime دقيقة',
              colorText: Colors.white,
              duration: Duration(seconds: 20),
              snackPosition: SnackPosition.BOTTOM);
        }

        Get.snackbar('خطـــأ', 'حدث خطأ اثناء تسجيل الدخول',
            colorText: Colors.white,
            duration: Duration(seconds: 20),
            snackPosition: SnackPosition.BOTTOM);
      }
      if (response['status'] == true) {
        EasyLoading.dismiss();
        Get.closeAllSnackbars();

        Get.offAll(Verification(
          phone: phone,
          token: response['token'],
        ));
      }

      EasyLoading.dismiss();

      print(response);
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar('خطأ غير متوقع', 'الرجاء المحاولة لاحقا',
          colorText: Colors.white,
          duration: Duration(seconds: 20),
          snackPosition: SnackPosition.BOTTOM);
      print(e);
    }
  }

  String? validatePhone(String value) {
    if (value.length != 10) {
      return 'الرجاء ادخال رقم هاتف صحيح';
    }
    return null;
  }
}
