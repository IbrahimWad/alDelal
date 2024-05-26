// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'dart:io';
import 'package:aldlal/core/service/show_diloag_alret.dart';
import 'package:aldlal/main.dart';
import 'package:aldlal/view/auth/auth.dart';
import 'package:aldlal/view/widget/color_constant.dart';
import 'package:aldlal/view/widget/storag_constant.dart';
import 'package:aldlal/view/widget/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;

class AddHouseViewModel extends GetxController {
  TextEditingController areaName = TextEditingController();
  TextEditingController size = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController note = TextEditingController();
  TextEditingController streat = TextEditingController();

  @override
  void onInit() {
    areaName;
    size;
    price;
    note;
    streat;
    super.onInit();
  }

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

  void changeValueType(String? val) {
    selectedValueType.value = val ?? '';
  }

  void changeValuePrice(String? val) {
    selectedPrice.value = val ?? '';
  }

  void changeValueDox(String? val) {
    selectedValueDox.value = val ?? '';
  }

  String? areaNameValid(val) {
    if (val == null || val.isEmpty) {
      return 'يرجى ادخال اسم الحي';
    }
    return null;
  }

  var selectedImages = <File>[].obs; // Observable list of selected images
  final picker = ImagePicker(); // Instance of Image picker
  var currentIndex = 0.obs; // Observable current index

  Future<void> getImages() async {
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      selectedImages.clear();
      for (var pickedFile in pickedFiles) {
        selectedImages.add(File(pickedFile.path));
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

  void showImages() {
    Get.dialog(
      Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              height: Get.height * 0.7,
              child: Obx(() => CarouselSlider(
                    options: CarouselOptions(
                      height: Get.height * 0.7,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      onPageChanged: (index, reason) {
                        currentIndex.value = index;
                      },
                    ),
                    items: selectedImages.map((image) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            margin: const EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: FileImage(image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  )),
            ),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.black.withOpacity(0.5)),
              child: IconButton(
                onPressed: () {
                  deleteCurrentImage();
                },
                icon: const Icon(Icons.close, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  void deleteCurrentImage() {
    if (selectedImages.isNotEmpty &&
        currentIndex.value < selectedImages.length) {
      selectedImages.removeAt(currentIndex.value);
      // Update currentIndex if necessary
      if (currentIndex.value >= selectedImages.length &&
          currentIndex.value > 0) {
        currentIndex.value--;
      }
      if (selectedImages.isEmpty) {
        Get.back(); // Close the dialog if no images are left
      }
    }
  }

  addPost() async {
    // complete from here
    try {
      EasyLoading.show();
      var response = await http.post(Uri.parse(Urls.postHouse),
          body: jsonEncode({
            'images': selectedImages,
            'neighborhood': areaName.value.text,
            'area': size.value.text,
            'estateType': selectedValueType.value,
            'estateStreet': streat.value.text,
            'estateDeed': selectedValueType.value,
            'price': price.value.text,
            'displayType': 1, // change this
            'note': note.value.text,
          }),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${box.read(StoragConstant.token)}',
          });

      var responseBody = jsonDecode(response.body);

      EasyLoading.dismiss();

      if (response.statusCode != 200) {
        if (responseBody['message'] == 'Please upload an image') {
          Get.snackbar('خطــأ', 'الرجــاء قم بارفاق بعض الصور',
              colorText: ColorConstant.warning,
              snackPosition: SnackPosition.BOTTOM);
        }

        if (responseBody['message'] == 'Unauthenticated.') {
          // services here
          ShowDiloagAlretService().showDiloagAlret(
              text: 'تسجيل الدخول',
              onPressed: () {
                Get.to(Auth());
              },
              text2: 'الرجوع',
              onPressed2: () {
                Get.back();
              },
              title: 'انت غير مسجل في التطبيق',
              height: 180);
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
