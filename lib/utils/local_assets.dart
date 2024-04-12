// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LocalAssets extends StatelessWidget {
  const LocalAssets(
      {Key? key,
      required this.imagePath,
      this.height,
      this.width,
      this.imgColor,
      this.boxFix,
      this.scaleSize,
      this.boxFixSvg})
      : super(key: key);
  final String imagePath;
  final double? height, width, scaleSize;
  final Color? imgColor;
  final BoxFit? boxFix;
  final BoxFit? boxFixSvg;
  @override
  Widget build(BuildContext context) {
    return imagePath.split('.').last != 'svg'
        ? Image.asset(
            imagePath,
            height: height,
            width: width,
            scale: scaleSize,
            color: imgColor,
            fit: boxFix ?? BoxFit.contain,
          )
        : SvgPicture.asset(
            fit: boxFixSvg ?? BoxFit.cover,
            imagePath,
            height: height,
            width: width,
            color: imgColor,
          );
  }
}
