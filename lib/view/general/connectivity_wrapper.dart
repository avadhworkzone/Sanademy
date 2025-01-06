
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/local_assets.dart';


/// both time work
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
  bool _isDialogShown = false;
  bool _handleBackButton = false;

  @override
  void initState() {
    super.initState();
    _connectivity = Connectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((result) {
      setState(() {
        _isConnected = result != ConnectivityResult.none;
        if (!_isConnected && !_isDialogShown) {
          _isDialogShown = true;
          _handleBackButton = true;
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return WillPopScope(
                onWillPop: () async => false,
                child: AlertDialog(
                  content: SizedBox(
                    height: 300.h,
                    child: Center(child: LocalAssets(imagePath: AppImageAssets.noInternet)),
                  ),
                ),
              );
            },
            barrierDismissible: false,
          );
        } else if (_isConnected && _isDialogShown) {
          Navigator.of(context).pop();
          _isDialogShown = false;
          _handleBackButton = false;
        }
      });
    }) ;

    _checkInitialConnectivity();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  void _checkInitialConnectivity() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    setState(() {
      _isConnected = connectivityResult != ConnectivityResult.none;
      if (!_isConnected && !_isDialogShown) {
        _isDialogShown = true;
        _handleBackButton = false;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                content: SizedBox(
                  height: 300.h,
                  child: const Center(child: LocalAssets(imagePath: AppImageAssets.noInternet)),
                ),
              ),
            );
          },
          barrierDismissible: false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_handleBackButton) {
          return false;
        }
        return true;
      },
      child: widget.child,
    );
  }
}




