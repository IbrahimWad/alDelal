import 'package:aldlal/view/widget/color_constant.dart';
import 'package:aldlal/view/widget/custom_text.dart';
import 'package:flutter/material.dart';

class CustomDropButton extends StatelessWidget {
  final List<DropdownMenuItem<dynamic>> items;
  final Function(dynamic) onChanged;
  final dynamic dropdownvalue;
  final String text;
  final String hint;
  const CustomDropButton(
      {super.key,
      required this.items,
      required this.onChanged,
      required this.dropdownvalue,
      required this.text,
      required this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: text,
            alignment: Alignment.centerRight,
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: ColorConstant.secondTextColor,
          ),
          SizedBox(height: 6),
          Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: ColorConstant.textColor),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: DropdownButton(
                items: items,

                onChanged: onChanged,
                underline: SizedBox(), // remove the underline
                value: dropdownvalue,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 36, // adjust as needed
                isExpanded: true,
                hint: CustomText(
                  text: hint,
                  color: ColorConstant.textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
                style: TextStyle(
                  color: ColorConstant.textColor,
                  fontSize: 20,
                ),
                //   dropdownColor: Colors.white, // adjust as needed
              ),
            ),
          ),
        ],
      ),
    );
  }
}
