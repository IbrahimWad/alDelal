import 'package:aldlal/core/viewModel/home_viewmodel.dart';
import 'package:aldlal/view/widget/color_constant.dart';
import 'package:aldlal/view/widget/custom_text.dart';
import 'package:aldlal/view/widget/grid_view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(builder: (controller) {
      return Container(
        child: Scaffold(
          backgroundColor: ColorConstant.backgroundColor,
          body: Column(
            children: [
              Container(
                // ad here
                child: Image(image: AssetImage('assets/images/ad_delal.png')),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TypeMethod(
                      name: 'بيع',
                      color: controller.currentFocusType == 1
                          ? ColorConstant.secondTextColor
                          : ColorConstant.textColor,
                      onTap: () {
                        controller.focusType(1);
                      },
                    ),
                    TypeMethod(
                      name: 'استـأجار',
                      color: controller.currentFocusType == 2
                          ? ColorConstant.secondTextColor
                          : ColorConstant.textColor,
                      onTap: () {
                        controller.focusType(2);
                      },
                    ),
                    TypeMethod(
                      name: 'استثمار',
                      color: controller.currentFocusType == 3
                          ? ColorConstant.secondTextColor
                          : ColorConstant.textColor,
                      onTap: () {
                        controller.focusType(3);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 9,
              ),
              Container(
                width: double.infinity,
                height: 1,
                decoration: const BoxDecoration(
                  color: ColorConstant.textColor,
                ),
                // List here
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  // color: ColorConstant.textColor,
                  child: Container(
                    /// here where should my list show up
                    ///
                    //color: Colors.white,
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 1,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20),
                        itemCount: 2,
                        itemBuilder: (BuildContext ctx, index) {
                          return GridViewContainer(
                              type: 'hhh',
                              image: 'assets/images/ad_delal.png',
                              price: 500);
                        }),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  Container TypeMethod(
      {required String name,
      required Color color,
      required Function()? onTap}) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 2, color: color),
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: SizedBox(
            width: 75,
            height: 30,
            child: CustomText(
              color: color,
              text: name,
              fontSize: 24,
              alignment: Alignment.center,
              fontWeight: FontWeight.w400,
            )),
      ),
    );
  }
}