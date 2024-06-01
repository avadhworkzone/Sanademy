import 'package:get/get.dart';
import 'package:sanademy/networks/api_base_helper.dart';
import 'package:sanademy/networks/api_keys.dart';
import 'package:sanademy/networks/model/course_detail_res_model.dart';
import 'package:sanademy/networks/services/apiService/course_detail_api_service.dart';
import 'package:sanademy/utils/app_snackbar.dart';
import 'package:sanademy/utils/enum_utils.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DescriptionViewModel extends GetxController {
  late VideoPlayerController videoPlayerController;

  RxBool onTouch = false.obs;
  RxBool isLoader = true.obs;
  RxBool isPaySuccessfully = false.obs;

  Rx<ResponseStatus> responseStatus = ResponseStatus.INITIAL.obs;
  Rx<YoutubePlayerController>? youtubePlayerController;

 void videoPlayer(String videoUrl)  {
   Future.delayed(const Duration(seconds: 2), () {
     isLoader.value = false;
   });
   videoPlayerController =   VideoPlayerController.networkUrl(
     Uri.parse(
         videoUrl
         // 'https://cdn.create.vista.com/api/media/medium/502694658/stock-video-dolly-out-shot-woman-short-red-hair-standing-blackboard-teaching?token='
     ),
     videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
   );
   videoPlayerController.addListener(() {});
   videoPlayerController.setLooping(true);
   videoPlayerController.pause();
   videoPlayerController.initialize();
   onTouch.value = true;

 }

  void youTubPlayer(String videosUrl) {
    Future.delayed(const Duration(seconds: 2), () {
      isLoader.value = false;
    });
    final videoUrl = videosUrl;
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);
    if (videoId != null) {
      youtubePlayerController?.value = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(isLive: true,autoPlay: false,),
      );
    } else {
      showErrorSnackBar('Error', 'Invalid YouTube URL');
    }
  }

  CourseDetailResModel courseDetailResModel = CourseDetailResModel();
  Rx<ResponseStatus> courseDetailResponseStatus = ResponseStatus.INITIAL.obs;
  Future<void> courseDetailViewModel({
    required String courseId,
  }) async {
    unFocus();
    Map<String, String> queryParams = {
      ApiKeys.courseId: courseId.toString(),
    };
    final response = await CourseDetailApiService().courseDetailRepo(mapData: queryParams);
    if (checkStatusCode(response!.statusCode ?? 0)) {
      courseDetailResModel =
          courseDetailResModelFromJson(response.response.toString());
      if (courseDetailResModel.success!) {
        if (courseDetailResModel.data != null) {
          courseDetailResponseStatus.value = ResponseStatus.Completed;
        } else {
          showErrorSnackBar('', courseDetailResModel.message ?? 'Error');
        }
      } else {
        showErrorSnackBar('', courseDetailResModel.message ?? 'Error');
        courseDetailResponseStatus.value = ResponseStatus.Error;
      }
    }
  }
}
