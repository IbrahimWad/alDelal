import 'package:aldlal/core/viewModel/verification_viewmodel.dart';
import 'package:aldlal/view/widget/color_constant.dart';
import 'package:aldlal/view/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

class Verification extends StatelessWidget {
  final String phone;
  final String token;
  Verification({super.key, required this.phone, required this.token});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerificationViewModel>(
        init: VerificationViewModel(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: ColorConstant.backgroundColor,
            body: ListView(
              children: [
                const Image(
                  image: AssetImage('assets/images/delal.png'),
                ),
                CustomText(
                  alignment: Alignment.center,
                  text: 'تم ارسال رمز مكون  من اربع ارقام الى الرقم التالي',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(
                  height: Get.height * .01,
                ),
                CustomText(
                  text: phone,
                  alignment: Alignment.center,
                ),
                SizedBox(
                  height: Get.height * .03,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: OtpTextField(
                      textStyle: TextStyle(color: ColorConstant.textColor),
                      autoFocus: true,
                      borderWidth: 1,
                      alignment: Alignment.center,
                      contentPadding: EdgeInsets.symmetric(vertical: 18),
                      borderRadius: BorderRadius.circular(5),
                      fieldWidth: 60,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      numberOfFields: 4,
                      borderColor: ColorConstant.textColor,
                      //set to true to show as box or false to show as dash
                      showFieldAsBox: true,
                      //runs when a code is typed in
                      onCodeChanged: (String code) {
                        //  print(code);
                        //handle validation or checks here
                      },
                      //runs when every textfield is filled
                      onSubmit: (String verificationCode) {
                        // controller.submit(verificationCode);
                        controller.verification(
                            otp: verificationCode, token: token);
                      } // end onSubmit
                      ),
                ),
                SizedBox(
                  height: Get.height * .02,
                ),

                Obx(() => Center(
                      child: CustomText(
                        text: controller.time.value,
                        alignment: Alignment.center,
                        fontSize: 32,
                      ),
                    )),
                SizedBox(
                  height: Get.height * 0.2,
                ),

                // SizedBox(
                //   height: 10,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(text: 'لم يصلك الرمز بعد؟'),
                    GestureDetector(
                        onTap: () {
                          if (controller.time != "00:00") {
                            return;
                          } else {
                            controller.resndOTP(phone: phone);
                          }
                          //  print('Hello world');
                        },
                        child: CustomText(
                          text: 'اعادة ارسال الرمز',
                          color: Colors.white,
                        ))
                  ],
                )
              ],
            ),
          );
        });
  }
}
