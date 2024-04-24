import 'package:aldlal/view/widget/color_constant.dart';
import 'package:aldlal/view/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GridViewContainer extends StatelessWidget {
  final String image;
  final String type;
  final String price;
  final Color favoritColor;
  const GridViewContainer({
    super.key,
    required this.type,
    required this.image,
    required this.price,
    this.favoritColor = ColorConstant.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ColorConstant.textColor)
          // color: Colors.white,
          //  color: Colors.amber,
          ),
      height: 172,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              color: Colors.black,
              height: double.infinity,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: image,
                cacheKey: image, // Use the image URL as the cache key
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          Positioned(height: 30, right: 10, child: CustomText(text: type)),
          const Positioned(
            height: 40,
            left: 10,
            child: Image(
              image: AssetImage('assets/images/favorit.png'),
              height: 24,
              width: 24,
            ),
          ),
          Positioned(
              bottom: 5,
              left: 10,
              child: Row(
                children: [
                  CustomText(
                    text: price,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  CustomText(text: 'IQ'),
                ],
              ))
        ],
      ),
    );
  }
}
