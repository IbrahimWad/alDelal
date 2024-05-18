import 'dart:io';

import 'package:aldlal/view/widget/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddHouseViewModel extends GetxController {
  TextEditingController areaName = TextEditingController();
  TextEditingController size = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController note = TextEditingController();

  final RxString selectedValueType = ''.obs;
  final RxString selectedValueDox = ''.obs;
  final RxString selectedPrice = ''.obs;

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

  var listPrice = ['الف', 'مليون', 'مليار'];

  changeValueType(String? val) {
    try {
      selectedValueType.value = val ?? '';

      update();
    } catch (e) {
      print(e);
    }
  }

  changeValuePrice(String? val) {
    try {
      selectedPrice.value = val ?? '';

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
    price;
    note;
    // TODO: implement onInit
    super.onInit();
  }

  areaNameValid(val) {
    if (val == null || val.isEmpty) {
      return 'يرجى ادخال اسم الحي';
    }
    return null;
  }

  List<File> selectedImages = []; // List of selected image
  final picker = ImagePicker(); // Instance of Image picker

  getImages() async {
    final pickedFile = await picker.pickMultiImage();
    List<XFile> xfilePick = pickedFile;

    if (xfilePick.isNotEmpty) {
      for (var i = 0; i < xfilePick.length; i++) {
        selectedImages.add(File(xfilePick[i].path));
      }
      Get.snackbar(
        'نجاح',
        'تم اضافة الصور بنجاح',
        colorText: ColorConstant.secondTextColor,
        dismissDirection: DismissDirection.down,
      );
    } else {
      Get.snackbar(
        'خطأ',
        'لم تقم باختيار اي صور',
        colorText: ColorConstant.warning,
        dismissDirection: DismissDirection.down,
      );
    }
  }
}
