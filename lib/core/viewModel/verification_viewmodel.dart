// ignore_for_file: unused_field

import 'dart:async';
import 'dart:convert';

import 'package:aldlal/core/service/auth_services.dart';
import 'package:aldlal/main.dart';
import 'package:aldlal/view/home/home_view.dart';
import 'package:aldlal/view/widget/storag_constant.dart';
import 'package:aldlal/view/widget/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class VerificationViewModel extends GetxController {
  Timer? _timer;
  int remainingSeconsd = 1;
  final time = '00:00'.obs;

  void startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainingSeconsd = seconds;
    _timer = Timer.periodic(duration, (Timer timer) {
      if (remainingSeconsd == -1) {
        timer.cancel();
      } else {
        int minutes = remainingSeconsd ~/ 60;
        int seconds = (remainingSeconsd % 60);
        time.value =
            "${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}";
        remainingSeconsd--;
      }
    });
    update();
  }

  resndOTP({required String phone}) async {
    try {
      EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.fadingGrid;
      EasyLoading.show();
      var response = await AuthServices().auth(phone: phone);
      startTimer(60);

      if (response['status'] == false) {
        EasyLoading.dismiss();

        if (response['message'] == 'You are blocked. Please try again later.') {
          var remainingTime = response['remaining_time'];

          var roundedTime = remainingTime.round();
          Get.snackbar(
            'حظر مؤقت',
            'تم حظرك لمدة $roundedTime دقيقة',
            colorText: Colors.white,
          );
        }

        Get.snackbar(
          'خطـــأ',
          'حدث خطأ اثناء تسجيل الدخول',
          colorText: Colors.white,
        );
      }
      if (response['status'] == true) {
        EasyLoading.dismiss();

        Get.snackbar('تم الارسال', 'تم ارسال الرمز بنجاح');
      }
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar(
        'خطأ غير متوقع',
        'الرجاء المحاولة لاحقا',
        colorText: Colors.white,
      );
    }
  }

  verification({required String otp, required String token}) async {
    try {
      // make post
      var response = await http.post(Uri.parse(Urls.verfyOtp),
          body: jsonEncode({'otp': otp}),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          });

      var responseBody = jsonDecode(response.body);

      print(responseBody);

      if (response.statusCode == 404 || response.statusCode == 201) {
        Get.snackbar('خطـــأ', 'حدث خطأ اثناء تفعيل الحساب',
            colorText: Colors.white,
            duration: Duration(seconds: 20),
            snackPosition: SnackPosition.BOTTOM);
      }
      if (response.statusCode == 200) {
        if (responseBody['status'] == false) {
          Get.snackbar('خطـــأ', 'رمز التفعيل خطـأ',
              colorText: Colors.white,
              duration: Duration(seconds: 20),
              snackPosition: SnackPosition.BOTTOM);
        }
        if (responseBody['status'] == true) {
          box.write(StoragConstant.token, token);
          Get.offAll(const HomeView());
        }
      }
    } catch (e) {
      Get.snackbar('خطــأ', 'حدث خطــأ غير متوقع');
    }
  }

  @override
  void onInit() {
    startTimer(60);
    super.onInit();
  }
}
