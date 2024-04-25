import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchViewModel extends GetxController {
  TextEditingController search = TextEditingController();
  @override
  void onInit() {
    search;
    // TODO: implement onInit
    super.onInit();
  }

  getHistorey() async {
    try {
      // get historey here
    } catch (e) {
      print(e);
    }
  }

  deleteHistorey() {
    try {
      // delete historey
    } catch (e) {
      print(e);
    }
  }

  getSearchResult() {
    try {
      // get all houses here
    } catch (e) {
      print(e);
    }
  }
}
