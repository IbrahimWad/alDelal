import 'package:aldlal/core/viewModel/search_viewmode.dart';
import 'package:aldlal/view/widget/color_constant.dart';
import 'package:aldlal/view/widget/custom_text.dart';
import 'package:aldlal/view/widget/form_field_text.dart';
import 'package:aldlal/view/widget/grid_view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorConstant.backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  text: 'الرجوع',
                  fontSize: 20,
                  alignment: Alignment.center,
                ),
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 20,
                      color: ColorConstant.textColor,
                    )),
              ],
            ),
          )
        ],
      ),
      body: GetBuilder<SearchViewModel>(
          init: Get.put(SearchViewModel()),
          builder: (controller) {
            return Container(
              child: Column(
                children: [
                  TextFormFiledCustom(
                      controller: controller.searchControlletText),
                  SizedBox(height: 28),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 1,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                        itemCount: 5,
                        itemBuilder: (BuildContext ctx, index) {
                          //var formattedPrice = replaceFarsiNumber(price);

                          return GestureDetector(
                            onTap: () {},
                            child: GridViewContainer(
                              type: '',
                              image:
                                  'https://i.ytimg.com/vi/nWSwPB4SJ38/maxresdefault.jpg',
                              // favoritColor: dataList[index].isFavorited == true
                              //     ? ColorConstant.textColor
                              //     : ColorConstant.backgroundColor,
                              price: '0.2',
                              addToFavorit: () {
                                // controller.addToFavorit(dataList[index].id);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
