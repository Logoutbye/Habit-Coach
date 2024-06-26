import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthy_routine/core/app_colors.dart';
import 'package:healthy_routine/core/app_styles.dart';

class ReUseAbleTaskContainer extends StatelessWidget {
  final String title;
  final String subTitle;
  final String svgPath;

  const ReUseAbleTaskContainer({
    required this.title,
    required this.subTitle,
    required this.svgPath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 4),
        decoration: AppStyles.KContainerStyle,
        child: ListTile(
          leading: svgPath == 'digital'
              ? Icon(
                  Icons.computer,
                  color: AppColors.kprimaryColor,
                )
              : SvgPicture.asset(
                  svgPath,
                  color: AppColors.kprimaryColor,
                ),
          title: Text(title),
          titleTextStyle: AppStyles.tasktitleTextStyleblackcolor,
          subtitleTextStyle: AppStyles.taskSubtitleTextStyleblackcolor,
          subtitle: Text(subTitle),
        ));
  }
}
