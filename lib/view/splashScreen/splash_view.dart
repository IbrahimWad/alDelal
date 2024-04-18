// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:aldlal/core/viewModel/splash_screen_viewmodel.dart';
import 'package:aldlal/view/widget/color_constant.dart';
import 'package:aldlal/view/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends GetWidget<SplashScreenViewModel> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SplashScreenViewModel());
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      // backgroundColor: ColorConstant.backgroundColor,
      body: Column(
        children: [
          // ignore: sized_box_for_whitespace
          Container(
            decoration: BoxDecoration(
              // border: Border.all(width: 5),
              //  color: Colors.transparent,
              image: const DecorationImage(
                image: AssetImage(
                  'assets/images/Home.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
            height: Get.height * .59,
          ),
          SizedBox(
            height: Get.height * 0.05,
          ),

          GetBuilder<SplashScreenViewModel>(
            init: SplashScreenViewModel(),
            builder: (controller) {
              return SlideTransition(
                position: controller.offsetAnimation,
                child: CustomText(
                  text: 'اهلا وسهلا',
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  alignment: Alignment.center,
                ),
              );
            },
          ),
          GetBuilder<SplashScreenViewModel>(
            init: SplashScreenViewModel(),
            builder: (controller) {
              return SlideTransition(
                position: controller.offsetAnimation,
                child: CustomText(
                  text: 'في مدينة النجف الاشرف',
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  alignment: Alignment.center,
                ),
              );
            },
          ),

          SizedBox(
            height: Get.height * 0.19,
          ),
          GetBuilder<SplashScreenViewModel>(
            init: SplashScreenViewModel(),
            builder: (controller) {
              return SlideTransition(
                position: controller.offsetAnimation,
                child: CustomText(
                  text: 'AHM',
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  alignment: Alignment.center,
                ),
              );
            },
          ),
          // SizedBox(
          //   height: Get.height * 0.005,
          // ),
        ],
      ),
    );
  }
}
