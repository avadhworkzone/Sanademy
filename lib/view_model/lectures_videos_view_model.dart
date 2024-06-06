import 'package:get/get.dart';
import 'package:sanademy/networks/api_base_helper.dart';
import 'package:sanademy/networks/api_keys.dart';
import 'package:sanademy/networks/model/course_detail_res_model.dart';
import 'package:sanademy/networks/model/save_course_progress_response_model.dart';
import 'package:sanademy/networks/services/apiService/course_detail_api_service.dart';
import 'package:sanademy/networks/services/apiService/save_course_progress_api_service.dart';
import 'package:sanademy/utils/app_snackbar.dart';
import 'package:sanademy/utils/enum_utils.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LecturesVideosViewModel extends GetxController {
  RxBool isLoader = true.obs;
  RxBool onTouch = false.obs;
  var youtubePlayerControllers = <YoutubePlayerController>[].obs;
  bool videoStartedPlaying = false;
  Duration watchedTime = Duration.zero;
  Duration remainingTime = Duration.zero;
  Duration totalWatchedTime = Duration.zero;
  Duration totalRemainingTime = Duration.zero;
  Duration totalDuration = Duration.zero;
  int completedHours = 0;
  int completedMinutes = 0;
  int remainingHours = 0;
  int remainingMinutes = 0;

  /// Initialize YouTube Player Controllers for a list of video URLs
  void initializeYouTubePlayers(List<String> videoUrls) {
    for (var url in videoUrls) {
      final videoId = YoutubePlayer.convertUrlToId(url);
      if (videoId != null) {
        var controller = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            isLive: true,
            autoPlay: false,
          ),
        );
        youtubePlayerControllers.add(controller);
        _addListenerToController(controller);
      } else {
        showErrorSnackBar('Error', 'Invalid YouTube URL');
      }
    }

    Future.delayed(const Duration(seconds: 2), () {
      isLoader.value = false;
    });
  }

  /// Add a listener to the controller to track playback time
  void _addListenerToController(YoutubePlayerController controller) {
    controller.addListener(() {
      if (controller.value.isPlaying && !videoStartedPlaying) {
        videoStartedPlaying = true;
      }
      _updateAggregateTimes();
    });
  }
  /// Update aggregate times for all videos
  void _updateAggregateTimes() {
    totalWatchedTime = Duration.zero;
    totalRemainingTime = Duration.zero;
    totalDuration = Duration.zero;

    for (var controller in youtubePlayerControllers) {
      var watchedTime = controller.value.position;
      var totalVideoDuration = controller.metadata.duration;
      var remainingTime = totalVideoDuration - watchedTime;

      totalWatchedTime += watchedTime;
      totalRemainingTime += remainingTime;
      totalDuration += totalVideoDuration;
    }

    print('Total Watched Time: $totalWatchedTime');
    print('Total Remaining Time: $totalRemainingTime');
    print('Total Duration: $totalDuration');
  }

  /// Handle screen transition
  Future<void>  handleScreenTransition() async {
    final completedHours = totalWatchedTime.inHours;
    final completedMinutes = totalWatchedTime.inMinutes % 60;
    final remainingHours = totalRemainingTime.inHours;
    final remainingMinutes = totalRemainingTime.inMinutes % 60;

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
      ApiKeys.courseId: courseId,
      ApiKeys.completedHour: completedHour,
      ApiKeys.completedMinute: completedMinute,
      ApiKeys.remainingHour: remainingHour,
      ApiKeys.remainingMinute: remainingMinute,
    };

    final response = await SaveCourseProgressApiService()
        .saveCourseProgressRepo(mapData: queryParams);

    if (checkStatusCode(response?.statusCode ?? 0)) {
      SaveCourseProgressResponseModel saveCourseProgressResponseModel =
      saveCourseProgressResponseModelFromJson(response!.response.toString());
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

  @override
  void onClose() {
    for (var controller in youtubePlayerControllers) {
      controller.dispose();
    }
    super.onClose();
  }
}

