import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  late final RxInt _currentFocusType = 1.obs;

  int get currentFocusType => _currentFocusType.value;

  void focusType(int value) {
    _currentFocusType.value = value;

    update();
  }
}
