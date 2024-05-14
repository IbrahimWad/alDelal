import 'package:aldlal/core/viewModel/add_house_viewmodel.dart';
import 'package:aldlal/view/widget/color_constant.dart';
import 'package:aldlal/view/widget/custom_text_field.dart';
import 'package:aldlal/view/widget/drop_down_button.dart';
import 'package:flutter/material.dart';
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
                child: Column(
                  children: [
                    Image.asset('assets/images/ad_delal.png'),
                    CustomTextField(
                      text: 'اسم المنطقة*',
                      controller: controller.areaName,
                      validator: (val) {
                        return controller.areaNameValid(val);
                      },
                      hint: 'حي العدالة',
                    ),
                    SizedBox(height: 14),
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
                    SizedBox(height: 14),
                    Row(
                      /// change to drop buttom after
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomDropButton(
                            text: 'نوع العقار',
                            dropdownvalue: '',
                            items: [],
                            hint: 'تجاري',
                            onChanged: (val) {},
                          ),
                        ),
                        Expanded(
                          child: CustomDropButton(
                            text: 'سند العقار',
                            dropdownvalue: '',
                            items: [],
                            hint: 'طابو',
                            onChanged: (val) {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
