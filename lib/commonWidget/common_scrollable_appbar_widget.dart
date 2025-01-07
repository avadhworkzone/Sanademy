import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/local_assets.dart';

class CommonScrollableAppbarWidget extends StatefulWidget {
  const CommonScrollableAppbarWidget({Key? key}) : super(key: key);

  @override
  State<CommonScrollableAppbarWidget> createState() =>
      _CommonScrollableAppbarWidgetState();
}

class _CommonScrollableAppbarWidgetState
    extends State<CommonScrollableAppbarWidget> {
  late ScrollController _scrollController;
  final double _scrollSpeed = 15.0;
  void _startScrolling() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController
              .animateTo(
            _scrollController.offset + _scrollSpeed,
            duration: const Duration(milliseconds: 500),
            curve: Curves.linear,
          )
              .then((_) {
            if (_scrollController.offset >=
                _scrollController.position.maxScrollExtent) {
              _scrollController.jumpTo(0);
            }
            _startScrolling();
          });
        }
      });
    }
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startScrolling();
    });
    // _startScrolling();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 39.w,
      child: ListView.builder(
        controller: _scrollController,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              LocalAssets(
                imagePath: AppImageAssets.animationImage,
                imgColor: AppColors.white.withOpacity(0.4),
                boxFix: BoxFit.cover,
                width: Get.width,
                height: 28.h,
              ),
            ],
          );
        },
      ),
    );
  }
}
