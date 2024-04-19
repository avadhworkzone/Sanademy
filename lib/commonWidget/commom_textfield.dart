import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanademy/utils/app_colors.dart';
import 'package:sanademy/utils/app_constant.dart';
import 'package:sanademy/utils/app_string.dart';
import 'package:sanademy/utils/regex.dart';

import '../utils/app_enum.dart';

typedef OnChangeString = void Function(String value);

class CommonTextField extends StatelessWidget {
  final TextEditingController? textEditController;
  final String? title;
  final String? initialValue;
  final bool? isValidate;
  final bool? readOnly;
  final TextInputType? keyBoardType;
  final ValidationTypeEnum? validationType;
  final String regularExpression;
  final int? inputLength;
  final String? hintText;
  final String? validationMessage;
  final String? preFixIconPath;
  final int? maxLine;
  final int? maxLength;
  final Widget? sIcon;
  final Widget? pIcon;
  final bool? obscureValue;
  final bool? isCapitalize;
  final bool? underLineBorder;
  final bool? showLabel;
  final OnChangeString? onChange;
  final VoidCallback? onTap;
  final Color? borderColor;
  final Color? hintTextColor;
  final Color? fillColor;
  final double? borderWidth;
  final FontWeight? hintFontWeight;
  final EdgeInsetsGeometry? contentPadding;
  final String? Function(String?)? validator;
  final TextStyle? style;
  final Color? cursorColor;
  final TextInputAction? textInputAction;

  const CommonTextField({
    super.key,
    this.validator,
    required this.regularExpression,
    this.title,
    this.textEditController,
    this.isValidate = true,
    this.isCapitalize = false,
    this.keyBoardType,
    this.validationType,
    this.inputLength,
    this.readOnly = false,
    this.underLineBorder = false,
    this.showLabel = false,
    this.hintText,
    this.validationMessage,
    this.maxLine,
    this.sIcon,
    this.pIcon,
    this.maxLength,
    this.preFixIconPath,
    this.onChange,
    this.initialValue = '',
    this.obscureValue,
    this.onTap,
    this.borderColor,
    this.hintTextColor,
    this.fillColor,
    this.borderWidth,
    this.hintFontWeight,
    this.contentPadding,
    this.style,
    this.cursorColor,
    this.textInputAction,
  });

  /// PLEASE IMPORT GET X PACKAGE
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: TextFormField(
        controller: textEditController,
        maxLength: maxLength,
        style: style ??
            TextStyle(
                fontSize: 14.sp,
                color: AppColors.black,
                fontFamily: AppConstants.quicksand,
                fontWeight: FontWeight.w400),
        /*?? underLineBorder!
            ? CustomTextStyle.textStyleInputField
            .copyWith(color: AppColors.black)
            : CustomTextStyle.textStyleInputField,*/
        keyboardType: keyBoardType ?? TextInputType.text,
        maxLines: maxLine ?? 1,
        textCapitalization: isCapitalize!
            ? TextCapitalization.characters
            : TextCapitalization.sentences,
        inputFormatters: [
          LengthLimitingTextInputFormatter(inputLength),
          FilteringTextInputFormatter.allow(RegExp(regularExpression.tr)),
          NoLeadingSpaceFormatter(),
        ],
        obscureText: validationType == ValidationTypeEnum.password
            ? obscureValue!
            : false,
        onChanged: onChange,
        enabled: !readOnly!,
        readOnly: readOnly!,
        validator: (value) {
          return isValidate == false
              ? null
              : value!.isEmpty
                  ? validationMessage?.tr ?? AppStrings.isRequired.tr
                  : validationType == ValidationTypeEnum.email
                      ? ValidationMethod.validateEmail(value)
                      : validationType == ValidationTypeEnum.name
                          ? ValidationMethod.validateName(value)
                          : validationType == ValidationTypeEnum.address
                              ? ValidationMethod.validateAddress(value)
                              : null;
        },
        textInputAction: textInputAction,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        cursorColor: cursorColor ?? AppColors.black,
        decoration: InputDecoration(
          isDense: true,
          fillColor: fillColor ?? AppColors.white,
          filled: true,
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(horizontal: 15.w, vertical: 17.h),
          hintText: hintText!.tr,
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.red),
              borderRadius: BorderRadius.circular(10.r)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                  color: borderColor ?? AppColors.black.withOpacity(0.10))),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: borderWidth ?? 1.0,
                color: borderColor ?? AppColors.black.withOpacity(0.10)),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: borderWidth ?? 1.0,
                color: borderColor ?? AppColors.black.withOpacity(0.10)),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: borderColor ?? AppColors.black.withOpacity(0.10),
              width: borderWidth ?? 1.0,
            ),
          ),
          prefixIcon: pIcon,
          suffixIcon: sIcon,
          counterText: ''.tr,
          // filled: true,
          // fillColor: ColorUtils.greyE7,
          labelStyle: TextStyle(
              fontSize: 14.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w600),
          hintStyle: TextStyle(
            color: hintTextColor ?? AppColors.black12,
            fontSize: 14.sp,
            fontFamily: AppConstants.quicksand,
            fontWeight: hintFontWeight ?? FontWeight.normal,
          ),
          errorMaxLines: 2,
        ),
      ),
    );
  }
}
