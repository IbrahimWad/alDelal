import 'package:aldlal/core/viewModel/controle_viewmodel.dart';
import 'package:aldlal/view/widget/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControlView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControlViewModel>(
      init:
          ControlViewModel(), // Use GetBuilder with init to create the controller
      builder: (controller) => Scaffold(
        body: controller.currentScreen,
        bottomNavigationBar: bottomNavigationBar(context, controller),
      ),
    );
  }

  Container bottomNavigationBar(
      BuildContext context, ControlViewModel controller) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.00, -1.00),
          end: Alignment(0, 1),
          colors: [Color(0xFF38445D), Color(0xFF141F2C)],
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Color(0xffC2E8FF),
          unselectedItemColor: ColorConstant.textColor,
          currentIndex: controller
              .navigatorValue, // Use the current index from the controller
          onTap: (val) {
            controller.onTapMethod(val);
          },
          items: [
            _bottomNavigationBarItem(
                image: 'assets/images/icon_home.png',
                width: 24.16,
                height: 24.15),
            _bottomNavigationBarItem(
                image: 'assets/images/search.png', width: 24.27, height: 24.15),
            _bottomNavigationBarItem(
                image: 'assets/images/add.png', width: 26.73, height: 24.15),
            _bottomNavigationBarItem(
                image: 'assets/images/favorit.png',
                width: 26.58,
                height: 24.15),
            _bottomNavigationBarItem(
                image: 'assets/images/profile.png', width: 26.73, height: 26.73)
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem(
      {required String image, required double height, required double width}) {
    return BottomNavigationBarItem(
        icon: Container(
          child: Container(
            height: height,
            width: width,
            child: Image(
              fit: BoxFit.contain,
              image: AssetImage(image),
            ),
          ),
        ),
        label: '');
  }
}
