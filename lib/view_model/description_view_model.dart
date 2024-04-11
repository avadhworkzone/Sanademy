import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class DescriptionViewModel extends GetxController{

  late VideoPlayerController videoPlayerController;

  bool onTouch = false;
  
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(
          'https://cdn.create.vista.com/api/media/medium/502694658/stock-video-dolly-out-shot-woman-short-red-hair-standing-blackboard-teaching?token='),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    videoPlayerController.addListener(() {
    });
    videoPlayerController.setLooping(true);
    videoPlayerController.pause();
    onTouch=true;

    videoPlayerController.initialize();
  }
  
  @override
  void dispose() {
    // TODO: implement dispose
    videoPlayerController.dispose();
    super.dispose();
  }
}