
import 'package:flutter/material.dart';

class CreateFixedScreenIndicatorProvider extends ChangeNotifier {
  PageController controller = PageController();
  bool isFirstPage = true;
  bool isLastPage = false;

  void onPageChanged(int index) {
    isFirstPage = index == 0;
    isLastPage = index == 3;
    notifyListeners();
  }
}
