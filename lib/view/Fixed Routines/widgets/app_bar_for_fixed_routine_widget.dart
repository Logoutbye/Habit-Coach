
import 'package:flutter/material.dart';
import 'package:healthy_routine/core/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AppBarForFixedRoutineWidget extends StatelessWidget {
  const AppBarForFixedRoutineWidget({
    super.key,
    // required this.isLastPage,
    required this.controller,
  });

  // final bool isLastPage;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.kprimaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      height: 80,
      child: Row(
        children: [
         
          const Spacer(),
          Center(
            child: SmoothPageIndicator(
                    controller: controller,
                    count: 4,
                    effect: const ExpandingDotsEffect(
                        activeDotColor: AppColors.kwhite,
                        dotColor: AppColors.kwhite),
                    onDotClicked: (index) => controller.animateToPage(index,
                        duration: const Duration(microseconds: 500),
                        curve: Curves.easeIn),
                  ),
          ),
          const Spacer(),
       ],
      ),
    );
  }
}
