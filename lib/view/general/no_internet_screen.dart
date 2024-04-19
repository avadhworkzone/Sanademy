import 'package:flutter/material.dart';
import 'package:sanademy/utils/app_image_assets.dart';
import 'package:sanademy/utils/local_assets.dart';

class NoInterNetScreen extends StatefulWidget {
  const NoInterNetScreen({Key? key}) : super(key: key);

  @override
  State<NoInterNetScreen> createState() => _NoInterNetScreenState();
}

class _NoInterNetScreenState extends State<NoInterNetScreen> {
  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Column(
        children: [
          Expanded(child: LocalAssets(imagePath: AppImageAssets.noInternet)),
        ],
      ),
    );
  }
}
