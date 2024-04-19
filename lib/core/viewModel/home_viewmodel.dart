import 'package:aldlal/model/house_model.dart';
import 'package:aldlal/view/widget/urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeViewModel extends GetxController {
  late final RxInt _currentFocusType = 1.obs;

  int get currentFocusType => _currentFocusType.value;

  late final ScrollController scrollController = ScrollController();
  double? scrollPosition;
  bool isDataLoading = false;
  bool isDataFinished = false;
  bool isAllDataLoaded = false;

  void focusType(int value) {
    _currentFocusType.value = value;

    update();
  }

  Map<int, List<Datum>> houseLists = {};
  Map<int, int> currentPageMap = {};

  getHouses(int type, {bool loadMore = false, double? scrollPosition}) async {
    int currentPage = loadMore ? currentPageMap[type]! + 1 : 1;

    try {
      var response = await http.get(
        Uri.parse('${Urls.houses}$type?page=$currentPage'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      final houseModel = houseModelFromJson(response.body);

      if (houseModel.status == false) {
        Get.snackbar(
          'خطـــأ',
          'الخطأ: ${houseModel.message}',
          colorText: Colors.white,
          duration: Duration(seconds: 20),
          snackPosition: SnackPosition.BOTTOM,
        );
      }

      if (!loadMore) {
        houseLists[type] = houseModel.data.data;
      } else {
        houseLists[type]!.addAll(houseModel.data.data);
      }

      currentPageMap[type] = houseModel.data.currentPage;

      if (scrollPosition != null) {
        scrollController.jumpTo(scrollPosition);
      }

      // Check if all data is loaded
      if (houseModel.data.data.isEmpty) {
        isDataFinished = true;
        isAllDataLoaded =
            true; // Set isAllDataLoaded to true when all data is loaded
      }

      update();
    } catch (e) {
      Get.snackbar(
        'خطـــأ',
        'خطــأ في تحميل المعومات',
        colorText: Colors.white,
        duration: Duration(seconds: 20),
        snackPosition: SnackPosition.BOTTOM,
      );

      print(e);
    }
  }

  void setScrollPosition(double position) {
    scrollPosition = position;
    update();
  }

  @override
  void onInit() {
    getHouses(1); // Fetch houses for type 1 initially

    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
