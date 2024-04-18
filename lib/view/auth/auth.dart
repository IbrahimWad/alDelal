import 'package:aldlal/core/viewModel/auth_viewmodel.dart';
import 'package:aldlal/view/widget/color_constant.dart';
import 'package:aldlal/view/widget/custom_text.dart';
import 'package:aldlal/view/widget/custome_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Auth extends GetWidget<AuthViewModel> {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AuthViewModel());
    return Container(
      child: Scaffold(
        backgroundColor: ColorConstant.backgroundColor,
        body: Form(
            key: controller.key,
            child: ListView(
              children: [
                Image(image: AssetImage('assets/images/delal.png')),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                CustomeTextFiled(
                  validator: (value) {
                    return controller.validatePhone(value);
                  },
                  controller: controller.phone,
                ),
                SizedBox(
                  height: Get.height * 0.07,
                ),
                InkWell(
                  onTap: () async {
                    controller.login(
                        phone: '964${controller.phone.value.text}');

                    print(await controller.login(
                        phone: '964${controller.phone.value.text}'));
                  },
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: CustomText(
                    text: 'التالي',
                    fontSize: 20,
                    alignment: Alignment.center,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
