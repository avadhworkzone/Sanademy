import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanademy/networks/api_base_helper.dart';
import 'package:sanademy/networks/model/categoriesBannerResModel.dart';
import 'package:sanademy/networks/services/apiService/home_categories_banner_api_service.dart';
import 'package:sanademy/utils/app_snackbar.dart';

class HomeScreenViewModel extends GetxController {
  Rx<TextEditingController> searchController = TextEditingController().obs;
  RxList<Categories> categoriesData = <Categories>[].obs;
  RxList<Banners> bannerData = <Banners>[].obs;

  Future<void> categoriesAndBannerData() async {
    unFocus();
    final response = await HomeCategoriesBannerService().categoriesBannerRepo();
    if (checkStatusCode(response!.statusCode ?? 0)) {
      CategoriesBannerResModel categoriesBannerResModel =
          categoriesBannerResModelFromJson(response.response.toString());
      if (categoriesBannerResModel.success!) {
        if (categoriesBannerResModel.data != null) {
          categoriesData.value = categoriesBannerResModel.data!.categories!;
          bannerData.value = categoriesBannerResModel.data!.banners!;
        }else{
          await showSussesSnackBar('', categoriesBannerResModel.message ?? 'Error');
        }
      }else{
        await showSussesSnackBar('', categoriesBannerResModel.message ?? 'Error');
      }
    }
  }
}
