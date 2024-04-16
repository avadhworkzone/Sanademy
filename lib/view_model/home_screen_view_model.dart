import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenViewModel extends GetxController{

  Rx<TextEditingController> searchController = TextEditingController().obs;
  final GlobalKey<ScaffoldState> homeDrawerKey = GlobalKey();
}