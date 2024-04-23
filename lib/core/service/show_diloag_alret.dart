import 'package:aldlal/view/widget/color_constant.dart';
import 'package:aldlal/view/widget/custom_button.dart';
import 'package:aldlal/view/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowDiloagAlretService {
  showDiloagAlret({
    required String text,
    required Function() onPressed,
    required String text2,
    required Function() onPressed2,
    required String title,
    required double height,
  }) {
    Get.dialog(
      Center(
        child: Container(
          height: height,
          width: 250,
          decoration: const BoxDecoration(
              color: ColorConstant.backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          margin: EdgeInsets.symmetric(horizontal: 40),
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(
                height: 16,
              ),
              CustomText(
                text: title,
                color: ColorConstant.warning,
                fontSize: 18,
                alignment: Alignment.center,
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(
                height: 18,
              ),
              CustomButton(
                onPressed: onPressed,
                text: text,
              ),
              const SizedBox(
                height: 8,
              ),
              CustomButton(
                onPressed: onPressed2,
                text: text2,
                color: ColorConstant.warning,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
