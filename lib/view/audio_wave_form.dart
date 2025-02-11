import 'dart:async';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view_model/question_answer_view_model.dart';

class AudioWaveForm extends StatefulWidget {
  const AudioWaveForm({
    super.key,
    // required this.audioQuestions,
    this.controller,
    required this.videoUrl,
    this.isSolutionScreen = false,
    this.index = 0,
    this.onTap,
    // this.isAnswerFilled = false,
  });
  // final bool isAnswerFilled;
   final void Function()? onTap;
  final TextEditingController? controller;
  final String videoUrl;
  final bool isSolutionScreen;
  final int index;

  @override
  State<AudioWaveForm> createState() => _AudioWaveFormState();
}

class _AudioWaveFormState extends State<AudioWaveForm> {
  QuestionsAnswerViewModel questionsAnswerViewModel = Get.find();
  bool isFillAnswer = false;
  bool _isLoading = true;
  String? video;

  @override
  void initState() {
    super.initState();
    getVideoUrl();
  }

  void getVideoUrl() async {
    video = widget.videoUrl;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Obx(() {
        final isNotSame = questionsAnswerViewModel.questionsDetail[widget.index].selectedAnswer.toString() !=
            questionsAnswerViewModel.questionsDetail[widget.index].correctAns.toString();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            _isLoading
                ? const CircularProgressIndicator()
                : WaveBubble(
                    videoUrl: video,
                  ),
            SizeConfig.sH20,
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: AppColors.greyFD,
                border: Border.all(
                  color: widget.isSolutionScreen ? AppColors.greyEE : Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: widget.isSolutionScreen
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (isNotSame)
                            CustomText(
                              AppStrings.yourAnswer,
                              color: AppColors.redB2,
                              fontWeight: FontWeight.w700,
                              fontSize: 15.sp,
                            ),
                          if (isNotSame) SizeConfig.sH15,
                          if (isNotSame)
                            CustomText(
                              questionsAnswerViewModel.questionsDetail[widget.index].selectedAnswer
                                  .toString(),
                            ),
                          SizeConfig.sH15,
                          CustomText(AppStrings.correctAnswer,
                              color: AppColors.green0B, fontWeight: FontWeight.w700),
                          SizeConfig.sH15,
                          CustomText(
                            questionsAnswerViewModel.questionsDetail[widget.index].correctAns.toString(),
                          ),
                        ],
                      ),
                    )
                  : TextFormField(
                      controller: widget.controller,
                      cursorColor: AppColors.primaryColor,
                      showCursor: true,
                      maxLines: 9,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return AppStrings.pleaseEnterSomeText;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: AppStrings.writeHere,
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.black.withOpacity(0.8),
                          fontWeight: FontWeight.w500,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColors.greyEE,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColors.greyEE,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        contentPadding: EdgeInsets.only(left: 10.w, top: 10.h, bottom: 10.h),
                      ),
                      keyboardType: TextInputType.multiline,
                      onTap: widget.onTap,
                    ),
            ),
          ],
        );
      }),
    );
  }
}

class WaveBubble extends StatefulWidget {
  final String? videoUrl;

  const WaveBubble({
    Key? key,
    this.videoUrl,
  }) : super(key: key);

  @override
  State<WaveBubble> createState() => _WaveBubbleState();
}

class _WaveBubbleState extends State<WaveBubble> {
  File? file;
  late PlayerController controller;
  late StreamSubscription<PlayerState> playerStateSubscription;

  final playerWaveStyle = PlayerWaveStyle(
    fixedWaveColor: AppColors.primaryColor11.withOpacity(0.4),
    liveWaveColor: AppColors.primaryColor,
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

  Future<void> _preparePlayer() async {
    if (widget.videoUrl != null) {
      file = await _downloadFile(widget.videoUrl!);
    }
    if (file?.path == null) {
      return;
    }
    controller.preparePlayer(
      path: file!.path,
      shouldExtractWaveform: true,
    );
  }

  Future<File> _downloadFile(String url) async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    final filePath = "${documentDirectory.path}/${url.split('/').last}";
    final file = File(filePath);

    final response = await http.get(Uri.parse(url));
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }

  @override
  void dispose() {
    playerStateSubscription.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return file != null
        ? Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!controller.playerState.isStopped)
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: const Color(0xff1FA7A8),
                    child: IconButton(
                      onPressed: () async {
                        // controller.playerState.isPlaying
                        //     ? await controller.pausePlayer()
                        //     : await controller.startPlayer(
                        //         finishMode: FinishMode.loop,
                        //       );
                      },
                      icon: Icon(
                        controller.playerState.isPlaying ? Icons.stop : Icons.play_arrow,
                        size: 30,
                      ),
                      color: Colors.white,
                    ),
                  ),
                const SizedBox(width: 10),
                AudioFileWaveforms(
                  size: Size(MediaQuery.of(context).size.width / 1.5, 70),
                  playerController: controller,
                  waveformType: WaveformType.fitWidth,
                  playerWaveStyle: playerWaveStyle,
                ),
              ],
            ),
          )
        : const CircularProgressIndicator(
            color: AppColors.primaryColor,
          );
  }
}
