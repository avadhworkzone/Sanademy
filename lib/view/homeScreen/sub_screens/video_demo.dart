import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:video_player/video_player.dart';

class VideoDemo extends StatefulWidget {
  const VideoDemo({super.key});

  @override
  State<VideoDemo> createState() => _VideoDemoState();
}

class _VideoDemoState extends State<VideoDemo> {
  late VideoPlayerController _controller;

  bool _onTouch = false;
  @override
  void initState() {
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.pause();

    _controller.initialize();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: Stack(
            alignment: Alignment.center,
            children: [
              VideoPlayer(_controller),
              InkWell(
                  onTap: () {
                    setState(() {
                      _onTouch = true;
                    });
                    if (_controller.value.isPlaying) {
                      _controller.pause();
                    } else {
                      // If the video is paused, play it.
                      _controller.play();
                    }
                    Future.delayed(
                      Duration(seconds: 10),
                      () => setState(() {
                        _onTouch = false;
                      }),
                    );
                  },
                  child: _onTouch == true &&
                      _controller.value.isPlaying == true
                      ? const Icon(Icons.pause_circle, size: 50,color: Colors.white,)
                      : _onTouch == true &&
                      _controller.value.isPlaying ==
                          false
                      ? const Icon(Icons.play_circle, size: 50,color: Colors.white)
                                       :Container())
            ],
          ),
        ),
      ),
    );
  }
}
