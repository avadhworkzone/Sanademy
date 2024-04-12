import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sanademy/commonWidget/custom_btn.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/size_config_utils.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
          child: Column(
            children: [
              CustomBtn(
                onTap: () {},
                title: AppStrings.finishExam,
                bgColor: AppColors.white,
                borderColor: AppColors.primaryColor,
                textColor: AppColors.primaryColor,
                radius: 10,
              ),
              SizeConfig.sH15,
              Row(
                children: [
                  CustomText(
                    'Mathematics Mastery',
                    color: AppColors.black0E,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  )
                ],
              ),
              SizeConfig.sH25,
              Row(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 13.w, vertical: 13.w),
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(18)),
                    child: const Icon(
                      Icons.arrow_back,
                      color: AppColors.white,
                    ),
                  ),
                  SizeConfig.sW15,
                  Expanded(
                    child: CustomBtn(
                      onTap: () {},
                      title: 'Question 4 of 20',
                      textColor: AppColors.primaryColor,
                      bgColor: AppColors.greyFD,
                      borderColor: AppColors.primaryColor,
                      radius: 10,
                    ),
                  ),
                  SizeConfig.sW15,
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 13.w, vertical: 13.w),
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(18)),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
              SizeConfig.sH25,
              const CustomText(
                'Q4.  If a rectangle has a length of 8 units and a width of 5 units, what is its area?',
                color: AppColors.black,
                fontWeight: FontWeight.w700,
              ),
              ListView.builder(
                itemBuilder: (context, index) {
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
