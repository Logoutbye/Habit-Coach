import 'package:flutter/material.dart';
import 'package:healthy_routine/core/app_colors.dart';

class AppDashboardTabbarButtons extends StatelessWidget {
  const AppDashboardTabbarButtons({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 3),
      child: TabBar(
        dividerColor: Colors.transparent,
        controller: _tabController,
        unselectedLabelColor: AppColors.kblack,
        labelStyle: const TextStyle(fontSize: 10),
        labelColor: AppColors.kwhite,
        indicator: ShapeDecoration(
          color: AppColors.kprimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: const [
          Tab(
            // child: Text('Morning'),
            text: 'Morining',
          ),
          Tab(
            // child: Text('Midday'),
            text: 'Midday',
          ),
          Tab(
            // child: Text('Afternoon'),
            text: 'Afternoon',
          ),
          Tab(
            // child: Text('Evening'),
            text: 'Evening',
          ),
          Tab(
            // child: Text('Night'),
            text: 'Night',
          ),
        ],
      ),
    );
  }
}
