import 'package:aldlal/core/viewModel/home_viewmodel.dart';
import 'package:aldlal/model/house_model.dart';
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
                      name: 'شراء',
                      color: controller.currentFocusType == 1
                          ? ColorConstant.secondTextColor
                          : ColorConstant.textColor,
                      onTap: () {
                        controller.focusType(1);
                        if (controller.scrollController.hasClients) {
                          controller.setScrollPosition(
                              controller.scrollController.offset);
                        }
                      },
                    ),
                    TypeMethod(
                      name: 'استـأجار',
                      color: controller.currentFocusType == 2
                          ? ColorConstant.secondTextColor
                          : ColorConstant.textColor,
                      onTap: () {
                        controller.focusType(2);
                        if (controller.scrollController.hasClients) {
                          controller.setScrollPosition(
                              controller.scrollController.offset);
                        }
                      },
                    ),
                    TypeMethod(
                      name: 'استثمار',
                      color: controller.currentFocusType == 3
                          ? ColorConstant.secondTextColor
                          : ColorConstant.textColor,
                      onTap: () {
                        controller.focusType(3);
                        if (controller.scrollController.hasClients) {
                          controller.setScrollPosition(
                              controller.scrollController.offset);
                        }
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
                  child: Container(
                    child: GetBuilder<HomeViewModel>(builder: (controller) {
                      if (controller.houseLists[controller.currentFocusType] ==
                          null) {
                        if (controller.isTimedOut == true) {
                          return Center(
                            child: CustomText(
                              text: 'لا يوجد اتصال بالشبكة',
                              alignment: Alignment.center,
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                            ),
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (controller
                          .houseLists[controller.currentFocusType]!.isEmpty) {
                        return Center(
                          child: CustomText(
                            text: 'لا توجد معلومات متاحة',
                            alignment: Alignment.center,
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      }

                      return NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (!controller.isDataLoading &&
                              !controller.isDataFinished &&
                              !controller.isAllDataLoaded &&
                              scrollInfo.metrics.pixels ==
                                  scrollInfo.metrics.maxScrollExtent) {
                            // Load more data when the user reaches the end of the list
                            controller.getHouses(
                              controller.currentFocusType,
                              loadMore: true,
                              // scrollPosition:
                              //     controller.scrollController.position.pixels,
                            );
                          }

                          return true;
                        },
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 1,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                          ),
                          controller: controller.scrollController,
                          itemCount: controller
                                  .houseLists[controller.currentFocusType]
                                  ?.length ??
                              0,
                          itemBuilder: (BuildContext ctx, index) {
                            List<Datum>? dataList = controller
                                .houseLists[controller.currentFocusType];

                            if (dataList == null) {
                              return SizedBox
                                  .shrink(); // Return an empty widget if dataList is null
                            }

                            var price = dataList[index].price ?? 1.0;
                            var formattedPrice = replaceFarsiNumber(price);

                            return GestureDetector(
                              onTap: () {},
                              child: GridViewContainer(
                                type: controller.currentFocusType == 1
                                    ? 'شراء'
                                    : (controller.currentFocusType == 2
                                        ? 'استأجار'
                                        : 'استثمار'),
                                image:
                                    'https://i.ytimg.com/vi/nWSwPB4SJ38/maxresdefault.jpg',
                                favoritColor:
                                    dataList[index].isFavorited == true
                                        ? ColorConstant.backgroundColor
                                        : ColorConstant.textColor,
                                price: formattedPrice,
                                addToFavorit: () {
                                  controller.addToFavorit(dataList[index].id);
                                },
                              ),
                            );
                          },
                        ),
                      );
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

replaceFarsiNumber(input) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const farsi = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

  String inputString = input.toString();
  for (int i = 0; i < english.length; i++) {
    inputString = inputString.replaceAll(english[i], farsi[i]);
  }

  return inputString;
}
