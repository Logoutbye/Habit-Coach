import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:healthy_routine/core/app_colors.dart';

class Utils {
  static showFlushbar(String message, BuildContext context) {
    Flushbar(
      message: message,
      // messageColor: AppColors.kblack,
      backgroundColor: AppColors.kgrey,
      duration: const Duration(seconds: 3),
      reverseAnimationCurve: Curves.easeInOut,
      forwardAnimationCurve: Curves.decelerate,
      // backgroundColor: AppConstants.kcgreenbgColor,
      padding: const EdgeInsets.all(12),
      maxWidth: MediaQuery.of(context).size.width / 1.1,
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(12),
      positionOffset: 20,
    ).show(context);
  }

  static showSuccessFlushbar(
      String title, String message, BuildContext context) {
    Flushbar(
      titleText: Text(
        title,
        style: const TextStyle(
            fontWeight: FontWeight.bold, color: AppColors.kblack),
      ),
      message: message,
      titleColor: AppColors.kblack,
      messageColor: AppColors.kblack,
      backgroundColor: AppColors.kprimaryDullColor,
      duration: const Duration(seconds: 3),
      reverseAnimationCurve: Curves.easeInOut,
      forwardAnimationCurve: Curves.decelerate,
      // backgroundColor: AppConstants.kcgreenbgColor,
      padding: const EdgeInsets.all(12),
      maxWidth: MediaQuery.of(context).size.width / 1.1,
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(12),
      positionOffset: 20,
    ).show(context);
  }
}
