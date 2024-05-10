
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octo_image/octo_image.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/local_assets.dart';

class NetWorkOcToAssets extends StatelessWidget {
  const NetWorkOcToAssets(
      {Key? key,
      this.height = 0,
      required this.imgUrl,
      this.boxFit,
      this.scale})
      : super(key: key);
  final String? imgUrl;
  final BoxFit? boxFit;
  final double? scale;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return OctoImage(
      fit: boxFit ?? BoxFit.cover,
      image: NetworkImage("$imgUrl", scale: scale ?? 1),
      // progressIndicatorBuilder: (context, progress) {
      //   return showShimmer(height: height);
      // },
      errorBuilder: (context, error, stacktrace) => LocalAssets(
        imagePath: AppImageAssets.noImageFound,
        // imgColor: AppColors.white,
        boxFix: BoxFit.cover,
      ),
    );
  }
}
