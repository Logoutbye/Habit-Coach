import 'package:flutter/material.dart';
import 'package:healthy_routine/core/app_colors.dart';

class AppStyles {
  static TextStyle titleTextStyleprimarycolor = const TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.kprimaryColor,
    fontFamily: 'Monospace',
  );
  static TextStyle titleTextStylewhitecolor = const TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.kwhite,
    fontFamily: 'Monospace',
  );
  static TextStyle tasktitleTextStyleblackcolor = const TextStyle(
    color: Color(0xFF4F4F4F),
    fontSize: 13,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    height: 0,
  );
  static TextStyle taskSubtitleTextStyleblackcolor = const TextStyle(
    color: Color(0xFF4F4F4F),
    fontSize: 10,
    fontFamily: 'Poppins',
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
