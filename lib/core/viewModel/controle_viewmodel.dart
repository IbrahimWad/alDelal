import 'package:aldlal/view/home/home_view.dart';
import 'package:aldlal/view/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControlViewModel extends GetxController {
  int _navigatorValue = 0;

  get navigatorValue => _navigatorValue;

  Widget currentScreen = HomeView();

  void changeSelectedValue(int selectedValue) {
    _navigatorValue = selectedValue;
    switch (selectedValue) {
      case 0:
        currentScreen = HomeView();

        break;
      case 1:
        // currentScreen = // Set your search view widget here
        break;
      case 2:
        // currentScreen = // Set your add house view widget here
        break;
      case 3:
        // currentScreen = // Set your favorite house view widget here
        break;
      case 4:
        currentScreen = ProfileView();
        break;
    }
    update();
  }
}
