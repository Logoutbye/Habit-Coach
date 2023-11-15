import 'package:flutter/material.dart';
import 'package:healthy_routine/core/app_colors.dart';
import 'package:healthy_routine/view/App%20Dashboard/widgets/today_routine_body_widget.dart';

import '../Widgets/todays_routine_header_widget.dart';

class TodaysRoutineScreen extends StatefulWidget {
  const TodaysRoutineScreen({super.key});

  @override
  State<TodaysRoutineScreen> createState() => _TodaysRoutineScreenState();
}

class _TodaysRoutineScreenState extends State<TodaysRoutineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.zero,
        child: AppBar(
          backgroundColor: AppColors.kprimaryColor,
        ),
      ),
      body: Column(
        children: [TodaysRoutineHeaderWidget(), TodayRoutineBodyWidget()],
      ),
    );
  }
}
