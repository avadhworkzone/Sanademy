
import 'dart:async';
import 'dart:io';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sanademy/utils/app_colors.dart';

class AudioWaveForm extends StatefulWidget {
  const AudioWaveForm({super.key});

  @override
  State<AudioWaveForm> createState() => _AudioWaveFormState();
}

class _AudioWaveFormState extends State<AudioWaveForm> {
   late  Directory appDirectory;
   bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getDir();
  }
   void _getDir() async {
     appDirectory = await getApplicationSupportDirectory();
     setState(() {_isLoading = false;});
   }
   @override
   void dispose() {
     super.dispose();
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         _isLoading? const CircularProgressIndicator(): WaveBubble(
            index: 1,
            appDirectory: appDirectory,
          ),
        ],
      ),
    );
  }
}


class WaveBubble extends StatefulWidget {
  final int? index;
  final String? path;
  final Directory appDirectory;

  const WaveBubble({
    Key? key,
    required this.appDirectory,
    this.index,
    this.path,
  }) : super(key: key);

  @override
  State<WaveBubble> createState() => _WaveBubbleState();
}

class _WaveBubbleState extends State<WaveBubble> {

  File? file;
  late PlayerController controller;
  late StreamSubscription<PlayerState> playerStateSubscription;

  final playerWaveStyle =  PlayerWaveStyle(
    fixedWaveColor: AppColors.primaryColor11.withOpacity(0.4),
    liveWaveColor:  AppColors.primaryColor,
    spacing: 6,
  );

  @override
  void initState() {
    super.initState();
    controller = PlayerController();
    _preparePlayer();
    playerStateSubscription = controller.onPlayerStateChanged.listen((_) {
      setState(() {});
    });
  }

  void _preparePlayer() async {
    // Opening file from assets folder
    if (widget.index != null) {
      file = File('${widget.appDirectory.path}/audio${widget.index}.mp3');
      await file?.writeAsBytes(
          (await rootBundle.load('assets/audios/audio${widget.index}.mp3'))
              .buffer
              .asUint8List());
    }
    if (widget.index == null && widget.path == null && file?.path == null) {
      return;
    }
    controller.preparePlayer(
      path: widget.path ?? file!.path,
      shouldExtractWaveform:  true,
    );

  }

  @override
  void dispose() {
    playerStateSubscription.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.path != null || file?.path != null
        ? Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!controller.playerState.isStopped)
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Color(0xff1FA7A8),
                      child: IconButton(
                        onPressed: () async {
                          controller.playerState.isPlaying
                              ? await controller.pausePlayer()
                              : await controller.startPlayer(
                                  finishMode: FinishMode.loop,
                                );
                        },
                        icon: Icon(
                          controller.playerState.isPlaying
                              ? Icons.stop
                              : Icons.play_arrow,
                          size: 20,
                        ),
                        color: Colors.white,
                       /* splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,*/
                      ),
                    ),
                  const SizedBox(width: 10,),
                  AudioFileWaveforms(
                    size: Size(MediaQuery.of(context).size.width / 2, 70),
                    playerController: controller,
                    waveformType: WaveformType.fitWidth,
                    playerWaveStyle: playerWaveStyle,
                  ),
                ],
              ),
            ),
          )
        : const SizedBox();
  }
}
