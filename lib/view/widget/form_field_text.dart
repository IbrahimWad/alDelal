// ignore_for_file: must_be_immutable

import 'package:aldlal/view/widget/color_constant.dart';
import 'package:flutter/material.dart';

class TextFormFiledCustom extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  TextFormFiledCustom({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Stack(
        children: [
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'البحث',
              hintStyle: TextStyle(
                color: ColorConstant.textColor.withOpacity(0.5),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(color: ColorConstant.textColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(color: ColorConstant.textColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(color: ColorConstant.textColor),
              ),
            ),
          ),
          Positioned(
            left: 15,
            top: 18,
            child: GestureDetector(
              onTap: () {
                // Handle icon tap
              },
              child: Image(
                image: const AssetImage('assets/images/search.png'),
                height: 20,
                color: ColorConstant.textColor.withOpacity(0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
