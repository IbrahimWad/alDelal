import 'dart:convert';

import 'package:aldlal/view/widget/urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeViewModel extends GetxController {
  late final RxInt _currentFocusType = 1.obs;

  int get currentFocusType => _currentFocusType.value;

  void focusType(int value) {
    _currentFocusType.value = value;

    update();
  }

  getHouses() async {
    try {
      var response = await http
          .get(Uri.parse('${Urls.houses}$currentFocusType'), headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      });

      var responseBody = jsonDecode(response.body);

      print(responseBody);

      if (responseBody['status'] == false) {
        Get.snackbar('خطـــأ', 'الخطأ: ${responseBody['error']}',
            colorText: Colors.white,
            duration: Duration(seconds: 20),
            snackPosition: SnackPosition.BOTTOM);
      }

      if (currentFocusType == 1) {
        /// الحصول على المعلومات هنا
      }
      if (currentFocusType == 2) {
        /// الحصول على المعلومات هنا
      }
      if (currentFocusType == 3) {
        /// الحصول على المعلومات هنا
      }
    } catch (e) {
      Get.snackbar('خطـــأ', 'خطــأ في تحميل المعومات',
          colorText: Colors.white,
          duration: Duration(seconds: 20),
          snackPosition: SnackPosition.BOTTOM);

      print(e);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getHouses();
    super.onInit();
  }
}
