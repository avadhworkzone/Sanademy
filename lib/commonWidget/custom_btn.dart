import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:shimmer/shimmer.dart';

class CustomBtn extends StatelessWidget {
  final VoidCallback? onTap;
  final String? title;
  final double? radius;
  final double? height;
  final double? width;
  final Color? bgColor;
  final Color? textColor;
  final Color? borderColor;
  final double? fontSize;
  final bool? isDownloadFile;
  final IconData? leading;
  final bool? withIcon;
  final String? iconPath;
  final FontWeight? fontWeight;
  final Widget? widget;
  final List<BoxShadow>? boxShadow;

  // ignore: use_key_in_widget_constructors
  const CustomBtn(
      {required this.onTap,
      required this.title,
      this.radius,
      this.fontWeight,
      this.borderColor,
      this.height,
      this.width,
      this.fontSize,
      this.bgColor,
      this.textColor,
      this.leading,
      this.withIcon = false,
      this.iconPath,
      this.isDownloadFile = false,
      this.widget,
      this.boxShadow});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: height ?? 50.h,
        width: width ?? Get.width,
        decoration: BoxDecoration(
          color: bgColor ?? AppColors.primaryColor,
          border: Border.all(color: borderColor ?? Colors.transparent),
          borderRadius: BorderRadius.circular(radius ?? 5),
          image: DecorationImage(
              image: AssetImage(AppImageAssets.appLogo), fit: BoxFit.cover),
          boxShadow: boxShadow,
        ),
        child: widget ??
            InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(radius ?? 5),
              child: Center(
                child: CustomText(
                  title!.tr,
                  fontWeight: fontWeight ?? FontWeight.w600,
                  color: textColor ?? AppColors.white,
                  fontSize: fontSize ?? 15.sp,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
      ),
    );
  }
}

class CustomUpdateBtn extends StatefulWidget {
  final VoidCallback? onTap;
  final String? title;
  final double? radius;
  final double? height;
  final double? width;
  final Color? bgColor;
  final Color? textColor;
  final Color? borderColor;
  final double? fontSize;
  final FontWeight? fontWeight;

  const CustomUpdateBtn({
    required this.onTap,
    required this.title,
    this.radius,
    this.fontWeight,
    this.borderColor,
    this.height,
    this.width,
    this.fontSize,
    this.bgColor,
    this.textColor,
    Key? key,
  }) : super(key: key);

  @override
  _CustomUpdateBtnState createState() => _CustomUpdateBtnState();
}

class _CustomUpdateBtnState extends State<CustomUpdateBtn>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            height: widget.height ?? 50.h,
            width: widget.width ?? Get.width,
            decoration: BoxDecoration(
              color: widget.bgColor ?? AppColors.primaryColor,
              border:
                  Border.all(color: widget.borderColor ?? Colors.transparent),
              borderRadius: BorderRadius.circular(widget.radius ?? 15),
              gradient: LinearGradient(
                colors: [
                  widget.bgColor ?? AppColors.primaryColor,
                  (widget.bgColor ?? AppColors.primaryColor).withOpacity(0.5),
                  widget.bgColor ?? AppColors.primaryColor,
                ],
                stops: const [
                  0.0,
                  0.5,
                  1.0,
                ],
                begin: Alignment(-1 + 2 * _animationController.value, 0),
                end: Alignment(1 + 2 * _animationController.value, 0),
              ),
            ),
            child: InkWell(
              onTap: widget.onTap,
              borderRadius: BorderRadius.circular(widget.radius ?? 15),
              child: Center(
                child: Text(
                  widget.title ?? '',
                  style: TextStyle(
                    color: widget.textColor ?? Colors.white,
                    fontSize: widget.fontSize ?? 15.sp,
                    fontWeight: widget.fontWeight ?? FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// class CustomUpdateBtn extends StatelessWidget {
//   final VoidCallback? onTap;
//   final String? title;
//   final double? radius;
//   final double? height;
//   final double? width;
//   final Color? bgColor;
//   final Color? textColor;
//   final Color? borderColor;
//   final double? fontSize;
//   final bool? isDownloadFile;
//   final IconData? leading;
//   final bool? withIcon;
//   final String? iconPath;
//   final FontWeight? fontWeight;
//   final Widget? widget;
//   final List<BoxShadow>? boxShadow;
//
//   // ignore: use_key_in_widget_constructors
//   const CustomUpdateBtn(
//       {required this.onTap,
//       required this.title,
//       this.radius,
//       this.fontWeight,
//       this.borderColor,
//       this.height,
//       this.width,
//       this.fontSize,
//       this.bgColor,
//       this.textColor,
//       this.leading,
//       this.withIcon = false,
//       this.iconPath,
//       this.isDownloadFile = false,
//       this.widget,
//       this.boxShadow});
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: Container(
//         height: height ?? 50.h,
//         width: width ?? Get.width,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage(
//                 AppImageAssets.appLogo), // Replace with your image path
//             fit: BoxFit.cover, // Adjusts how the image fits the container
//           ),
//           color: bgColor ?? AppColors.primaryColor,
//           border: Border.all(color: borderColor ?? Colors.transparent),
//           borderRadius: BorderRadius.circular(radius ?? 15),
//           // boxShadow: boxShadow,
//         ),
//         child: widget ??
//             InkWell(
//               onTap: onTap,
//               borderRadius: BorderRadius.circular(radius ?? 5),
//               child: Center(
//                 child: CustomText(
//                   title!.tr,
//                   fontWeight: fontWeight ?? FontWeight.w600,
//                   color: textColor ?? AppColors.white,
//                   fontSize: fontSize ?? 15.sp,
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//       ),
//     );
//   }
// }
