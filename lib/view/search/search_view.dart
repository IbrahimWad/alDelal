import 'package:aldlal/core/viewModel/search_viewmodel.dart';
import 'package:aldlal/view/widget/color_constant.dart';
import 'package:aldlal/view/widget/custom_text.dart';
import 'package:aldlal/view/widget/grid_view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchViewModel>(
      init: SearchViewModel(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: ColorConstant.backgroundColor,
          appBar: AppBar(
            backgroundColor: ColorConstant.backgroundColor,
            elevation: 0,
            leading: IconButton(
              icon: Image.asset('assets/images/search.png', height: 25),
              onPressed: () {
                showSearch(context: context, delegate: controller);
              },
            ),
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
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          body: Container(
            child: Column(
              children: [
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
                        return GestureDetector(
                          onTap: () {},
                          child: GridViewContainer(
                            type: '',
                            image:
                                'https://i.ytimg.com/vi/nWSwPB4SJ38/maxresdefault.jpg',
                            price: '0.2',
                            addToFavorit: () {},
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
