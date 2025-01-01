import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/common_appbar.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/local_assets.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       body: Column(children: [
         Container(
           height: 300,
           decoration:
         BoxDecoration(image: DecorationImage(
           image: AssetImage('assets/images/Background.png'), // Replace with your image path
           fit: BoxFit.cover, // Adjusts how the image fits the container
         ),),)
         // Image.asset('assets/images/Background.png')
       ],),

//       appBar: AppBar(
//       centerTitle:  true,
//       leading: Row(
//         children: [
//           SizedBox(
//             width: 8.w,
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 13.w,vertical: 13.w),
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//               color: AppColors.white.withOpacity(0.2),
//                 shape: BoxShape.circle,
//                 border: Border.all(color:
//                 AppColors.white.withOpacity(0.5))),
//             child:  Icon(
//               weight: 10.w,
// size: 12.w
// ,              Icons.arrow_back_ios_new,
//               color: AppColors.white,),)
//         ],
//       ),
//       automaticallyImplyLeading: false,
//       title: Column(
//         children: [
//           Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               LocalAssets(
//                 imagePath: AppImageAssets.sanademaylogo,
//                 width: 42.w,
//                 height: 35.w,
//               ),
//               CustomText(
//                 AppStrings.titleTxt.tr,
//                 color: AppColors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20.sp,
//               ),
//             ],
//           ),
//           CustomText(
//             'Which language would you prefer for the app?'
//             ,
//             color: AppColors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 20.sp,
//           ),
//         ],
//       ),
//       flexibleSpace: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/images/Background.png'), // Replace with your image path
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//     ),
    );
  }
}
