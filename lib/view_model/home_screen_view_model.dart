import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanademy/networks/api_base_helper.dart';
import 'package:sanademy/networks/model/homeResModel.dart';
import 'package:sanademy/networks/services/apiService/home_categories_banner_api_service.dart';
import 'package:sanademy/utils/app_snackbar.dart';

class HomeScreenViewModel extends GetxController {
  Rx<TextEditingController> searchController = TextEditingController().obs;
  RxList<Categories> categoriesData = <Categories>[].obs;
  RxList<Banners> bannerData = <Banners>[].obs;
  RxList<HomeCoursesData> courses = <HomeCoursesData>[].obs;
  // RxString profileImage = SharedPreferenceUtils.getImage().obs;

  Future<void> categoriesAndBannerData() async {
    unFocus();
    final response = await HomeCategoriesBannerService().categoriesBannerRepo();
    if (checkStatusCode(response!.statusCode ?? 0)) {
      HomeResModel homeResModel =
          homeResModelFromJson(response.response.toString());
      if (homeResModel.success!) {
        if (homeResModel.data != null) {
          categoriesData.value = homeResModel.data!.categories!;
          bannerData.value = homeResModel.data!.banners!;
          courses.value = homeResModel.data!.courses!;
        }else{
          showErrorSnackBar('', homeResModel.message ?? 'Error');
        }
      }else{
         showErrorSnackBar('', homeResModel.message ?? 'Error');
      }
    }
  }

}
