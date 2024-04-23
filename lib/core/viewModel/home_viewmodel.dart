import 'package:aldlal/main.dart';
import 'package:aldlal/model/house_model.dart';
import 'package:aldlal/view/widget/storag_constant.dart';
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

  getHouses(int type, {bool loadMore = false}) async {
    if (isLoading) {
      return; // If data is already loading, do not load again
    }

    isLoading = true; // Set loading state to true

    int currentPage = loadMore ? currentPageMap[type]! + 1 : 1;

    try {
      var response = await http.get(
        Uri.parse('${Urls.houses}$type?page=$currentPage'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${box.read(StoragConstant.token)}',
        },
      );

      final houseModel = houseModelFromJson(response.body);

      currentPageMap[type] = houseModel.data.currentPage;

      print(houseModel.userId);
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

      if (houseModel.data.data.isEmpty) {
        isDataFinished = true;
        isAllDataLoaded = true;
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
    } finally {
      isLoading = false; // Set loading state to false
    }
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
