import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/shared_preference_utils.dart';
import 'package:sanademy/view/language_screen/language_screen.dart';
import 'package:video_player/video_player.dart';
import 'package:sanademy/view/bottombar/bottom_bar.dart';
import 'package:sanademy/view/general/connectivity_wrapper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();

    // Initialize the video controller
    _videoController =
        VideoPlayerController.asset('assets/images/splash_screen_video.mp4')
          ..initialize().then((_) {
            setState(() {}); // Refresh the widget once the video is loaded
            _videoController.play(); // Start the video playback
          });

    // Navigate to the next screen after 5 seconds
    Future.delayed(
      const Duration(seconds: 4),
      () => Get.offAll(
        () => ConnectivityWrapper(
          child: SharedPreferenceUtils.getLangCode() == ""
              ? const LanguageScreen()
              : const BottomBar(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _videoController.dispose(); // Dispose the video controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.primaryColor,
      body: _videoController.value.isInitialized
          ? Stack(
              fit: StackFit.expand,
              children: [
                FittedBox(
                  fit: BoxFit.cover, // Ensures the video covers the screen
                  child: SizedBox(
                    width: _videoController.value.size.width,
                    height: _videoController.value.size.height,
                    child: VideoPlayer(_videoController),
                  ),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            ),
    );
  }
}
