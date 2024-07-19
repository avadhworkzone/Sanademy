import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sanademy/commonWidget/common_appbar.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/commonWidget/network_assets.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view/bottombar/bottom_bar.dart';
import 'package:sanademy/view_model/bottom_bar_view_model.dart';
import 'package:sanademy/view_model/notification_view_model.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  BottomBarViewModel bottomBarViewModel = Get.find();
  NotificationViewModel notificationViewModel = Get.put(NotificationViewModel());

  @override
  void initState() {
    getNotificationApiCall();
    super.initState();
  }

  getNotificationApiCall() async {
    await notificationViewModel.getNotificationData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.offAll(() => const BottomBar());
        return Future.value(true);
      },
      child: SafeArea(
        child: Scaffold(
            appBar: commonAppBar(
              centerTitle: true,
              appBarBackgroundColor: AppColors.white,
              titleWidget: commonBackArrowAppBar(
                  titleTxt: AppStrings.notification,
                  actionTitle: AppStrings.clearAll,
                  actionTextOnTap: () {},
                  horizontalPadding: 0.10.w,
                  leadingWidget: false),
            ),
            body: Obx(() {
              return Column(
                children: [
                  SizeConfig.sH15,
                  Expanded(
                    child: ListView.builder(
                      itemCount: notificationViewModel.getNotifications.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 22.w),
                              color: index.isOdd ? AppColors.white : AppColors.color8B.withOpacity(0.3),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      NetWorkOcToAssets(
                                          scale: 4.w,
                                          imgUrl: notificationViewModel.getNotifications[index].image)
                                      // CircleAvatar(
                                      //     radius: 20.w,
                                      //     backgroundColor:
                                      //         AppColors.primaryColor,
                                      //     child:
                                      // LocalAssets(
                                      //     imagePath: index.isOdd
                                      //         ? AppImageAssets.updateIcon
                                      //         : AppImageAssets.alertIcon,
                                      //     height: 20.w),
                                      // )
                                    ],
                                  ),
                                  SizeConfig.sW10,
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 10.w),
                                          child: CustomText(
                                            notificationViewModel.getNotifications[index].title ?? '',
                                            color: AppColors.black13,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20.sp,
                                          ),
                                        ),
                                        // SizeConfig.sH6,
                                        notificationViewModel.getNotifications[index].description == ''
                                            ? const SizedBox()
                                            : Html(
                                                shrinkWrap: true,
                                                data: notificationViewModel
                                                    .getNotifications[index].description),
                                        notificationViewModel.getNotifications[index].createdAt == ''
                                            ? const SizedBox()
                                            : Padding(
                                                padding: EdgeInsets.only(left: 10.w),
                                                child: CustomText(
                                                  DateFormat('d MMM, yyyy - h:mm a').format(DateTime.parse(
                                                      notificationViewModel
                                                          .getNotifications[index].createdAt!)),
                                                  fontSize: 12.sp,
                                                  color: AppColors.black0E,
                                                ),
                                              )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              height: 0.0,
                              color: AppColors.black.withOpacity(0.20),
                            )
                          ],
                        );
                      },
                    ),
                  )
                ],
              );
            })),
      ),
    );
  }
}
