import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/local_assets.dart';

class ConnectivityWrapper extends StatefulWidget {
  final Widget child;

  const ConnectivityWrapper({required this.child});

  @override
  _ConnectivityWrapperState createState() => _ConnectivityWrapperState();
}

class _ConnectivityWrapperState extends State<ConnectivityWrapper> {
  late Connectivity _connectivity;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool _isConnected = true;
  bool _isDialogShown = false;

  @override
  void initState() {
    super.initState();
    _connectivity = Connectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      setState(() {
        _isConnected = result != ConnectivityResult.none;
        if (_isConnected) {
          if (_isDialogShown) {
            Navigator.of(context).pop(); // Dismiss dialog if shown
            _isDialogShown = false;
          }
        } else {
          _isDialogShown = false; // Reset flag when connection is lost
        }
      });
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isConnected && !_isDialogShown) {
      _isDialogShown = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: SizedBox(
                    height: 300.h,
                    child: Center(
                        child:
                            LocalAssets(imagePath: AppImageAssets.noInternet))),
              );
            },
            barrierDismissible: false);
      });
    }

    return widget.child;
  }
}

/*

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/local_assets.dart';
import 'package:sanademy/view/general/no_internet_screen.dart';

class ConnectivityWrapper extends StatefulWidget {
  final Widget child;

  const ConnectivityWrapper({required this.child});

  @override
  _ConnectivityWrapperState createState() => _ConnectivityWrapperState();
}

class _ConnectivityWrapperState extends State<ConnectivityWrapper> {
  late Connectivity _connectivity;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

*/
/*  void showNoInternetDialog() {
    Get.defaultDialog(
      title: 'No Internet',
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: LocalAssets(imagePath: AppImageAssets.noInternet)),
        ],
      ),
      confirm: TextButton(
        onPressed: () {
          Get.back();
        },
        child: Text('OK'),
      ),
    );
  }*/ /*


  @override
  void initState() {
    super.initState();
    _connectivity = Connectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((result) {
      setState(() {});
    });
*/
/*    WidgetsBinding.instance.addPostFrameCallback((_) {
      showNoInternetDialog();
    });*/ /*

  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    return StreamBuilder<ConnectivityResult>(
      stream: _connectivity.onConnectivityChanged,
      builder: (context, snapshot) {
        if (snapshot.data == ConnectivityResult.none) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.defaultDialog(
              content: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: LocalAssets(imagePath: AppImageAssets.noInternet)),
                ],
              ),
            );
          });
          return const NoInterNetScreen(); // Return an empty widget
        } else {
          return widget.child;
        }
      },
    );
  }
}
*/
