import 'package:flutter/material.dart';
import 'package:healthy_routine/core/app_colors.dart';
import 'package:healthy_routine/services/splash_services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BottomModelSheetForBordingScreenWidget extends StatelessWidget {
  const BottomModelSheetForBordingScreenWidget({
    super.key,
    required this.isLastPage,
    required this.controller,
  });

  final bool isLastPage;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.kwhite,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      height: 80,
      child: Row(
        children: [
          isLastPage
              ? Container(
                  // decoration: BoxDecoration(
                  //     color: MyColors.kGreyColor,
                  //     borderRadius: BorderRadius.circular(70)),
                  child: TextButton(
                      onPressed: () {
                        controller.previousPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                      },
                      child: const Text(
                        'Back',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      )),
                )
              : const SizedBox(),
          const Spacer(),
          Center(
            child: isLastPage
                ? const SizedBox()
                : SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    effect: const ExpandingDotsEffect(
                        activeDotColor: AppColors.kprimaryColor,
                        dotColor: AppColors.kprimaryColor),
                    onDotClicked: (index) => controller.animateToPage(index,
                        duration: const Duration(microseconds: 500),
                        curve: Curves.easeIn),
                  ),
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
                color: AppColors.kprimaryColor,
                borderRadius: BorderRadius.circular(70)),
            child: isLastPage
                ? TextButton(
                    onPressed: () async {
                      controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                      await SplashServices().saveToken(true, context);
                    },
                    child: const Text(
                      'Get Started',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: AppColors.kwhite),
                    ))
                : IconButton(
                    onPressed: () {
                      controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    },
                    icon: const Icon(
                      Icons.arrow_forward_outlined,
                      color: AppColors.kwhite,
                    )),
          )
        ],
      ),
    );
  }
}
