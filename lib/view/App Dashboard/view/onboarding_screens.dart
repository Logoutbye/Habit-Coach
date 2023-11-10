import 'package:flutter/material.dart';
import 'package:healthy_routine/core/app_strings.dart';
import 'package:healthy_routine/view/App%20Dashboard/widgets/page_for_on_boarding_screen_widget.dart';
import 'package:provider/provider.dart';

import '../../../core/app_colors.dart';
import '../../../state/onboarding_screen__indicator_provider.dart';
import '../widgets/bottom_sheet_for_bording_screen_widget.dart';

class OnBoardingScreens extends StatefulWidget {
  const OnBoardingScreens({super.key});

  @override
  State<OnBoardingScreens> createState() => _OnBoardingScreensState();
}

class _OnBoardingScreensState extends State<OnBoardingScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kwhite,
      body: Stack(
        children: [
          PageView(
            controller: context.read<OnBoardingScreenIndicatorProvider>().controller,
            onPageChanged:
                context.read<OnBoardingScreenIndicatorProvider>().onPageChanged,
            children: const [
              PageForOnBoardingScreenWidget(
                imagePath: AppStrings.splashpath1,
              ),
              PageForOnBoardingScreenWidget(
                imagePath: AppStrings.splashpath2,
              ),
              PageForOnBoardingScreenWidget(
                imagePath: AppStrings.splashpath3,
              ),
            ],
          ),
        ],
      ),
      bottomSheet: BottomSheetForBordingScreenWidget(
        isLastPage: context.watch<OnBoardingScreenIndicatorProvider>().isLastPage,
        controller: context.read<OnBoardingScreenIndicatorProvider>().controller,
      ),
    );
  }
}
