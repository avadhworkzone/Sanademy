import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/commonWidget/custom_btn.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/local_assets.dart';

class ConnectivityWrapper extends StatefulWidget {
  final Widget child;

  const ConnectivityWrapper({super.key, required this.child});

  @override
  _ConnectivityWrapperState createState() => _ConnectivityWrapperState();
}

class _ConnectivityWrapperState extends State<ConnectivityWrapper> {
  late Connectivity _connectivity;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool _isConnected = true;
  bool _isBottomSheetShown = false;
  int _counter = 5; // Countdown timer
  Timer? _timer; // Timer for countdown loop (nullable)

  @override
  void initState() {
    super.initState();
    _connectivity = Connectivity();

    // Listen to connectivity changes
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      _handleConnectivityChange(result);
    });

    _checkInitialConnectivity(); // Check connectivity on app start
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    _timer?.cancel(); // Cancel the timer only if it is active
    super.dispose();
  }

  // Check the initial connectivity when the app starts
  void _checkInitialConnectivity() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    _handleConnectivityChange(connectivityResult);
  }

  // Handle connectivity changes
  void _handleConnectivityChange(ConnectivityResult result) {
    setState(() {
      _isConnected = result != ConnectivityResult.none;
      if (!_isConnected && !_isBottomSheetShown) {
        _isBottomSheetShown = true;
        _startCountdown(); // Start countdown when disconnected
        _showNoInternetBottomSheet();
      } else if (_isConnected && _isBottomSheetShown) {
        Navigator.of(context).pop(); // Close the bottom sheet when connected
        _isBottomSheetShown = false;
      }
    });
  }

  // Start the countdown timer
  void _startCountdown() {
    _counter = 5; // Reset counter to 5 seconds
    _timer?.cancel(); // Cancel any existing timer before starting a new one
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        setState(() {
          _counter--;
        });
      } else {
        _checkConnection(); // Check connection after countdown ends
      }
    });
  }

  // Check the connection after countdown
  void _checkConnection() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    setState(() {
      _isConnected = connectivityResult != ConnectivityResult.none;
      if (_isConnected) {
        Get.back();
        // Navigator.of(context).pop(); // Close bottom sheet if connected
        _isBottomSheetShown = false;
      } else {
        _counter = 5; // Reset countdown if still disconnected
        _startCountdown(); // Restart countdown
      }
    });
  }

  // Show the "No Internet" bottom sheet
  void _showNoInternetBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            _counter = 5; // Reset counter to 5 seconds
            _timer
                ?.cancel(); // Cancel any existing timer before starting a new one
            _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
              if (_counter > 0) {
                setState(() {
                  _counter--;
                });
              } else {
                _checkConnection(); // Check connection after countdown ends
              }
            });
            return WillPopScope(
              onWillPop: () async {
                return true; // Allow back button to close the bottom sheet
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.70,
                width: Get.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                    top: 20.h,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
                  ),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LocalAssets(
                        imagePath: AppImageAssets.wifiImage,
                        // height: 70.h,
                        scaleSize: 8.h,
                      ), // Custom icon (wifi image)
                      SizedBox(height: 50.h),
                      CustomText(
                        textAlign: TextAlign.center,
                        AppStrings.internetConnectionNotAvailable,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(height: 150.h),
                      CustomText(
                        "${AppStrings.retryingIn} $_counter",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 20.h),
                      CustomUpdateBtn(
                        width: 400.w,
                        onTap: _checkConnection,
                        title: AppStrings.retryNow,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
