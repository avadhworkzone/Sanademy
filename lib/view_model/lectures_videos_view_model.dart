
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanademy/networks/api_base_helper.dart';
import 'package:sanademy/networks/api_keys.dart';
import 'package:sanademy/networks/model/course_detail_res_model.dart';
import 'package:sanademy/networks/model/save_course_progress_response_model.dart';
import 'package:sanademy/networks/services/apiService/save_course_progress_api_service.dart';
import 'package:sanademy/utils/app_snackbar.dart';
import 'package:sanademy/utils/enum_utils.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LecturesVideosViewModel extends GetxController {
  RxBool isLoader = true.obs;
  RxBool onTouch = false.obs;
  var youtubePlayerControllers = <YoutubePlayerController>[].obs;
  RxList videoControllers = <VideoPlayerController>[].obs;
  RxList<ChewieController> chewieControllers = <ChewieController>[].obs;
  ChewieController? currentlyPlayingController;
  List<Lectures> lectures = [];
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initializeVideoPlayers();
  }
  void initializeVideoPlayers() {
    for (var lecture in lectures) {
      var controller = VideoPlayerController.networkUrl(Uri.parse(
          lecture.videoUrl!
          // 'https://cdn.create.vista.com/api/media/medium/502694658/stock-video-dolly-out-shot-woman-short-red-hair-standing-blackboard-teaching?token=',
      ));
     var chewieController = ChewieController(
        videoPlayerController: controller,
        aspectRatio: 16 / 9,
        autoPlay: false,
        looping: false,
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.red,
          handleColor: Colors.blue,
          backgroundColor: Colors.grey,
          bufferedColor: Colors.lightGreen,
        ),
        placeholder: Container(
          color: Colors.grey,
        ),
        autoInitialize: true,
      );
      // controller.addListener(() {
      //   _updateAggregateTimes();
      // });
      controller.initialize().then((_) {
        if (videoControllers.length == lectures.length) {
          isLoader.value = false;
        }
        videoControllers.add(controller);
        if (chewieControllers.length == lectures.length) {
          isLoader.value = false;
        }
        videoControllers.add(controller);
        chewieControllers.add(chewieController);
        Future.delayed(const Duration(seconds: 2), () {
          isLoader.value = false;
        });
      }).catchError((err) {
        print('Some Error:====> $err');
      });
    }
  }

  void playVideo(ChewieController controller) {
    if (currentlyPlayingController != null && currentlyPlayingController != controller) {
      currentlyPlayingController!.pause();
    }
    controller.play();
    currentlyPlayingController = controller;
  }


  @override
  void dispose() {
    for (var controller in videoControllers) {
      controller.dispose();
    }
    for (var cController in chewieControllers){
      cController.dispose();
    }
    super.dispose();
  }


  /// Update aggregate times for all videos
  void _updateAggregateTimes() {
    totalWatchedTime = Duration.zero;
    totalRemainingTime = Duration.zero;
    totalDuration = Duration.zero;

    for (var controller in videoControllers) {
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
  Future<void> handleScreenTransition() async {
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
  Rx<ResponseStatus> saveCourseProgressResponseStatus = ResponseStatus.INITIAL.obs;

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

    final response = await SaveCourseProgressApiService().saveCourseProgressRepo(mapData: queryParams);

    if (checkStatusCode(response?.statusCode ?? 0)) {
      SaveCourseProgressResponseModel saveCourseProgressResponseModel =
          saveCourseProgressResponseModelFromJson(response!.response.toString());
      if (saveCourseProgressResponseModel.success!) {
        if (saveCourseProgressResponseModel.data != null) {
          print(saveCourseProgressResponseModel.data);
          Get.back();
          saveCourseProgressResponseStatus.value = ResponseStatus.Completed;
        } else {
          showErrorSnackBar('', saveCourseProgressResponseModel.message ?? 'Error');
        }
      } else {
        showErrorSnackBar('', saveCourseProgressResponseModel.message ?? 'Error');
        saveCourseProgressResponseStatus.value = ResponseStatus.Error;
      }
    }
  }


 /* Future<Duration> getVideoDuration(String url) async {
    final VideoPlayerController controller = VideoPlayerController.network(url);
    await controller.initialize();
    final duration = controller.value.duration;
    controller.dispose();
    return duration;
  }

  void fetchVideoDuration() async {
    final url = 'https://www.example.com/video.mp4';
    final duration = await getVideoDuration(url);
    print('Video duration: ${duration.inMinutes} minutes and ${duration.inSeconds % 60} seconds');
  }*/

  /// Initialize YouTube Player Controllers for a list of video URLs
  void initializeYouTubePlayers(List<Lectures> videoUrls) {
    for (var url in videoUrls) {
      final videoId = YoutubePlayer.convertUrlToId(url.videoUrl!);
      if (videoId != null) {
        var controller = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            isLive: true,
            autoPlay: false,
          ),
        );
        youtubePlayerControllers.add(controller);
        // getVideoDuration( "https://www.youtube.com/watch?v=ZHenb2_eOTU");
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

/* @override
  void onClose() {
    for (var controller in youtubePlayerControllers) {
      controller.dispose();
    }
    super.onClose();
  }*/
}
