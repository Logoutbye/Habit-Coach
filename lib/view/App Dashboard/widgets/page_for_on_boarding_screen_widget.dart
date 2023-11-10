import 'package:flutter/material.dart';

class PageForOnBoardingScreenWidget extends StatelessWidget {
  final String imagePath;

  const PageForOnBoardingScreenWidget({
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imagePath),
            ]),
      ],
    );
  }
}
