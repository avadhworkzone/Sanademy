import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffectWithItems extends StatelessWidget {
  const ShimmerEffectWithItems({Key? key}) : super(key: key);

  Widget buildShimmerLine(double width, double height) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shimmer placeholder for Section Title
          buildShimmerLine(100.0, 16.0),
          SizedBox(height: 10.0),

          // Horizontal list view for shimmer items
          SizedBox(
            height: 150.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3, // Show 3 shimmer items
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 300.0, // Set width for shimmer items
                      margin: EdgeInsets.only(right: 16.0),
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.white, // Shimmer effect color
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
