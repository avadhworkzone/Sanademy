import 'dart:core';

import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/shared_preference_utils.dart';

class AppConstants {
  static const String baseImageAssetsPath = "assets/images/";
  static const String baseIconAssetsPath = "assets/icons/";
  static const String baseAudioAssetsPath = "assets/audio/";

  static const String quicksand = "Metropolis";
  // static const String quicksand = "Quicksand";
  static const String metropolis = "Metropolis";
  static const String NotoNaskhArabic = "NotoNaskhArabic";
}

 String getFontFamily() {
return SharedPreferenceUtils.getLangCode() == 'ar'
? AppConstants.NotoNaskhArabic
    : AppConstants.metropolis;
}

RxBool isCallApi = false.obs;

String formatDuration(int second) {
  final ms = second * 1000;

  int seconds = ms ~/ 1000;
  final int hours = seconds ~/ 3600;
  seconds = seconds % 3600;
  final minutes = seconds ~/ 60;
  seconds = seconds % 60;

  final hoursString = hours >= 10
      ? '$hours'
      : hours == 0
          ? '00'
          : '0$hours';

  final minutesString = minutes >= 10
      ? '$minutes'
      : minutes == 0
          ? '00'
          : '0$minutes';

  final secondsString = seconds >= 10
      ? '$seconds'
      : seconds == 0
          ? '00'
          : '0$seconds';

  final formattedTime =
// '${hoursString == '00' ? '' : '$hoursString:'}$minutesString:$secondsString';
      '$minutesString:$secondsString';

  return formattedTime;
}

