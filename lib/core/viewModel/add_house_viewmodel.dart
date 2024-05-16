import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddHouseViewModel extends GetxController {
  TextEditingController areaName = TextEditingController();
  TextEditingController size = TextEditingController();

  final RxString selectedValueType = ''.obs;
  final RxString selectedValueDox = ''.obs;

  var listType = [
    'تجاري',
    'سكني',
    'ركن',
    'مقابل ساحة',
    'قطعة ارض',
    'T',
    'اخرى'
  ];

  var listDox = [
    'طابو',
    'زراعي',
    'شرعي',
  ];

  changeValueType(String? val) {
    try {
      selectedValueType.value = val ?? '';

      update();
    } catch (e) {
      print(e);
    }
  }

  changeValueDox(String? val) {
    try {
      selectedValueDox.value = val ?? '';

      update();
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    areaName;
    size;
    // TODO: implement onInit
    super.onInit();
  }

  areaNameValid(val) {
    if (val == null || val.isEmpty) {
      return 'يرجى ادخال اسم الحي';
    }
    return null;
  }
}
