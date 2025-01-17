//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:octo_image/octo_image.dart';
// import 'package:sanademy/utils/app_colors.dart';
// import 'package:sanademy/utils/app_image_assets.dart';
// import 'package:sanademy/utils/local_assets.dart';
//
// class NetWorkOcToAssets extends StatelessWidget {
//    const NetWorkOcToAssets(
//       {Key? key,
//       this.height = 120,
//       this.width = double.infinity,
//       required this.imgUrl,
//       this.boxFit,
//       this.scale})
//       : super(key: key);
//   final String? imgUrl;
//   final BoxFit? boxFit;
//   final double? scale;
//   final double? height;
//   final double? width;
//   @override
//   Widget build(BuildContext context) {
//     return OctoImage(
//       fit: boxFit ?? BoxFit.cover,
//       height: height,
//       width: width,
//       image: NetworkImage("$imgUrl", scale: scale ?? 1,),
//       // progressIndicatorBuilder: (context, progress) {
//       //   return showShimmer(height: height);
//       // },
//       errorBuilder: (context, error, stacktrace) => LocalAssets(
//         imagePath: AppImageAssets.noImageFound,
//         // imgColor: AppColors.white,
//         boxFix: BoxFit.cover,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:shimmer/shimmer.dart';

class NetWorkOcToAssets extends StatelessWidget {
  const NetWorkOcToAssets({
    Key? key,
    this.height = 120,
    this.width = double.infinity,
    required this.imgUrl,
    this.boxFit,
    this.scale,
  }) : super(key: key);

  final String? imgUrl;
  final BoxFit? boxFit;
  final double? scale;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return OctoImage(
      fit: boxFit ?? BoxFit.cover,
      height: height,
      width: width,
      image: NetworkImage(
        "$imgUrl",
        scale: scale ?? 1,
      ),
      progressIndicatorBuilder: (context, progress) {
        return _buildShimmer();
      },
      errorBuilder: (context, error, stacktrace) => LocalAssets(
        imagePath: AppImageAssets.noImageFound,
        boxFix: BoxFit.cover,
      ),
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: AppColors.greyE0,
      highlightColor: AppColors.greyE4.withOpacity(0.3),
      child: Container(
        height: height,
        width: width,
        color: AppColors.greyE0, // Match the base color
      ),
    );
  }

}
