import 'package:aldlal/core/viewModel/profile_viewmodel.dart';
import 'package:aldlal/view/auth/auth.dart';
import 'package:aldlal/view/widget/color_constant.dart';
import 'package:aldlal/view/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      body: GetBuilder<ProfileViewModel>(
          init: ProfileViewModel(),
          builder: (controller) {
            return ListView(
              children: [
                const SizedBox(
                  height: 70,
                ),
                GestureDetector(
                    onTap: () {
                      Get.to(Auth(),
                          transition: Transition.downToUp,
                          duration: Duration(milliseconds: 500));
                    },
                    child: ListButtons(text: 'تسجيل الدخول')),
                const SizedBox(
                  height: 27,
                ),
                GestureDetector(
                    onTap: () {}, child: ListButtons(text: 'لغة التطبيق')),
                const SizedBox(
                  height: 27,
                ),
                GestureDetector(
                    onTap: () {}, child: ListButtons(text: 'منشورات الحساب')),
                const SizedBox(
                  height: 27,
                ),
                GestureDetector(
                    onTap: () {
                      controller.delete();
                    },
                    child: ListButtons(text: 'حذف الحساب')),
                const SizedBox(
                  height: 27,
                ),
                GestureDetector(
                    onTap: () {
                      controller.logOut();
                    },
                    child: ListButtons(
                        text: 'تسجيل خروج', color: ColorConstant.warning)),
              ],
            );
          }),
    );
  }

  Padding ListButtons(
      {required String text, Color color = ColorConstant.textColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 26),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: ColorConstant.textColor)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomText(
                  text: text,
                  color: color,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                )),
            Image(
              image: AssetImage('assets/images/arrow.png'),
              height: 17,
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}
