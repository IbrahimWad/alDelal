import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddHouseViewModel extends GetxController {
  TextEditingController areaName = TextEditingController();
  TextEditingController size = TextEditingController();

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
