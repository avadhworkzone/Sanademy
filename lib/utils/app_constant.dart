import 'dart:core';

import 'package:flutter/material.dart';
import 'package:sanademy/utils/app_colors.dart';

class AppConstants {
  static const String baseImageAssetsPath = "assets/images/";
  static const String baseIconAssetsPath = "assets/icons/";
  static const String baseAudioAssetsPath = "assets/audio/";

  static const String quicksand = "Quicksand";
}

final List<String> images = [
  "https://media.istockphoto.com/id/1149476751/vector/online-education-banner.jpg?s=612x612&w=0&k=20&c=P-6QFVRk4UGYTEqAyWWXI5BknkoKX6YxrmCKrPfE2vw=",
  "https://www.shutterstock.com/image-vector/student-character-study-computer-can-260nw-1399290638.jpg",
  "https://img.freepik.com/free-psd/e-learning-landing-page-template_23-2149113642.jpg?size=626&ext=jpg&ga=GA1.1.632798143.1705363200&semt=ais",
  "https://t3.ftcdn.net/jpg/03/46/60/00/360_F_346600043_sz6HF3HBXBBSwKLaJ3B7R9PWuFsHTLRB.jpg",
];

final List<Map<String, dynamic>> categoriesList = [
  {
    'Icon': Icons.calculate_outlined,
    // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdiA84YFxMVbMQyDPQ8-YLpyyvPXX75lQpdDm6SML0va5Qw7fCm046Hzu5eHsa1PbZLTk&usqp=CAU",
    'title': 'Mathematics',
    'color': AppColors.primaryColor,
  },
  {
    'Icon': Icons.language,
    //  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4FRrhI0Cg69MEC53yw1Q7X5oEyqR8apZY1Pf-r4AVZA&s",
    'title': 'Language',
    'color': AppColors.red,
  },
  {
    'Icon': Icons.color_lens_outlined,
    // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBVmxXi3m-Oj3WDPGz1UkrbHL9h0ggjH9TVa-HKl0O_g&s",
    'title': 'Arts',
    'color': AppColors.color9D,
  }
];

final List<Map<String, dynamic>> recommendedList = [
  {
    'titleTxt': 'Exploring the Beauty of Mathematical Structures',
    'lectures': '12 lectures',
    'time': '7 hours 40 minutes',
    'color': Colors.green,
  },
  {
    'titleTxt': 'Exploring the Beauty of Mathematical Structures',
    'lectures': '14 lectures',
    'time': '8 hours 30 minutes',
    'color': Colors.green.shade400,
  },
];

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
      '$hoursString:$minutesString:$secondsString';

  return formattedTime;
}

class DashBoardServiceModel {
  final String iconPath;
  final String title;
  final Color? bgColor;

  DashBoardServiceModel(
      {required this.iconPath, required this.title, required this.bgColor});
}

class WorkshopServiceModel {
  final String iconPath;
  final String title;
  final String subTitle;
  final String km;
  final String rate;

  WorkshopServiceModel(
      {required this.iconPath,
      required this.title,
      required this.rate,
      required this.subTitle,
      required this.km});
}

class AddressModel {
  final String? id;
  final String? name;

  AddressModel({this.id, this.name});
}

// List<AddressModel> addressList = [
//   AddressModel(id: AppConstants.home, name: AppStrings.home),
//   AddressModel(id: AppConstants.office, name: AppStrings.office),
//   AddressModel(id: AppConstants.other, name: AppStrings.other),
// ];

class WorkShopTabBarModel {
  final String? id;
  final String? name;

  WorkShopTabBarModel({this.id, this.name});
}

// List<WorkShopTabBarModel> workShopTabBarModelList = [
//   WorkShopTabBarModel(id: AppConstants.garageDetails, name: AppStrings.garageDetails),
//   WorkShopTabBarModel(id: AppConstants.priceDetails, name: AppStrings.priceDetails),
//   WorkShopTabBarModel(id: AppConstants.review, name: AppStrings.reviews),
// ];

class WorkShopSettingModel {
  final String iconPath;
  final String title;
  final String arrowIcon;
  final VoidCallback? onTap;

  WorkShopSettingModel(
      {this.onTap,
      required this.iconPath,
      required this.title,
      required this.arrowIcon});
}

class PricingListModel {
  final String package;
  final String serviceType;
  final String price;
  final VoidCallback? onTap;

  PricingListModel(
      {required this.package,
      required this.price,
      required this.serviceType,
      this.onTap});
}

class ServiceTypeModel {
  final String serviceType;
  final String discounttype;
  final VoidCallback? onTap;

  ServiceTypeModel(
      {required this.discounttype, required this.serviceType, this.onTap});
}

class PackageTypeModel {
  final String serviceType;
  final String discounttype;
  final String package;
  final VoidCallback? onTap;

  PackageTypeModel(
      {required this.package,
      required this.discounttype,
      required this.serviceType,
      this.onTap});
}

class MechanicsListModel {
  final String name;
  final String imagePath;

  MechanicsListModel({
    required this.name,
    required this.imagePath,
  });
}

class MechanicsList {
  static List<MechanicsListModel> mechanicsList = [
    MechanicsListModel(
        name: "dilip", imagePath: "assets/images/techinicionImg.png")
  ];
}

/// DOB

// DateTime calculateDateOfBirth() {
DateTime calculateDateOfBirth =
    DateTime.now().subtract(const Duration(days: 18 * 365));
// }

/// DATE FORMATE
String extractDate(String dateTimeStr) {
  List<String> parts = dateTimeStr.split(' ');
  return parts[0]; // Extracts the date part
}
