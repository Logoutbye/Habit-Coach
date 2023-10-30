import 'package:flutter/material.dart';
import 'package:healthy_routine/core/app_strings.dart';
import 'package:healthy_routine/view/widgets/page_for_on_boarding_screen_widget.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';
import '../state/onboarding_screen_state.dart';
import '../widgets/bottom_model_sheet_for_bording_screen_widget.dart';

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
          Container(
            child: PageView(
              controller: context.read<OnBoardingScreenState>().controller,
              onPageChanged:
                  context.read<OnBoardingScreenState>().onPageChanged,
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
          ),
        ],
      ),
      bottomSheet: BottomModelSheetForBordingScreenWidget(
        isLastPage: context.watch<OnBoardingScreenState>().isLastPage,
        controller: context.read<OnBoardingScreenState>().controller,
      ),
    );
  }
}
