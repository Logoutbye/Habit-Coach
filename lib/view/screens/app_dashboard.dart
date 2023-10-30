import 'package:flutter/material.dart';
import 'package:healthy_routine/core/app_colors.dart';
import 'package:healthy_routine/view/widgets/app_dashboard_body_widget.dart';
import 'package:healthy_routine/view/widgets/floating_action_widget.dart';

class AppDashboard extends StatelessWidget {
  const AppDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kprimaryColor,
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 5.5,
            width: double.infinity,
            color: AppColors.kprimaryColor,
            child: const Center(
              child: Text('Content Here'),
            ),
          ),
          const AppDashBoardBodyWidget(),
        ],
      ),
      floatingActionButton: const floatingActionWidget(),
    );
  }
}
