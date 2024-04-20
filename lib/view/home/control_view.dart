import 'package:aldlal/core/viewModel/controle_viewmodel.dart';
import 'package:aldlal/view/widget/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControlView extends GetView<ControlViewModel> {
  ControlView({Key? key});

  @override
  Widget build(BuildContext context) {
    Get.put(ControlViewModel());
    return GetBuilder<ControlViewModel>(
      builder: (controller) => Scaffold(
        body: controller.currentScreen,
        bottomNavigationBar: bottomNavigationBar(context),
      ),
    );
  }

  Container bottomNavigationBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.00, -1.00),
          end: Alignment(0, 1),
          colors: [Color(0xFF38445D), Color(0xFF141F2C)],
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor:
              Colors.transparent, // Set the canvas color to transparent
          splashColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Color(0xffC2E8FF),
          unselectedItemColor: ColorConstant.textColor,
          onTap: (val) {
            controller.changeSelectedValue(val);
          },
          items: [
            _bottomNavigationBarIteam(
                image: 'assets/images/icon_home.png',
                width: 24.16,
                height: 24.15),
            _bottomNavigationBarIteam(
                image: 'assets/images/search.png', width: 24.27, height: 24.15),
            _bottomNavigationBarIteam(
                image: 'assets/images/add.png', width: 26.73, height: 24.15),
            _bottomNavigationBarIteam(
                image: 'assets/images/favorit.png',
                width: 26.58,
                height: 24.15),
            _bottomNavigationBarIteam(
                image: 'assets/images/profile.png', width: 26.73, height: 26.73)
          ],
        ),
      ),
    );
  }

  _bottomNavigationBarIteam(
      {required String image, required double height, required double width}) {
    return BottomNavigationBarItem(
        icon: Container(
          //  padding: EdgeInsets.only(top: 10),
          // height: 24.15,
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
