import 'package:flutter/material.dart';
import 'package:healthy_routine/core/app_colors.dart';

import '../../../core/app_strings.dart';
import '../../../services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();
  @override
  void initState() {
    super.initState();
    splashServices.checkIfOnboardingShown(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kwhite,
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      body: Center(
          child:
              // FractionallySizedBox(
              //   widthFactor: 0.5, // Adjust as needed
              //   heightFactor: 0.5, // Adjust as needed
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              Image.asset(AppStrings.splashScreenPathImage)

          // SvgPicture.asset(
          //   AppStrings.splashScreenPath,
          //   fit: BoxFit.contain,
          // ),
          // Add other splash screen content here
          // ],
          // ),
          // ),
          ),
    );
  }
}
