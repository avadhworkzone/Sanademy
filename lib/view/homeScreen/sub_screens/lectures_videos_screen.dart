import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/common_appbar.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view_model/lectures_videos_view_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LecturesVideoScreen extends StatefulWidget {
  const LecturesVideoScreen(
      {super.key,
      required this.lectureVideoUrls,
      required this.videoTitle,
      required this.videoDescription});

  final String videoTitle;
  final String videoDescription;
  final List<String> lectureVideoUrls;

  @override
  State<LecturesVideoScreen> createState() => _LecturesVideoScreenState();
}

class _LecturesVideoScreenState extends State<LecturesVideoScreen> {
  final LecturesVideosViewModel lecturesVideosViewModel =
      Get.put(LecturesVideosViewModel());

  @override
  void initState() {
    super.initState();
    lecturesVideosViewModel.initializeYouTubePlayers(widget.lectureVideoUrls);
  }

  @override
  void dispose() {
    // callFunction();
    super.dispose();
  }

  callFunction() async {
    await lecturesVideosViewModel.handleScreenTransition();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => lecturesVideosViewModel.isLoader.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    commonBackArrowAppBar(
                      titleTxt: AppStrings.courseContentLectures,
                      actionWidget: false,
                      backOnTap: (){
                        lecturesVideosViewModel.handleScreenTransition();
                      }
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: widget.lectureVideoUrls.length,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 10),
                          child: lecturesVideosViewModel.isLoader.value == true
                              ? Center(
                                  child: SizedBox(
                                      height: 50.h,
                                      width: 50.h,
                                      child: const LocalAssets(
                                        imagePath: AppImageAssets.sanademaylogo,
                                        imgColor: AppColors.primaryColor,
                                      )),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(0, 1),
                                        blurRadius: 4.0,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Padding(
                                    padding:  EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        YoutubePlayerBuilder(
                                          player: YoutubePlayer(
                                            controller: lecturesVideosViewModel
                                                .youtubePlayerControllers[index],
                                            showVideoProgressIndicator: true,
                                            onReady: () {
                                              lecturesVideosViewModel
                                                  .youtubePlayerControllers[index]
                                                  .addListener(() {
                                                lecturesVideosViewModel
                                                        .onTouch.value =
                                                    lecturesVideosViewModel
                                                        .youtubePlayerControllers[
                                                            index]
                                                        .value
                                                        .isPlaying;
                                              });
                                            },
                                          ),
                                          builder: (context, player) => player,
                                        ),
                                        SizeConfig.sH5,
                                        CustomText(
                                          widget.videoTitle,
                                          fontSize: 18.sp,
                                          color: AppColors.black0E,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 25.w, right: 20.w),
                                          child: Row(
                                            children: [
                                              CustomText(
                                                "•",
                                                fontSize: 18.sp,
                                                color: AppColors.black0E,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              Html(
                                                data: widget.videoDescription,
                                                shrinkWrap: true,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
