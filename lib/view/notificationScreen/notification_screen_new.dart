import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/common_appbar.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/size_config_utils.dart';
import 'package:sanademy/view_model/notification_view_model.dart';

class NotificationScreenNew extends StatefulWidget {
  const NotificationScreenNew({Key? key}) : super(key: key);

  @override
  State<NotificationScreenNew> createState() => _NotificationScreenNewState();
}

class _NotificationScreenNewState extends State<NotificationScreenNew> {
  NotificationViewModel notificationViewModel =
      Get.put(NotificationViewModel());

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
    return Scaffold(
      body: Obx(() {
        if (notificationViewModel.notifications.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commonOnlyTitleAppBar(
              context: context,
              isBackBtn: true,
              paddingLeft: 18.w,
              actionWidget: SizeConfig.sW40,
              title: AppStrings.notifications,
              postText: AppStrings.markAllRead,
              otherWidget: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizeConfig.sH35,
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: notificationViewModel.notifications.length,
                itemBuilder: (context, index) {
                  final section = notificationViewModel.notifications[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(section.createdAt ?? '',
                            fontWeight: FontWeight.w600),
                      ),
                      // Section Items
                      ...notificationViewModel.notifications
                          .asMap()
                          .entries
                          .map<Widget>((entry) {
                        int itemIndex = entry.key;
                        var item = entry.value;
                        bool isLastItem = itemIndex ==
                            notificationViewModel.notifications.length - 1;

                        return Container(
                          color: AppColors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ListTile(
                                // contentPadding: EdgeInsets.zero,
                                leading: CircleAvatar(
                                  backgroundColor:
                                      AppColors.grey74.withOpacity(0.2),
                                  backgroundImage: item.image != null
                                      ? NetworkImage(item.image ?? '')
                                      : null,
                                  child: item.image == null
                                      ? const Icon(Icons.notifications,
                                          color: AppColors.primaryColor)
                                      : null,
                                ),
                                title: CustomText(item.title ?? '',
                                    fontWeight: FontWeight.w600),
                                subtitle: CustomText(
                                    cleanHtmlContent(item.description ?? '') ??
                                        '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                                // subtitle: Html(
                                //   shrinkWrap: true,
                                //   data: item.description,
                                //   style: {
                                //     'body': Style(
                                //       maxLines: 1,
                                //       textOverflow: TextOverflow.ellipsis,
                                //     ),
                                //   },
                                // ),
                                trailing: CustomText(
                                  _formatTime(item.createdAt ?? ''),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp,
                                ),
                              ),
                              // Show divider only if it's not the last item
                              if (!isLastItem) const Divider(),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  String cleanHtmlContent(String content) {
    return content.replaceAll(RegExp(r'<p>|</p>'), '');
  }

  String _formatTime(String dateTime) {
    final DateTime date = DateTime.parse(dateTime);
    return '${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}
