import 'dart:convert';

import 'package:aldlal/main.dart';
import 'package:aldlal/view/widget/storag_constant.dart';
import 'package:aldlal/view/widget/urls.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SearchViewModel extends GetxController {
  getSearchHistory() async {
    try {
      var response = await http.get(Uri.parse(Urls.hisrotey), headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${box.read(StoragConstant.token)}',
      });

      var responseBody = jsonDecode(response.body);

      if (response.statusCode == 500) {
        print(responseBody['message']);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    getSearchHistory();
    // TODO: implement onInit
    super.onInit();
  }
}
