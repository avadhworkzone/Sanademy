import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
    extends State<CommonScrollableAppbarWidget>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late Ticker _ticker;
  final double _scrollSpeed = 0.3;
  final Duration _tickRate = const Duration(milliseconds: 50);

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _ticker = createTicker((elapsed) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(
          _scrollController.offset + _scrollSpeed,
        );
        if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent) {
          _scrollController.jumpTo(0);
        }
      }
    });

    // Start ticker with custom tick rate
    _ticker.start();
    Future.delayed(_tickRate, () {
      if (mounted && !_ticker.isTicking) {
        _ticker.start();
      }
    });
  }

  @override
  void dispose() {
    _ticker.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 39.w,
      child: ListView.builder(
        controller: _scrollController,
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
