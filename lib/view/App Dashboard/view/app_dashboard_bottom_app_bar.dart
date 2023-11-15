import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:healthy_routine/core/app_colors.dart';
import 'package:healthy_routine/core/app_strings.dart';
import 'package:healthy_routine/view/App%20Dashboard/view/todays_routine_screen.dart';
import 'package:healthy_routine/view/Fixed%20Routines/view/fixed_routine_dashboard.dart';
import 'package:healthy_routine/view/Flexible%20Routines/view/flexible_routines_dashboard.dart';

class AppDashboardBottomAppBar extends StatefulWidget {
  const AppDashboardBottomAppBar({super.key});

  @override
  State<AppDashboardBottomAppBar> createState() =>
      _AppDashboardBottomAppBarState();
}

class _AppDashboardBottomAppBarState extends State<AppDashboardBottomAppBar> {
  @override
  void initState() {
    // load();
    // TODO: implement initState
    super.initState();
  }

  // load() async {
    // await RoutineController.loadAndPrintRoutines();
  // }

  final ValueNotifier<int> currentIndex = ValueNotifier<int>(1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.zero,
        child: AppBar(
          backgroundColor: AppColors.kprimaryColor,
        ),
      ),
      // body: screens[index],
      body: ValueListenableBuilder<int>(
        valueListenable: currentIndex,
        builder: (context, index, _) {
          return screens[index];
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        items: buttons,
        index: currentIndex.value,
        height: MediaQuery.of(context).size.height / 14,
        color: AppColors.kprimaryColor,
        backgroundColor: Colors.transparent,
        // onTap: (index) => setState(() => this.index = index),
        onTap: (index) => currentIndex.value = index,
      ),
    );
  }

  final screens = [
    FixedRoutinesDashboard(),
    TodaysRoutineScreen(),
    FlexibleRoutinesDashboard()
  ];
  final buttons = <Widget>[
    Padding(
        padding: const EdgeInsets.all(4.0),
        child: Center(
            child: Image.asset(
          AppStrings.fixedRoutineIconPath,
          width: 35,
        ))),
    Padding(
      padding: const EdgeInsets.all(4.0),
      child: Icon(
        Icons.dashboard,
        color: AppColors.kwhite,
        size: 35,
      ),
    ),
    Padding(
        padding: const EdgeInsets.all(4.0),
        child: Center(
            child: Image.asset(
          AppStrings.flexibleRoutineIconPath,
          width: 35,
        ))),
  ];
}
