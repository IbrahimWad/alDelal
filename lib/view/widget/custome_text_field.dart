import 'package:aldlal/view/widget/color_constant.dart';
import 'package:aldlal/view/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CustomeTextFiled extends StatelessWidget {
  var validator;
  TextEditingController controller = TextEditingController();

  CustomeTextFiled(
      {super.key, required this.validator, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 45, vertical: 15),
      child: Column(
        children: [
          Container(
            child: CustomText(
              text: 'رقم الهاتف',
              fontSize: 15,
            ),
          ),
          Container(
            child: TextFormField(
              style: TextStyle(color: ColorConstant.textColor, fontSize: 20),
              cursorColor: ColorConstant.textColor,
              controller: controller,
              inputFormatters: [
                _TenDigitTextInputFormatter(),
                // PhoneNumberFormatter()
              ],
              decoration: InputDecoration(
                suffixIcon: Container(
                  margin: const EdgeInsets.only(right: 16, left: 12),
                  padding: const EdgeInsets.only(left: 3),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        text: '964+',
                        color: ColorConstant.textColor.withOpacity(0.49),
                        alignment: Alignment.centerRight,
                        fontSize: 20,
                      ),
                    ],
                  ),
                ),
                hintTextDirection: TextDirection.ltr,
                hintText: '781 123 4567',
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
                contentPadding: EdgeInsets.symmetric(vertical: 6),
              ),
              keyboardType: TextInputType.phone,
              validator: validator,
              textDirection: TextDirection.ltr,
            ),
          ),
        ],
      ),
    );
  }
}

class _TenDigitTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove any non-digit characters
    String digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Remove leading zeros
    digitsOnly = digitsOnly.replaceFirst(RegExp(r'^0+'), '');

    // Limit to 10 digits
    if (digitsOnly.length > 10) {
      digitsOnly = digitsOnly.substring(0, 10);
    }

    return TextEditingValue(
      text: digitsOnly,
      selection: TextSelection.collapsed(offset: digitsOnly.length),
    );
  }
}

// class PhoneNumberFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     // Remove any non-digit characters
//     String digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');

//     // Add the desired formatting
//     String formattedValue = '';
//     for (int i = 0; i < digitsOnly.length; i++) {
//       if (i == 3 || i == 6) {
//         formattedValue += ' ';
//       }
//       formattedValue += digitsOnly[i];
//     }

//     return TextEditingValue(
//       text: formattedValue,
//       selection: TextSelection.collapsed(offset: formattedValue.length),
//     );
//   }
// }
