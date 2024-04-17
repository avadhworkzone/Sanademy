import 'package:flutter/material.dart';
import 'package:sanademy/commonWidget/custom_text_cm.dart';
import 'package:sanademy/utils/app_string.dart';

class SolutionsScreen extends StatefulWidget {
  const SolutionsScreen({super.key});

  @override
  State<SolutionsScreen> createState() => _SolutionsScreenState();
}

class _SolutionsScreenState extends State<SolutionsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Column(
          children: [CustomText(AppStrings.solution)],
        ),
      ),
    );
  }
}
