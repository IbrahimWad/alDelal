// ignore_for_file: must_be_immutable

import 'package:aldlal/view/widget/color_constant.dart';
import 'package:aldlal/view/widget/custom_text.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final FormFieldValidator<String?> validator;
  TextEditingController controller = TextEditingController();
  final String hint;
  final int maxLines;
  CustomTextField(
      {super.key,
      required this.text,
      required this.controller,
      required this.validator,
      this.maxLines = 1,
      required this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Container(
            child: CustomText(
                text: text,
                alignment: Alignment.centerRight,
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: ColorConstant.secondTextColor),
          ),
          SizedBox(height: 6),
          Container(
            child: TextFormField(
              maxLines: maxLines,
              style: TextStyle(color: ColorConstant.textColor, fontSize: 20),
              cursorColor: ColorConstant.textColor,
              controller: controller,
              // inputFormatters: [
              //   _TenDigitTextInputFormatter(),
              //   // PhoneNumberFormatter()
              // ],
              decoration: InputDecoration(
                // hintTextDirection: TextDirection.ltr,
                hintText: hint,
                hintStyle:
                    TextStyle(color: ColorConstant.textColor, fontSize: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(color: ColorConstant.textColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(color: ColorConstant.textColor),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              ),
              // keyboardType: TextInputType.phone,
              validator: validator,
              // textDirection: TextDirection.ltr,
            ),
          ),
        ],
      ),
    );
  }
}
