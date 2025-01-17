import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanademy/networks/api_base_helper.dart';
import 'package:sanademy/networks/api_keys.dart';
import 'package:sanademy/networks/model/course_detail_res_model.dart';
import 'package:sanademy/networks/model/get_category_by_course_res_model.dart';
import 'package:sanademy/networks/model/home_res_model.dart';
import 'package:sanademy/networks/model/new_api_models/get_home_screen_data_res_model.dart';
import 'package:sanademy/networks/services/apiService/get_course_by_category_api_service.dart';
import 'package:sanademy/networks/services/apiService/home_data_api_service.dart';
import 'package:sanademy/utils/app_snackbar.dart';
import 'package:sanademy/utils/enum_utils.dart';

class HomeScreenViewModel extends GetxController {
  Rx<TextEditingController> searchController = TextEditingController().obs;

  /// Fetch Home Api Data
  RxList<HomeCategory> categoriesData = <HomeCategory>[].obs;
  RxList<Banners> bannerData = <Banners>[].obs;
  RxList<HomeCourse> courses = <HomeCourse>[].obs;
  RxString userImage = ''.obs;
  Rx<ResponseStatus> responseStatus = ResponseStatus.INITIAL.obs;
  HomeResModel homeResModel = HomeResModel();
  Rx<HomeUser?> userData = HomeUser().obs;

  // Future<void> homeViewModel({String search = ''}) async {
  //   Map<String, String> queryParams = {
  //     ApiKeys.search: search,
  //   };
  //   final response = await HomeDataService().homeDataRepo(mapData: queryParams);
  //   if (checkStatusCode(response!.statusCode ?? 0)) {
  //     homeResModel = homeResModelFromJson(response.response.toString());
  //     if (homeResModel.success!) {
  //       if (homeResModel.data != null) {
  //         categoriesData.value = homeResModel.data!.categories!;
  //         bannerData.value = homeResModel.data!.banners!;
  //         courses.value = homeResModel.data!.courses!;
  //         userImage.value = homeResModel.data?.user?.image ?? '';
  //         responseStatus.value = ResponseStatus.Completed;
  //       } else {
  //         showErrorSnackBar('', homeResModel.message ?? 'Error');
  //       }
  //     } else {
  //       showErrorSnackBar('', homeResModel.message ?? 'Error');
  //       responseStatus.value = ResponseStatus.Error;
  //     }
  //   }
  // }

  void updateUserImage(String newImageUrl) {
    userImage.value = newImageUrl;
  }

/*  /// Fetch Course Detail Data
  CourseDetailResModel courseDetailResModel = CourseDetailResModel();
  Rx<ResponseStatus> courseDetailResponseStatus = ResponseStatus.INITIAL.obs;
  Future<void> courseDetailViewModel({
    required String courseId,
  }) async {
    unFocus();
    Map<String, String> queryParams = {
      ApiKeys.courseId: courseId.toString(),
    };
    final response =
    await CourseDetailApiService().courseDetailRepo(mapData: queryParams);
    if (checkStatusCode(response!.statusCode ?? 0)) {
      courseDetailResModel =
          courseDetailResModelFromJson(response.response.toString());
      if (courseDetailResModel.success!) {
        if (courseDetailResModel.data != null) {
          courseDetailResponseStatus.value = ResponseStatus.Completed;
        } else {
          showErrorSnackBar('', courseDetailResModel.message ?? 'Error');
        }
      } else {
        showErrorSnackBar('', courseDetailResModel.message ?? 'Error');
        courseDetailResponseStatus.value = ResponseStatus.Error;
      }
    }
  }*/

  /// Fetch Category Wise CourseData
  Rx<ResponseStatus> categoryWiseCourseResponseStatus =
      ResponseStatus.INITIAL.obs;
  RxList<CategoryWiseCourse> categoryWiseCourseList =
      <CategoryWiseCourse>[].obs;

  Future<void> getCategoryWiseCourseData({
    required String categoryId,
  }) async {
    unFocus();
    Map<String, String> queryParams = {
      ApiKeys.categoryId: categoryId.toString(),
    };
    final response = await GetCourseByCategory()
        .getCourseByCategoryRepo(mapData: queryParams);
    if (checkStatusCode(response!.statusCode ?? 0)) {
      GetCategoryByCourseResModel getCategoryByCourseResModel =
          getCategoryByCourseResModelFromJson(response.response.toString());
      if (getCategoryByCourseResModel.success!) {
        if (getCategoryByCourseResModel.data != null) {
          categoryWiseCourseList.value = getCategoryByCourseResModel.data!;
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

  ///New APIS
  Rx<ResponseStatus> homeResponseStatus = ResponseStatus.INITIAL.obs;

  Future<void> getHomeScreenData() async {
    homeResponseStatus.value = ResponseStatus.Loading;

    final response = await HomeDataService().homeScreenRepo();

    if (response != null && checkStatusCode(response.statusCode ?? 0)) {
      try {
        GetHomeScreenDataResModel getHomeScreenDataResModel =
        getHomeScreenDataResModelFromJson(response.response.toString());

        // Check if the response contains valid data
        if ((getHomeScreenDataResModel.success ?? false) &&
            ((getHomeScreenDataResModel.categories?.isNotEmpty ?? false) ||
                (getHomeScreenDataResModel.courses?.isNotEmpty ?? false))) {
          categoriesData.value = getHomeScreenDataResModel.categories ?? [];
          userData.value = getHomeScreenDataResModel.user;
          // bannerData.value = homeResModel.data!.banners!;
          courses.value = getHomeScreenDataResModel.courses ?? [];
          userImage.value = userData.value?.image ?? '';
          homeResponseStatus.value = ResponseStatus.Completed;
        } else {
          // showErrorSnackBar('Error', getHomeScreenDataResModel.message ?? 'No data found');
          showErrorSnackBar('Error',  'No data found');
          homeResponseStatus.value = ResponseStatus.Error;
        }
      } catch (e) {
        // Handle JSON parsing or other errors
        showErrorSnackBar('Error', 'Failed to parse response');
        homeResponseStatus.value = ResponseStatus.Error;
      }
    } else {
      showErrorSnackBar('Error', 'Failed to fetch data from server');
      homeResponseStatus.value = ResponseStatus.Error;
    }
  }

}
