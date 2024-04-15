import 'dart:core';

import 'package:flutter/material.dart';
import 'package:sanademy/utils/app_colors.dart';

class AppConstants {
  static const String baseImageAssetsPath = "assets/images/";
  static const String baseIconAssetsPath = "assets/icons/";

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
// class DummyData {
//   static List<DashBoardServiceModel> dashBoardServiceList = [
//     DashBoardServiceModel(iconPath: AppIconAssets.bookService, title: AppStrings.inStoreServices, bgColor: AppColors.cream),
//     DashBoardServiceModel(iconPath: AppIconAssets.doorstepService, title: AppStrings.doorstepService, bgColor: AppColors.coffeeLight),
//     DashBoardServiceModel(iconPath: AppIconAssets.pickupDropService, title: AppStrings.pickupDropService, bgColor: AppColors.pinkLight),
//     DashBoardServiceModel(iconPath: AppIconAssets.customService, title: AppStrings.customService, bgColor: AppColors.purpleLight),
//     // DashBoardServiceModel(
//     //     iconPath: AppIconAssets.engineWork,
//     //     title: AppStrings.engineWork,
//     //     bgColor: AppColors.greyLight),
//     // DashBoardServiceModel(
//     //     iconPath: AppIconAssets.electricalRepairs,
//     //     title: AppStrings.electricalRepairs,
//     //     bgColor: AppColors.greenLight),
//     // DashBoardServiceModel(
//     //     iconPath: AppIconAssets.supportAssistance,
//     //     title: AppStrings.supportAssistance,
//     //     bgColor: AppColors.greenLight),
//     // DashBoardServiceModel(
//     //     iconPath: AppIconAssets.expertMechanics,
//     //     title: AppStrings.expertMechanics,
//     //     bgColor: AppColors.greenLight),
//   ];
//
//   ///new home screen
//   static List<DashBoardServiceModel> dashBoardNewServiceList = [
//     DashBoardServiceModel(iconPath: AppIconAssets.listOfMechanics, title: AppStrings.listOfMechanics, bgColor: AppColors.cream),
//     DashBoardServiceModel(iconPath: AppIconAssets.paymentHistory, title: AppStrings.paymentHistory, bgColor: AppColors.coffeeLight),
//     DashBoardServiceModel(iconPath: AppIconAssets.supportRequest, title: AppStrings.supportRequest, bgColor: AppColors.pinkLight),
//     DashBoardServiceModel(iconPath: AppIconAssets.jobCard, title: AppStrings.jobCard, bgColor: AppColors.purpleLight),
//   ];
//
//   ///workshop screen
//   static List<WorkshopServiceModel> workshopGarageList = [
//     WorkshopServiceModel(iconPath: AppImageAssets.dummyGarage, title: 'Auto King Workshop', subTitle: 'Rome, NY 13440', km: '4.5', rate: '4.6'),
//     WorkshopServiceModel(iconPath: AppImageAssets.dummyGarage, title: 'Adonz Automative', subTitle: 'Rome, NY 13440', km: '2.3', rate: '4.3'),
//     WorkshopServiceModel(iconPath: AppImageAssets.dummyGarage, title: 'Latha Arts workshop', subTitle: 'Rome, NY 13440', km: '3.6', rate: '4.4'),
//     WorkshopServiceModel(iconPath: AppImageAssets.dummyGarage, title: 'Motospot Workshop', subTitle: 'Rome, NY 13440', km: '1.5', rate: '4.1'),
//     WorkshopServiceModel(iconPath: AppImageAssets.dummyGarage, title: 'Auto King Workshop', subTitle: 'Rome, NY 13440', km: '7.5', rate: '3.6'),
//     WorkshopServiceModel(iconPath: AppImageAssets.dummyGarage, title: 'Adonz Automative', subTitle: 'Rome, NY 13440', km: '6.5', rate: '2.5'),
//   ];
//
//   static List<String> dashboardNewAddOnServices = [
//     AppStrings.syntheticOil,
//     AppStrings.oilChange,
//     AppStrings.filterChange,
//     AppStrings.shellOil,
//     AppStrings.mirrorChanges,
//     AppStrings.shockerChecking,
//     AppStrings.dentRepair,
//   ];
// }

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
