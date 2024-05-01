// ignore_for_file: unnecessary_null_comparison, sized_box_for_whitespace

import 'dart:async';
import 'dart:convert';
import 'package:aldlal/core/service/show_diloag_alret.dart';
import 'package:aldlal/main.dart';
import 'package:aldlal/model/house_model.dart';
import 'package:aldlal/view/auth/auth.dart';
import 'package:aldlal/view/widget/color_constant.dart';
import 'package:aldlal/view/widget/custom_button.dart';
import 'package:aldlal/view/widget/custom_text.dart';
import 'package:aldlal/view/widget/storag_constant.dart';
import 'package:aldlal/view/widget/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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

  Map<int, List<Datum>> houseLists = {};
  Map<int, int> currentPageMap = {};
  void focusType(int value) {
    // Save the current scroll position for the current type
    if (houseLists[_currentFocusType.value] != null &&
        houseLists[_currentFocusType.value]!.isNotEmpty &&
        scrollController.hasClients) {
      currentPageMap[_currentFocusType.value] =
          scrollController.position.pixels.toInt();
    }

    // Set the new type
    _currentFocusType.value = value;
    isDataFinished = false; // Reset isDataFinished flag

    // Restore the scroll position for the new type if it exists
    if (currentPageMap[value] != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.jumpTo(currentPageMap[value]!.toDouble());
        }
      });
    }

    // Check if the data for the selected type is already loaded
    if (houseLists[value] != null && houseLists[value]!.isNotEmpty) {
      // Data is already loaded, update the UI
      update();
    } else {
      // Data is not loaded, fetch it from the API
      getHouses(value).then((_) {
        // Update the UI after the data is fetched
        update();
      });
    }
  }

  bool isLoading = false;

  RxBool get isTimedOut => _isTimedout;

  late final RxBool _isTimedout = false.obs;
  getHouses(int type, {bool loadMore = false}) async {
    if (isLoading) {
      return; // If data is already loading, do not load again
    }

    isLoading = true; // Set loading state to true
    try {
      int currentPage = loadMore ? currentPageMap[type]! + 1 : 1;

      var response = await http.get(
        Uri.parse('${Urls.houses}$type?page=$currentPage'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read(StoragConstant.token)}',
        },
      ).timeout(const Duration(seconds: 10));
      final houseModel = houseModelFromJson(response.body);
      if (houseModel.data.lastPage != null &&
          houseModel.data.currentPage != null) {
        if (houseModel.data.currentPage >= houseModel.data.lastPage) {
          // No more pages available
          isDataFinished = true;
          isAllDataLoaded = true;
        }
      }
      currentPageMap[type] = houseModel.data.currentPage;
      if (!loadMore) {
        houseLists[type] = houseModel.data.data;
      } else {
        houseLists[type]!.addAll(houseModel.data.data);
      }
      if (scrollPosition != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (scrollController.hasClients) {
            scrollController.jumpTo(scrollPosition!);
          }
        });
      }
      update();
    } on TimeoutException catch (_) {
      _isTimedout.value = true;

      Get.dialog(
        barrierDismissible: false,
        transitionDuration: const Duration(milliseconds: 500),
        Center(
          child: Container(
            height: 150,
            width: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: ColorConstant.backgroundColor),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                CustomText(
                  text: 'خطأ في الاتصال',
                  alignment: Alignment.center,
                  fontSize: 20,
                  color: ColorConstant.warning,
                  fontWeight: FontWeight.w400,
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomText(
                  text: 'الرجاء قم بالتحقق من شبكة الانترنت',
                  alignment: Alignment.center,
                  fontWeight: FontWeight.w400,
                  color: ColorConstant.secondTextColor,
                  fontSize: 18,
                ),
              ],
            ),
          ),
        ),
      );
      update();
      // Reset isTimedOut to false after showing the dialog
    } catch (e) {
      Get.snackbar(
        'خطـــأ',
        'خطــأ في تحميل المعومات',
        colorText: Colors.white,
        duration: const Duration(seconds: 20),
        snackPosition: SnackPosition.BOTTOM,
      );

      print(e);
    } finally {
      isLoading = false; // Set loading state to false
    }
  }

  addToFavorit(id) async {
    try {
      var response = await http.post(
        Uri.parse('${Urls.addToFavorit}$id'),
        body: jsonEncode({}),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read(StoragConstant.token)}',
        },
      );

      var responseBody = jsonDecode(response.body);

      print(responseBody);
      EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.fadingGrid;
      EasyLoading.show();

      if (responseBody['message'] == 'Unauthenticated.') {
        EasyLoading.dismiss();
        ShowDiloagAlretService().showDiloagAlret(
            text: 'تسجيل الدخول',
            onPressed: () {
              Get.back();
              Get.to(const Auth(),
                  transition: Transition.downToUp,
                  duration: const Duration(milliseconds: 500));
            },
            text2: 'الرجوع',
            onPressed2: () {
              Get.back();
            },
            title: 'يرجى القيام بتسجيل الدخول للاستفادة',
            height: 200);
      }
      if (response.statusCode == 404) {
        if (responseBody['message'] == 'No User!') {
          noUser(text: 'لــقد قمت بحذف حسابك');
          EasyLoading.dismiss();
        }
        if (responseBody['message'] == 'No item for this ID') {
          noUser(text: 'هذا المنزل لم يعد متوفراََ');
          EasyLoading.dismiss();
        }
      }
      if (response.statusCode == 200) {
        EasyLoading.dismiss();

        /// complete the coding form here
        Get.dialog(Container(
          height: 200,
          child: Center(
            child: CustomText(
                color: ColorConstant.secondTextColor,
                text: 'تمت اضافة المنزل الى المفضلة بنجاح',
                alignment: Alignment.center,
                fontSize: 20),
          ),
        ));
      }
    } catch (e) {
      print(e);
    }
  }

  noUser({required String text}) {
    Get.dialog(Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        color: ColorConstant.backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          CustomText(
            text: text,
            color: ColorConstant.warning,
          ),
          const SizedBox(
            height: 15,
          ),
          CustomButton(
            onPressed: () {
              Get.back();
            },
            text: 'الرجوع',
          ),
        ],
      ),
    ));
  }

  ScrollController setupScrollController() {
    final scrollController = ScrollController();

    // Attach a listener to the scrollController to detect when the user reaches the bottom
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getHouses(_currentFocusType.value, loadMore: true);
      }
    });

    return scrollController;
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
