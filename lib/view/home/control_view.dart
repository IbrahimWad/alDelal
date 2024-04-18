// ignore_for_file: prefer_final_fields, must_be_immutable, unused_field

import 'package:aldlal/core/viewModel/controle_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class ControlView extends GetView<ControlViewModel> {
  ControlView({super.key});

  late PersistentTabController _controller =
      PersistentTabController(initialIndex: controller.navigatorValue);

  @override
  Widget build(BuildContext context) {
    Get.put(ControlViewModel());
    return Scaffold(
        body: controller.currentScreen,
        bottomNavigationBar: Container(
          //   height: 44 + 12 + 2.5,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.00, -1.00),
              end: Alignment(0, 1),
              colors: [Color(0xFF38445D), Color(0xFF141F2C)],
            ),
          ),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: (val) {
              controller.changeSelectedValue(val);
            },
            backgroundColor: Colors.transparent,
            // unselectedItemColor: Colors.black,
            // selectedItemColor: Colors.red,
            items: [
              _bottomNavigationBarIteam(image: 'assets/images/icon_home.png'),
              _bottomNavigationBarIteam(image: 'assets/images/icon_home.png'),
              _bottomNavigationBarIteam(image: 'assets/images/icon_home.png')
            ],
          ),
        ));
  }

  _bottomNavigationBarIteam({required String image}) {
    return BottomNavigationBarItem(
      // label: '',
      label: '',

      icon: Center(
        //  padding: EdgeInsets.only(top: 10),
        // height: 24.15,
        child: Container(
          height: 24.15,
          child: Image(
            fit: BoxFit.cover,
            image: AssetImage(image),
          ),
        ),
      ),
    );
  }
}
