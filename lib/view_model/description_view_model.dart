import 'package:get/get.dart';
import 'package:sanademy/networks/api_base_helper.dart';
import 'package:sanademy/networks/api_keys.dart';
import 'package:sanademy/networks/model/course_detail_res_model.dart';
import 'package:sanademy/networks/model/save_course_progress_response_model.dart';
import 'package:sanademy/networks/services/apiService/course_detail_api_service.dart';
import 'package:sanademy/networks/services/apiService/save_course_progress_api_service.dart';
import 'package:sanademy/utils/app_snackbar.dart';
import 'package:sanademy/utils/enum_utils.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DescriptionViewModel extends GetxController {
  late VideoPlayerController videoPlayerController;

  RxBool onTouch = false.obs;
  RxBool isLoader = true.obs;
  RxBool isPaySuccessfully = false.obs;
  Duration watchedTime = Duration.zero;
  Duration remainingTime = Duration.zero;
  int completedHours = 0;
  int completedMinutes = 0;
  int remainingHours = 0;
  int remainingMinutes = 0;
  Rx<ResponseStatus> responseStatus = ResponseStatus.INITIAL.obs;
  Rx<YoutubePlayerController>? youtubePlayerController;
  bool videoStartedPlaying = false;

  @override
  void onClose() {
    super.onClose();
    // handleScreenTransition();
  }

  /// Youtube Player Function
  void youTubPlayer(String videosUrl) {
    Future.delayed(const Duration(seconds: 2), () {
      isLoader.value = false;
    });
    final videoUrl = videosUrl;
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);
    if (videoId != null) {
      youtubePlayerController?.value = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          isLive: true,
          autoPlay: false,
        ),
      );
    } else {
      showErrorSnackBar('Error', 'Invalid YouTube URL');
    }
/*
    /// Add a listener to the controller to track playback time
    youtubePlayerController?.value.addListener(() {
      if (youtubePlayerController?.value.value.isPlaying == true &&
          !videoStartedPlaying) {
        videoStartedPlaying = true;
      }
      final Duration currentTime =
          youtubePlayerController?.value.value.position ?? Duration.zero;
      watchedTime = currentTime;
      final Duration totalDuration =
          youtubePlayerController?.value.metadata.duration ?? Duration.zero;
      remainingTime = totalDuration - watchedTime;
      completedHours   = watchedTime.inHours;
      completedMinutes = watchedTime.inMinutes % 60;
      remainingHours   = remainingTime.inHours;
      remainingMinutes = remainingTime.inMinutes % 60;

      print('completedHours: --------=>$completedHours');
      print('completedMinutes: $completedMinutes');
      print('remainingHours: $remainingHours');
      print('remainingMinutes: $remainingMinutes');
    });*/
  }

/*
  void handleScreenTransition() {
    final Duration totalDuration =
        youtubePlayerController?.value.metadata.duration ?? Duration.zero;
    final int completedHours;
    final int completedMinutes;
    final int remainingHours;
    final int remainingMinutes;

    if (videoStartedPlaying) {
      completedHours = watchedTime.inHours;
      completedMinutes = watchedTime.inMinutes % 60;
      remainingHours = remainingTime.inHours;
      remainingMinutes = remainingTime.inMinutes % 60;
    } else {
      completedHours = 0;
      completedMinutes = 0;
      remainingHours = totalDuration.inHours;
      remainingMinutes = totalDuration.inMinutes % 60;
    }

    print('handleScreenTransition - completedHours: $completedHours, '
        'completedMinutes: $completedMinutes,'
        ' remainingHours: $remainingHours, '
        'remainingMinutes: $remainingMinutes');
    saveCourseProcessViewModel(
        courseId: '1',
        completedHour: completedHours.toString(),
        completedMinute: completedMinutes.toString(),
        remainingHour: remainingHours.toString(),
        remainingMinute: remainingMinutes.toString());
  }

  /// Save Course Progress Api Calling Function
  Rx<ResponseStatus> saveCourseProgressResponseStatus =
      ResponseStatus.INITIAL.obs;
  Future<void> saveCourseProcessViewModel({
    required String courseId,
    required String completedHour,
    required String completedMinute,
    required String remainingHour,
    required String remainingMinute,
  }) async {
    unFocus();
    Map<String, String> queryParams = {
      ApiKeys.courseId: courseId.toString(),
      ApiKeys.completedHour: completedHour.toString(),
      ApiKeys.completedMinute: completedMinute.toString(),
      ApiKeys.remainingHour: remainingHour.toString(),
      ApiKeys.remainingMinute: remainingMinute.toString(),
    };
    final response = await SaveCourseProgressApiService()
        .saveCourseProgressRepo(mapData: queryParams);
    if (checkStatusCode(response!.statusCode ?? 0)) {
      SaveCourseProgressResponseModel saveCourseProgressResponseModel =
          saveCourseProgressResponseModelFromJson(response.response.toString());
      if (saveCourseProgressResponseModel.success!) {
        if (saveCourseProgressResponseModel.data != null) {
          print(saveCourseProgressResponseModel.data);
          Get.back();
          saveCourseProgressResponseStatus.value = ResponseStatus.Completed;
        } else {
          showErrorSnackBar(
              '', saveCourseProgressResponseModel.message ?? 'Error');
        }
      } else {
        showErrorSnackBar(
            '', saveCourseProgressResponseModel.message ?? 'Error');
        saveCourseProgressResponseStatus.value = ResponseStatus.Error;
      }
    }
  }
*/


  /// Course Detail Api Calling Function
  CourseDetailResModel courseDetailResModel = CourseDetailResModel();
  Rx<ResponseStatus> courseDetailResponseStatus = ResponseStatus.INITIAL.obs;
  Future<void> courseDetailViewModel({
    required String courseId,
  }) async {
    unFocus();
    Map<String, String> queryParams = {
      ApiKeys.courseId: courseId.toString(),
    };
    final response =
        await CourseDetailApiService().courseDetailRepo(mapData: queryParams);
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


/*void videoPlayer(String videoUrl) {
    Future.delayed(const Duration(seconds: 2), () {
      isLoader.value = false;
    });
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(videoUrl
          // 'https://cdn.create.vista.com/api/media/medium/502694658/stock-video-dolly-out-shot-woman-short-red-hair-standing-blackboard-teaching?token='
          ),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );
    videoPlayerController.addListener(() {});
    videoPlayerController.setLooping(true);
    videoPlayerController.pause();
    videoPlayerController.initialize();
    onTouch.value = true;
  }*/
}
