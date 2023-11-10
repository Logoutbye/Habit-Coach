import 'package:flutter/material.dart';

class OnBoardingScreenIndicatorProvider extends ChangeNotifier {
  PageController controller = PageController();
  bool isFirstPage = true;
  bool isLastPage = false;

  void onPageChanged(int index) {
    isFirstPage = index == 0;
    isLastPage = index == 2;
    notifyListeners();
  }
}
