import 'package:flutter/material.dart';

class OnBoardingScreenState extends ChangeNotifier {
  PageController controller = PageController();
  bool isFirstPage = true;
  bool isLastPage = false;

  void onPageChanged(int index) {
    isFirstPage = index == 0;
    isLastPage = index == 2;
    notifyListeners();
  }
}

class CreateFixedScreenState extends ChangeNotifier {
  PageController controller = PageController();
  bool isFirstPage = true;
  bool isLastPage = false;

  void onPageChanged(int index) {
    isFirstPage = index == 0;
    isLastPage = index == 2;
    notifyListeners();
  }
}
