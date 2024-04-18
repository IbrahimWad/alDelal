import 'package:aldlal/view/home/home_view.dart';
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
        {
          currentScreen = HomeView();
          break;
        }
      case 1:
        {
          print('Go to search view');
          break;
        }
      case 2:
        {
          print('Add house view');
          break;
        }
      case 3:
        {
          print('favorit house view');
          break;
        }
      case 4:
        {
          print('profile view');
          break;
        }
    }
    update();
  }
}
