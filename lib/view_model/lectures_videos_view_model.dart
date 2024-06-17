import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:sanademy/networks/api_base_helper.dart';
import 'package:sanademy/networks/api_keys.dart';
import 'package:sanademy/networks/model/course_detail_res_model.dart';
import 'package:sanademy/networks/model/save_course_progress_response_model.dart';
import 'package:sanademy/networks/services/apiService/save_course_progress_api_service.dart';
import 'package:sanademy/utils/app_snackbar.dart';
import 'package:sanademy/utils/enum_utils.dart';
import 'package:video_player/video_player.dart';

class LecturesVideosViewModel extends GetxController {
  RxBool isLoader = false.obs;
  RxList<ChewieController> chewieControllers = <ChewieController>[].obs;
  late VideoPlayerController videoPlayerController;
  ChewieController? currentlyPlayingController;
  Rx<Duration> currentVideoPosition = Duration.zero.obs;
  Rx<Duration> currentVideoDuration = Duration.zero.obs;
  List<Map<String, Duration>> videoDurations = [];



  Future<void> initializeVideoPlayers(List<Lectures> lecturesUrls) async {
    isLoader.value = true;
    for (var lectureUrl in lecturesUrls) {
      videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
        lectureUrl.videoUrl!,
      ));
      await videoPlayerController.initialize();
      videoDurations
          .add({'videoTotalTime': videoPlayerController.value.duration, 'videoWatchedTime': Duration.zero});
      // videoDurations.add(videoPlayerController.value.duration);
      // videoWatchedTimes.add(videoPlayerController.value.position);
      var chewieController = ChewieController(
          videoPlayerController: videoPlayerController,
          aspectRatio: 16 / 9,
          autoInitialize: true,
          showOptions: false);
      chewieControllers.add(chewieController);
      /* /// Ensure listener is added once
      if (!videoPlayerController.hasListeners) {
        videoPlayerController.addListener(() {
          if (videoPlayerController.value.isPlaying) {
            updateWatchedTime();
          }
        });
      }*/
    }
    isLoader.value = false;
  }

  /// PAUSE CURRENT PLAYING VIDEO
  void playVideo(ChewieController controller) {
    if (currentlyPlayingController != null && currentlyPlayingController != controller) {
      currentlyPlayingController!.pause();
    }
    controller.play();
    currentlyPlayingController = controller;
  }

  void pauseVideo(ChewieController controller, String courseId, String contentId, int lectureId) {
    if (controller.videoPlayerController.value.isPlaying) {
      controller.pause();

      Duration watchedTime = controller.videoPlayerController.value.position;
      Duration remainingTime = controller.videoPlayerController.value.duration - watchedTime;

      saveCourseProcessViewModel(
        courseId: courseId,
        courseContentId: contentId,
        lectureId: lectureId.toString(),
        completedMinute:watchedTime.inMinutes.toString(),
        remainingMinute: remainingTime.inMinutes.toString(),
      );
    }
  }

  /// Save Course Progress Api Calling Function
  Rx<ResponseStatus> saveCourseProgressResponseStatus = ResponseStatus.INITIAL.obs;

  Future<void> saveCourseProcessViewModel({
    required String courseId,
    required String courseContentId,
    required String lectureId,
    required String completedMinute,
    required String remainingMinute,
  }) async {
    unFocus();
    Map<String, String> queryParams = {
      ApiKeys.courseId: courseId,
      ApiKeys.courseContentId: courseContentId,
      ApiKeys.lectureId: lectureId,
      ApiKeys.completedMinute: completedMinute,
      ApiKeys.remainingMinute: remainingMinute,
    };

    final response = await SaveCourseProgressApiService().saveCourseProgressRepo(mapData: queryParams);

    if (checkStatusCode(response?.statusCode ?? 0)) {
      SaveCourseProgressResponseModel saveCourseProgressResponseModel =
          saveCourseProgressResponseModelFromJson(response!.response.toString());
      if (saveCourseProgressResponseModel.success!) {
        if (saveCourseProgressResponseModel.data != null) {
          videoDurations.clear();
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

  /// GET ALL VIDEO POSITION
  void updateWatchedTime() {
    for (var i = 0; i < chewieControllers.length; i++) {
      var controller = chewieControllers[i].videoPlayerController;
      if (controller.value.isInitialized) {
        videoDurations[i]['videoWatchedTime'] = controller.value.position;
      }
    }
  }


  /* List<Map<String, dynamic>> lecturesDuration = [];
  Duration videoTotalTime = Duration.zero;
  Duration videoWatchedTime = Duration.zero;
  Duration videoRemainingTime = Duration.zero;
  Duration allLectureDuration = Duration.zero;
  Duration allLectureWatchedTime = Duration.zero;
  Duration allLectureRemainingTime = Duration.zero;
  int allLectureWatchedTimeHours = 0;
  int allLectureWatchedTimeMinutes = 0;
  int allLectureRemainingTimeHours = 0;
  int allLectureRemainingTimeMinutes = 0;
  /// FOR ADD ALL TOTAL DURATION OF VIDEOS
  void addLecturesDuration(String contentId) {
    videoTotalTime = Duration.zero;
    videoWatchedTime = Duration.zero;
    videoRemainingTime = Duration.zero;

    for (var videoDuration in videoDurations) {
      videoTotalTime += videoDuration['videoTotalTime']!;
      videoWatchedTime += videoDuration['videoWatchedTime']!;
    }
    videoRemainingTime = videoTotalTime - videoWatchedTime;
    print('videoTotalTime+++++++$videoTotalTime');
    print('videoWatchedTime+++++++$videoWatchedTime');
    print('videoTotalTime+++++++$videoRemainingTime');
    final indexIs = lecturesDuration.indexWhere((element) => element['contentId'] == contentId);
    if (indexIs == -1) {
      lecturesDuration.add({
        'contentId': contentId,
        'totalDuration': videoTotalTime,
        'totalWatchedTime': videoWatchedTime,
        'totalRemainingTime': videoRemainingTime
      });
    } else if (lecturesDuration[indexIs]['contentId'] != contentId) {
      lecturesDuration.add({
        'contentId': contentId,
        'totalDuration': videoTotalTime,
        'totalWatchedTime': videoWatchedTime,
        'totalRemainingTime': videoRemainingTime
      });
      print('lecturesDuration-----------$lecturesDuration');
    }
    print('lecturesDuration*****$lecturesDuration');


    allLectureDuration = Duration.zero;
    allLectureWatchedTime = Duration.zero;
    allLectureRemainingTime = Duration.zero;

    allLectureWatchedTimeHours = 0;
    allLectureWatchedTimeMinutes = 0;
    allLectureRemainingTimeHours = 0;
    allLectureRemainingTimeMinutes = 0;

    for (var allDuration in lecturesDuration) {
      allLectureDuration += allDuration['totalDuration']!;
      allLectureWatchedTime += allDuration['totalWatchedTime']!;
      allLectureRemainingTime += allDuration['totalRemainingTime']!;

      allLectureWatchedTimeHours += allLectureWatchedTime.inHours;
      allLectureWatchedTimeMinutes += allLectureWatchedTime.inMinutes.remainder(60);

      allLectureRemainingTimeHours += allLectureRemainingTime.inHours;
      allLectureRemainingTimeMinutes += allLectureRemainingTime.inMinutes.remainder(60);
    }

    allLectureWatchedTimeHours += allLectureWatchedTimeMinutes ~/ 60;
    allLectureWatchedTimeMinutes %= 60;

    allLectureRemainingTimeHours += allLectureRemainingTimeMinutes ~/ 60;
    allLectureRemainingTimeMinutes %= 60;
    print(
        "allLectureWatchedTime*******--->$allLectureWatchedTimeHours hours $allLectureWatchedTimeMinutes minutes");
    print(
        "allLectureRemainingTime*******--->$allLectureRemainingTimeHours hours $allLectureRemainingTimeMinutes minutes");
  }*/

/*
/// FOR TOTAL DURATION OF VIDEOS
  Duration getTotalDuration() {
    return videoDurations.fold(Duration.zero, (sum, item) => sum + item);
  }

  /// FOR TOTAL WATCHED TIME OF VIDEOS
  Duration getTotalWatchedTime() {
    return videoWatchedTimes.fold(Duration.zero, (sum, item) => sum + item);
  }

  /// FOR TOTAL REMAINING TIME OF VIDEOS
  Duration getTotalRemainingTime() {
    return getTotalDuration()  - getTotalWatchedTime();
  }

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
 @override
  void onClose() {
    for (var controller in youtubePlayerControllers) {
      controller.dispose();
    }
    super.onClose();
  }*/
}
