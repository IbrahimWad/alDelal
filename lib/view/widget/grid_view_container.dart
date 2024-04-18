import 'package:aldlal/view/widget/custom_text.dart';
import 'package:flutter/material.dart';

class GridViewContainer extends StatelessWidget {
  final String image;
  final String type;
  final double price;
  const GridViewContainer({
    super.key,
    required this.type,
    required this.image,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          // color: Colors.white,
          color: Colors.amber),
      height: 172,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              color: Colors.black,
              height: double.infinity,
              width: double.infinity,
              child: Image(
                image: AssetImage(image),
                alignment: Alignment.center,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(height: 30, right: 10, child: CustomText(text: type)),
          Positioned(height: 30, left: 10, child: Icon(Icons.hearing_outlined)),
          Positioned(
              bottom: 5,
              left: 10,
              child: CustomText(
                text: price.toString(),
              ))
        ],
      ),
    );
  }
}
