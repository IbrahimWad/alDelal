import 'package:aldlal/core/viewModel/add_house_viewmodel.dart';
import 'package:aldlal/view/widget/color_constant.dart';
import 'package:aldlal/view/widget/custom_button.dart';
import 'package:aldlal/view/widget/custom_text.dart';
import 'package:aldlal/view/widget/custom_text_field.dart';
import 'package:aldlal/view/widget/drop_down_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AddHouseView extends StatelessWidget {
  const AddHouseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstant.backgroundColor,
        body: GetBuilder<AddHouseViewModel>(
            init: AddHouseViewModel(),
            builder: (controller) {
              return Container(
                  child: SingleChildScrollView(
                      child: Column(children: [
                Image.asset('assets/images/delal.png'),
                CustomTextField(
                  text: 'اسم المنطقة*',
                  controller: controller.areaName,
                  validator: (val) {
                    return controller.areaNameValid(val);
                  },
                  hint: 'حي العدالة',
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomTextField(
                        text: 'المساحة م²',
                        controller: controller.size,
                        validator: (val) {
                          return '';
                        },
                        hint: '150',
                      ),
                    ),
                    Expanded(
                      child: CustomTextField(
                        text: 'شارع العقار',
                        controller: controller.size,
                        validator: (val) {
                          return '';
                        },
                        hint: 'شارع 40',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomDropButton(
                          text: 'نوع العقار',
                          dropdownvalue: controller.selectedValueType.value,
                          items: controller.listType.map((String item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    // color: ColorConstant.backgroundColor,
                                  ),
                                  child: CustomText(
                                    text: item,
                                    alignment: Alignment.center,
                                    color: ColorConstant.secondTextColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  )),
                            );
                          }).toList(),
                          hint: 'نوع العقار',
                          onChanged: (val) {
                            controller.changeValueType(val);
                          },
                        ),
                      ),
                      Expanded(
                          child: CustomDropButton(
                              text: 'سند العقار',
                              dropdownvalue: controller.selectedValueDox.value,
                              items: controller.listDox.map((String item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        // color: ColorConstant.backgroundColor,
                                      ),
                                      child: CustomText(
                                        text: item,
                                        alignment: Alignment.center,
                                        color: ColorConstant.secondTextColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      )),
                                );
                              }).toList(),
                              hint: 'سند العقار',
                              onChanged: (val) {
                                controller.changeValueDox(val);
                              }))
                    ]),
                SizedBox(
                  height: 10,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomTextField(
                          text: 'السعر',
                          controller: controller.price,
                          validator: (val) {
                            return '';
                          },
                          hint: '00.00',
                        ),
                      ),
                      Expanded(
                          child: CustomDropButton(
                              text: 'العملة',
                              dropdownvalue: controller.selectedPrice.value,
                              items: controller.listPrice.map((String item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        // color: ColorConstant.backgroundColor,
                                      ),
                                      child: CustomText(
                                        text: item,
                                        alignment: Alignment.center,
                                        color: ColorConstant.secondTextColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      )),
                                );
                              }).toList(),
                              hint: 'العملة',
                              onChanged: (val) {
                                controller.changeValueDox(val);
                              }))
                    ]),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                    text: 'اضافة ملاحظات',
                    controller: controller.note,
                    validator: (val) {
                      return '';
                    },
                    maxLines: 5,
                    hint:
                        'مثال عدد الغرف وعدد الطوابق واتجاه الشرفة او العنوان التفصيلي للمنطقة'),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: CustomButton(
                            onPressed: () {},
                            text: 'اضافة صور',
                            borderColor: ColorConstant.textColor,
                            buttonColor: ColorConstant.backgroundColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: ColorConstant.textColor),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: CustomButton(
                            onPressed: () {},
                            text: 'اظهار الصور',
                            borderColor: ColorConstant.textColor,
                            buttonColor: ColorConstant.backgroundColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: ColorConstant.textColor),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(children: [
                  Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: CustomButton(
                          onPressed: () {},
                          buttonColor:
                              ColorConstant.wtTextColor.withOpacity(0.17),
                          color: ColorConstant.secondTextColor,
                          text: 'نشر',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      )),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: CustomButton(
                      onPressed: () {},
                      buttonColor: ColorConstant.backgroundColor,
                      color: ColorConstant.secondTextColor,
                      text: 'نشر',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  )),
                ]),
                SizedBox(
                  height: 5,
                ),
              ])));
            }));
  }
}
