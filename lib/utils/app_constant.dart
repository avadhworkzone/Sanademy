import 'dart:core';

import 'package:flutter/material.dart';

class AppConstants {
  static const String baseImageAssetsPath = "assets/images/";
  static const String baseIconAssetsPath = "assets/icons/";

  static const String quicksand = "Quicksand";

}

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

  DashBoardServiceModel({required this.iconPath, required this.title, required this.bgColor});
}

class WorkshopServiceModel {
  final String iconPath;
  final String title;
  final String subTitle;
  final String km;
  final String rate;

  WorkshopServiceModel({required this.iconPath, required this.title, required this.rate, required this.subTitle, required this.km});
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

  WorkShopSettingModel({this.onTap, required this.iconPath, required this.title, required this.arrowIcon});
}

class PricingListModel {
  final String package;
  final String serviceType;
  final String price;
  final VoidCallback? onTap;

  PricingListModel({required this.package, required this.price, required this.serviceType, this.onTap});
}


class ServiceTypeModel {
  final String serviceType;
  final String discounttype;
  final VoidCallback? onTap;

  ServiceTypeModel({required this.discounttype, required this.serviceType, this.onTap});
}


class PackageTypeModel {
  final String serviceType;
  final String discounttype;
  final String package;
  final VoidCallback? onTap;

  PackageTypeModel({required this.package, required this.discounttype, required this.serviceType, this.onTap});
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
  static List<MechanicsListModel> mechanicsList = [MechanicsListModel(name: "dilip", imagePath: "assets/images/techinicionImg.png")];
}

/// DOB

// DateTime calculateDateOfBirth() {
DateTime calculateDateOfBirth = DateTime.now().subtract(const Duration(days: 18 * 365));
// }

/// DATE FORMATE
String extractDate(String dateTimeStr) {
  List<String> parts = dateTimeStr.split(' ');
  return parts[0]; // Extracts the date part
}
