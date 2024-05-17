import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanademy/networks/api_base_helper.dart';
import 'package:sanademy/networks/api_keys.dart';
import 'package:sanademy/networks/model/get_category_by_course_res_model.dart';
import 'package:sanademy/networks/model/home_res_model.dart';
import 'package:sanademy/networks/services/apiService/get_course_by_category_api_service.dart';
import 'package:sanademy/networks/services/apiService/home_data_api_service.dart';
import 'package:sanademy/utils/app_snackbar.dart';
import 'package:sanademy/utils/enum_utils.dart';

class HomeScreenViewModel extends GetxController {
  Rx<TextEditingController> searchController = TextEditingController().obs;
  RxList<Categories> categoriesData = <Categories>[].obs;
  RxList<Banners> bannerData = <Banners>[].obs;
  RxList<Courses> courses = <Courses>[].obs;
  Rx<ResponseStatus> responseStatus = ResponseStatus.INITIAL.obs;

  Future<void> homeViewModel() async {
    unFocus();
    final response = await HomeDataService().homeDataRepo();
    if (checkStatusCode(response!.statusCode ?? 0)) {
      HomeResModel homeResModel =
          homeResModelFromJson(response.response.toString());
      if (homeResModel.success!) {
        if (homeResModel.data != null) {
          categoriesData.value = homeResModel.data!.categories!;
          bannerData.value = homeResModel.data!.banners!;
          courses.value = homeResModel.data!.courses!;
          responseStatus.value = ResponseStatus.Completed;
        }else{
          showErrorSnackBar('', homeResModel.message ?? 'Error');
        }

      }else{
         showErrorSnackBar('', homeResModel.message ?? 'Error');responseStatus.value = ResponseStatus.Error;
      }
    }
  }

  Rx<ResponseStatus> categoryWiseCourseResponseStatus = ResponseStatus.INITIAL.obs;
  RxList<CategoryWiseCourse> categoryWiseCourseList = <CategoryWiseCourse>[].obs;

  Future<void> getCategoryWiseCourseData ({
    required String categoryId,
  }) async {
    unFocus();
    Map<String, String> queryParams = {
      ApiKeys.categoryId: categoryId.toString(),
    };
    final response =
    await GetCourseByCategory().getCourseByCategoryRepo(mapData: queryParams);
    if (checkStatusCode(response!.statusCode ?? 0)) {
      GetCategoryByCourseResModel getCategoryByCourseResModel =
      getCategoryByCourseResModelFromJson(response.response.toString());
      if (getCategoryByCourseResModel.success!) {
        if (getCategoryByCourseResModel.data != null) {
          categoryWiseCourseList.value=getCategoryByCourseResModel.data!;
          categoryWiseCourseResponseStatus.value = ResponseStatus.Completed;
        } else {
          showErrorSnackBar('', getCategoryByCourseResModel.message ?? 'Error');
        }
      } else {
        showErrorSnackBar('', getCategoryByCourseResModel.message ?? 'Error');
        categoryWiseCourseResponseStatus.value = ResponseStatus.Error;
      }
    }
  }

}
