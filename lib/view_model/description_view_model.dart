import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class DescriptionViewModel extends GetxController {
  late VideoPlayerController videoPlayerController;

  RxBool onTouch = false.obs;
  RxBool isLoader = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    Future.delayed(const Duration(seconds: 2), () {
      isLoader.value = false;
    });

    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(
          'https://cdn.create.vista.com/api/media/medium/502694658/stock-video-dolly-out-shot-woman-short-red-hair-standing-blackboard-teaching?token='),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    videoPlayerController.addListener(() {});
    videoPlayerController.setLooping(true);
    videoPlayerController.pause();
    onTouch.value = true;

    print('init onTouch.value ==>> ${onTouch.value}');
    videoPlayerController.initialize();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    videoPlayerController.dispose();
    super.dispose();
  }
}
