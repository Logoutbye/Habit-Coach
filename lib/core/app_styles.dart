import 'package:flutter/material.dart';
import 'package:healthy_routine/core/app_colors.dart';

class AppStyles {
  static const appFontFamily = 'Nunito';

  static TextStyle titleTextStyleprimarycolor = const TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.kprimaryColor,
    fontFamily: AppStyles.appFontFamily,
  );
  static TextStyle titleTextStyleofCreateScreen = const TextStyle(
    color: AppColors.kblack,
    fontSize: 13,
    fontFamily: AppStyles.appFontFamily,
    fontWeight: FontWeight.w500,
  );
  static TextStyle headingTextStyleBlack = const TextStyle(
    color: AppColors.kblack,
    fontSize: 16,
    fontFamily: AppStyles.appFontFamily,
    fontWeight: FontWeight.w700,
    height: 0,
  );
  static TextStyle titleTextStylewhitecolor = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 13,
    color: AppColors.kwhite,
    fontFamily: AppStyles.appFontFamily,
  );
  static TextStyle tasktitleTextStyleblackcolor = const TextStyle(
    color: Color(0xFF4F4F4F),
    fontSize: 13,
    fontFamily: AppStyles.appFontFamily,
    fontWeight: FontWeight.w600,
    height: 0,
  );
  static TextStyle taskSubtitleTextStyleblackcolor = const TextStyle(
    color: Color(0xFF4A4646),
    fontSize: 12,
    fontFamily: AppStyles.appFontFamily,
    fontWeight: FontWeight.w400,
    height: 0,
  );

  static TextStyle weekDaysTextPrimarycolor = const TextStyle(
    color: AppColors.kprimaryColor,
    fontSize: 13,
    fontFamily: AppStyles.appFontFamily,
    fontWeight: FontWeight.w500,
    height: 0,
  );
  static TextStyle weekDaysTextGreycolor = const TextStyle(
    color: AppColors.kgrey,
    fontSize: 13,
    fontFamily: AppStyles.appFontFamily,
    fontWeight: FontWeight.w500,
    height: 0,
  );
  static List<BoxShadow> kShadows = [
    const BoxShadow(
      color: Color(0x3F000000),
      blurRadius: 4,
      offset: Offset(0, 4),
      spreadRadius: 0,
    )
  ];

  static ShapeDecoration KContainerStyle = ShapeDecoration(
      color: AppColors.kwhite,
      shadows: kShadows,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ));
}
