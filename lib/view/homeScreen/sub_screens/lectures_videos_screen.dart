import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/common_appbar.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/networks/model/course_detail_res_model.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view_model/lectures_videos_view_model.dart';
import 'package:video_player/video_player.dart';

class LecturesVideoScreen extends StatefulWidget {
  const LecturesVideoScreen({
    super.key,
    required this.lectureVideoUrls,
    required this.contentId,
  });

  final String contentId;
  final List<Lectures> lectureVideoUrls;

  @override
  State<LecturesVideoScreen> createState() => _LecturesVideoScreenState();
}

class _LecturesVideoScreenState extends State<LecturesVideoScreen> {
  LecturesVideosViewModel lecturesVideosViewModel = Get.put(LecturesVideosViewModel());

  @override
  void initState() {
    super.initState();
    lecturesVideosViewModel.lectures = widget.lectureVideoUrls;
    lecturesVideosViewModel.initializeVideoPlayers();
  }

  @override
  void dispose() {
    lecturesVideosViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Obx(
          () => Column(
            children: [
              commonBackArrowAppBar(
                  titleTxt: AppStrings.courseContentLectures,
                  actionWidget: false,
                 ),
              (lecturesVideosViewModel.isLoader.value == false)
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: widget.lectureVideoUrls.length,
                        itemBuilder: (context, index) {
                          var controller = lecturesVideosViewModel.chewieControllers[index].videoPlayerController;
                               return controller.value.isInitialized
                                  ? Padding(
                                      padding: EdgeInsets.only(right: 10.w, left: 10.w, bottom: 15.h),
                                      child: Container(
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
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              AspectRatio(
                                                aspectRatio: controller.value.aspectRatio,
                                                child: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    Chewie(
                                                      controller:
                                                          lecturesVideosViewModel.chewieControllers[index],
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        if (controller.value.isPlaying) {
                                                          controller.pause();
                                                        } else {
                                                          lecturesVideosViewModel.playVideo(lecturesVideosViewModel.chewieControllers[index]);
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizeConfig.sH5,
                                              CustomText(
                                                widget.lectureVideoUrls[index].title ?? '',
                                                fontSize: 18.sp,
                                                color: AppColors.black0E,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(left: 25.w, right: 20.w),
                                                child: Row(
                                                  children: [
                                                    CustomText(
                                                      "•",
                                                      fontSize: 18.sp,
                                                      color: AppColors.black0E,
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                    Html(
                                                      data: widget.lectureVideoUrls[index].description ?? '',
                                                      shrinkWrap: true,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : Center(
                                      child: SizedBox(
                                          height: 50.h,
                                          width: 50.h,
                                          child: const LocalAssets(
                                            imagePath: AppImageAssets.sanademaylogo,
                                            imgColor: AppColors.primaryColor,
                                          )),
                                    );

                        },
                      ),
                    )
                  : const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
  String formatDuration(Duration duration) {
    return '${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}';
  }
}

/*class VideoPlayerItem extends StatelessWidget {
  final VideoPlayerController controller;
  final Lectures lecture;
  final VoidCallback onTap;

  const VideoPlayerItem({
    super.key,
    required this.controller,
    required this.lecture,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.w, left: 10.w, bottom: 15.h),
      child: Container(
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 250.h,
                width: 430.w,
                child: AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      VideoPlayer(controller),
                      InkWell(
                        onTap: () {
                          if (controller.value.isPlaying) {
                              controller.pause();
                          } else {
                              controller.play();
                          }
                        },
                        child: controller.value.isPlaying
                            ? const Icon(Icons.pause_circle, size: 50, color: Colors.white)
                            : const Icon(Icons.play_circle, size: 50, color: Colors.white),
                      ),
                      Positioned(
                        bottom: 10.h,
                        width: Get.width,
                        child: ValueListenableBuilder(
                          valueListenable: controller,
                          builder: (context, VideoPlayerValue value, child) {
                            return Slider(
                              value: value.position.inSeconds.toDouble(),
                              min: 0.0,
                              max: value.duration.inSeconds.toDouble(),
                              onChanged: (value) {
                                controller.seekTo(Duration(seconds: value.toInt()));
                              },
                            );
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 5.h,
                        right: 10.w,
                        child: ValueListenableBuilder(
                          valueListenable: controller,
                          builder: (context, VideoPlayerValue value, child) {
                            return CustomText(
                              "${formatDuration(value.position)} / ${formatDuration(value.duration)}",
                              fontSize: 12.sp,
                              color: AppColors.white,
                              fontWeight: FontWeight.w700,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizeConfig.sH5,
              CustomText(
                lecture.title ?? '',
                fontSize: 18.sp,
                color: AppColors.black0E,
                fontWeight: FontWeight.w700,
              ),
              Padding(
                padding: EdgeInsets.only(left: 25.w, right: 20.w),
                child: Row(
                  children: [
                    CustomText(
                      "•",
                      fontSize: 18.sp,
                      color: AppColors.black0E,
                      fontWeight: FontWeight.w700,
                    ),
                    Html(
                      data: lecture.description ?? '',
                      shrinkWrap: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatDuration(Duration duration) {
    return '${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}';
  }
}*/

// class LecturesVideoScreen extends StatefulWidget {
//   const LecturesVideoScreen({
//     super.key,
//     required this.lectureVideoUrls,
//     required this.contentId,
//   });
//
//   final String contentId;
//   final List<Lectures> lectureVideoUrls;
//
//   @override
//   State<LecturesVideoScreen> createState() => _LecturesVideoScreenState();
// }
//
// class _LecturesVideoScreenState extends State<LecturesVideoScreen> {
//   LecturesVideosViewModel lecturesVideosViewModel = Get.put(LecturesVideosViewModel());
//
//   @override
//   void initState() {
//     super.initState();
//     lecturesVideosViewModel.lectures = widget.lectureVideoUrls;
//     lecturesVideosViewModel.initializeVideoPlayers();
//   }
//
//   @override
//   void dispose() {
//     lecturesVideosViewModel.dispose();
//     super.dispose();
//   }
//
//   callFunction() async {
//     await lecturesVideosViewModel.handleScreenTransition();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Obx(
//             () =>  Padding(
//           padding: const EdgeInsets.only(top: 20),
//           child: Column(
//             children: [
//               commonBackArrowAppBar(
//                   titleTxt: AppStrings.courseContentLectures,
//                   actionWidget: false,
//                   backOnTap: () {
//                     lecturesVideosViewModel.handleScreenTransition();
//                   }),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: widget.lectureVideoUrls.length,
//                   itemBuilder: (context, index) {
//                     var lecture = widget.lectureVideoUrls[index];
//                     var controller = lecturesVideosViewModel.videoControllers[index];
//                     return lecturesVideosViewModel.isLoader.value == true
//                         ? Center(
//                       child: SizedBox(
//                           height: 50.h,
//                           width: 50.h,
//                           child: const LocalAssets(
//                             imagePath: AppImageAssets.sanademaylogo,
//                             imgColor: AppColors.primaryColor,
//                           )),
//                     )
//                         : Container(
//                       decoration: BoxDecoration(
//                         color: AppColors.white,
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Colors.black26,
//                             offset: Offset(0, 1),
//                             blurRadius: 4.0,
//                           ),
//                         ],
//                         borderRadius: BorderRadius.circular(20.r),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               height: 328.66.h,
//                               width: 430.w,
//                               child: AspectRatio(
//                                 aspectRatio:controller.value.aspectRatio,
//                                 child: Stack(
//                                   alignment: Alignment.center,
//                                   children: [
//                                     VideoPlayer(controller),
//                                     InkWell(
//                                         onTap: () {
//                                           setState(() {
//                                             lecturesVideosViewModel.onTouch.value = true;
//                                           });
//                                           if (controller.value.isPlaying) {
//                                             controller.pause();
//                                           } else {
//                                             controller.play();
//                                           }
//                                           Future.delayed(
//                                             const Duration(seconds: 2),
//                                                 () => setState(() {
//                                               lecturesVideosViewModel.onTouch.value = false;
//                                             }),
//                                           );
//                                         },
//                                         child: lecturesVideosViewModel.onTouch == true &&
//                                             controller.value.isPlaying == true
//                                             ? const Icon(
//                                           Icons.pause_circle,
//                                           size: 50,
//                                           color: Colors.white,
//                                         )
//                                             : lecturesVideosViewModel.onTouch == true &&
//                                             controller.value.isPlaying == false
//                                             ? const Icon(Icons.play_circle,
//                                             size: 50, color: Colors.white)
//                                             : Container())
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             /*    YoutubePlayerBuilder(
//                                           player: YoutubePlayer(
//                                             controller: lecturesVideosViewModel
//                                                 .youtubePlayerControllers[index],
//                                             showVideoProgressIndicator: true,
//                                             onReady: () {
//                                               lecturesVideosViewModel
//                                                   .youtubePlayerControllers[index]
//                                                   .addListener(() {
//                                                 lecturesVideosViewModel
//                                                         .onTouch.value =
//                                                     lecturesVideosViewModel
//                                                         .youtubePlayerControllers[
//                                                             index]
//                                                         .value
//                                                         .isPlaying;
//                                               });
//                                             },
//                                           ),
//                                           builder: (context, player) => player,
//                                         ),*/
//                             SizeConfig.sH5,
//                             CustomText(
//                               lecture.title ?? '',
//                               fontSize: 18.sp,
//                               color: AppColors.black0E,
//                               fontWeight: FontWeight.w700,
//                             ),
//                             Padding(
//                               padding: EdgeInsets.only(left: 25.w, right: 20.w),
//                               child: Row(
//                                 children: [
//                                   CustomText(
//                                     "•",
//                                     fontSize: 18.sp,
//                                     color: AppColors.black0E,
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                   Html(
//                                     data:lecture.description ?? '',
//                                     shrinkWrap: true,
//                                   ),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               )
//
//               /* Expanded(
//                       child: ListView.builder(
//                         itemCount: 1,
//                         itemBuilder: (context, index) => Padding(
//                           padding: EdgeInsets.symmetric(
//                               vertical: 10.h, horizontal: 10),
//                           child: lecturesVideosViewModel.isLoader.value == true
//                               ? Center(
//                                   child: SizedBox(
//                                       height: 50.h,
//                                       width: 50.h,
//                                       child: const LocalAssets(
//                                         imagePath: AppImageAssets.sanademaylogo,
//                                         imgColor: AppColors.primaryColor,
//                                       )),
//                                 )
//                               : Container(
//                                   decoration: BoxDecoration(
//                                     color: AppColors.white,
//                                     boxShadow: const [
//                                       BoxShadow(
//                                         color: Colors.black26,
//                                         offset: Offset(0, 1),
//                                         blurRadius: 4.0,
//                                       ),
//                                     ],
//                                     borderRadius: BorderRadius.circular(20.r),
//                                   ),
//                                   child: Padding(
//                                     padding:  EdgeInsets.all(8.0),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         SizedBox(
//                                           height: 328.66.h,
//                                           width: 430.w,
//                                           child: AspectRatio(
//                                             aspectRatio: lecturesVideosViewModel.videoPlayerController.value.aspectRatio,
//                                             child: Stack(
//                                               alignment: Alignment.center,
//                                               children: [
//                                                 VideoPlayer(lecturesVideosViewModel.videoPlayerController),
//                                                 InkWell(
//                                                     onTap: () {
//                                                       setState(() {
//                                                         lecturesVideosViewModel.onTouch.value = true;
//                                                       });
//                                                       if (lecturesVideosViewModel.videoPlayerController.value.isPlaying) {
//                                                         lecturesVideosViewModel.videoPlayerController.pause();
//                                                       } else {
//                                                         // If the video is paused, play it.
//                                                         lecturesVideosViewModel.videoPlayerController.play();
//                                                       }
//                                                       Future.delayed(
//                                                         const Duration(seconds: 2),
//                                                             () => setState(() {
//                                                               lecturesVideosViewModel.onTouch.value = false;
//                                                         }),
//                                                       );
//                                                     },
//                                                     child: lecturesVideosViewModel.onTouch == true &&
//                                                         lecturesVideosViewModel.videoPlayerController.value.isPlaying == true
//                                                         ? const Icon(Icons.pause_circle, size: 50,color: Colors.white,)
//                                                         : lecturesVideosViewModel.onTouch == true &&
//                                                         lecturesVideosViewModel.videoPlayerController.value.isPlaying ==
//                                                             false
//                                                         ? const Icon(Icons.play_circle, size: 50,color: Colors.white)
//                                                         :Container())
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                     */
//               /*    YoutubePlayerBuilder(
//                                           player: YoutubePlayer(
//                                             controller: lecturesVideosViewModel
//                                                 .youtubePlayerControllers[index],
//                                             showVideoProgressIndicator: true,
//                                             onReady: () {
//                                               lecturesVideosViewModel
//                                                   .youtubePlayerControllers[index]
//                                                   .addListener(() {
//                                                 lecturesVideosViewModel
//                                                         .onTouch.value =
//                                                     lecturesVideosViewModel
//                                                         .youtubePlayerControllers[
//                                                             index]
//                                                         .value
//                                                         .isPlaying;
//                                               });
//                                             },
//                                           ),
//                                           builder: (context, player) => player,
//                                         ),*/
//               /*
//                                         SizeConfig.sH5,
//                                         CustomText(
//                                           widget.lectureVideoUrls[index].title??'',
//                                           fontSize: 18.sp,
//                                           color: AppColors.black0E,
//                                           fontWeight: FontWeight.w700,
//                                         ),
//                                         Padding(
//                                           padding: EdgeInsets.only(
//                                               left: 25.w, right: 20.w),
//                                           child: Row(
//                                             children: [
//                                               CustomText(
//                                                 "•",
//                                                 fontSize: 18.sp,
//                                                 color: AppColors.black0E,
//                                                 fontWeight: FontWeight.w700,
//                                               ),
//                                               Html(
//                                                 data:  widget.lectureVideoUrls[index].description??'',
//                                                 shrinkWrap: true,
//                                               ),
//                                             ],
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                         ),
//                       ),
//                     )*/
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
