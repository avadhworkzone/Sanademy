import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view/bottombar/bottom_bar.dart';
import 'package:sanademy/view_model/bottom_bar_view_model.dart';

class MyProgressScreen extends StatefulWidget {
  const MyProgressScreen({super.key});

  @override
  State<MyProgressScreen> createState() => _MyProgressScreenState();
}

class _MyProgressScreenState extends State<MyProgressScreen> {
  BottomBarViewModel bottomBarViewModel = Get.find();
  bool isLoading = false;

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        bottomBarViewModel.selectedBottomIndex.value = 0;
        Get.offAll(() => const BottomBar());
        return Future.value(true);
      },
      child: SafeArea(
        child: Material(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
            child: isLoading == true
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                        AppStrings.myProgress,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black0E,
                      ),
                      SizeConfig.sH25,
                      SizedBox(
                        child: CustomText(
                          AppStrings.progressIntroductionTxt,
                          color: AppColors.black0E.withOpacity(0.8),
                        ),
                      ),
                      SizeConfig.sH10,
                      Expanded(
                        child: ListView.builder(
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 20.w),
                              margin: EdgeInsets.symmetric(vertical: 10.w),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(
                                          AppColors.black.withOpacity(0.6),
                                          BlendMode.srcOver),
                                      filterQuality: FilterQuality.low,
                                      image: const NetworkImage(
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWpCP7MLNqspI1pA3XAurJiFdi2_t3ekbU0A&s',
                                      )),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  CustomText(
                                    'Exploring the Beauty of Mathematical Structures',
                                    color: AppColors.white,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      trackHeight: 12.w,
                                      thumbColor: AppColors.primaryColor,
                                      activeTrackColor: AppColors.white,
                                      inactiveTrackColor:
                                          AppColors.white.withOpacity(0.60),
                                      thumbShape: CustomSliderThumbShape(
                                        color1: AppColors.white,
                                        color2: AppColors.primaryColor,
                                      ),
                                      trackShape: CustomTrackShape(),
                                    ),
                                    child: Slider(
                                      value: 50000.0,
                                      min: 1000.0,
                                      max: 100000.0,
                                      onChanged: (double newValue) {},
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText('6 hours completed',
                                          color: AppColors.white,
                                          fontSize: 12.sp),
                                      CustomText('5 hours remaining',
                                          color: AppColors.white,
                                          fontSize: 12.sp),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect(
      {required RenderBox parentBox,
      Offset offset = Offset.zero,
      required SliderThemeData sliderTheme,
      bool isEnabled = false,
      bool isDiscrete = false}) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx + 2.0;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width - 5.0;

    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

class CustomSliderThumbShape extends SliderComponentShape {
  final Color color1;
  final Color color2;

  CustomSliderThumbShape({required this.color1, required this.color2});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(20.w, 40.w);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final Paint paint = Paint()..color = color1;

    final double radius = 13.0.w;

    final Path thumbPath = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius));

    canvas.drawPath(thumbPath, paint);

    final double secondCircleRadius = radius * 0.8.w;
    final Offset secondCircleCenter =
        Offset(center.dx, center.dy - radius / secondCircleRadius);

    final Paint secondColorPaint = Paint()..color = color2;

    canvas.drawCircle(center, secondCircleRadius, secondColorPaint);
  }
}
