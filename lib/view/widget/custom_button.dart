import 'package:aldlal/view/widget/color_constant.dart';
import 'package:aldlal/view/widget/custom_text.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final Color buttonColor;
  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.color = ColorConstant.backgroundColor,
      this.fontSize = 18,
      this.fontWeight = FontWeight.normal,
      this.buttonColor = ColorConstant.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: buttonColor,
      ),
      child: TextButton(
          style: ButtonStyle(
            alignment: Alignment.center,
          ),
          onPressed: onPressed,
          child: CustomText(
            text: text,
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight,
            alignment: Alignment.center,
          )),
    );
  }
}
