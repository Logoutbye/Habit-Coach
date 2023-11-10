import 'package:flutter/material.dart';
import 'package:healthy_routine/core/app_colors.dart';
import 'package:healthy_routine/state/create_fixed_routine_indicator_provider.dart';
import 'package:healthy_routine/view/Fixed%20Routines/view/create_fixed_night_routine_screen.dart';
import 'package:healthy_routine/view/App%20Dashboard/Widgets/bottom_sheet_for_bording_screen_widget.dart';
import 'package:provider/provider.dart';

import 'create_fixed_day_routine_screen.dart';
import 'create_fixed_evening_routine_screen.dart';
import 'create_fixed_morining_routine_screen.dart';

class CreateFixedRoutineDashboard extends StatefulWidget {
  const CreateFixedRoutineDashboard({super.key});

  @override
  State<CreateFixedRoutineDashboard> createState() =>
      _CreateFixedRoutineDashboardState();
}

class _CreateFixedRoutineDashboardState
    extends State<CreateFixedRoutineDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppBarForFixedRoutineWidget(
          controller: context.read<CreateFixedScreenIndicatorProvider>().controller,
        ),
        backgroundColor: AppColors.kprimaryColor,
        foregroundColor: AppColors.kwhite,
      ),
      body: Stack(
        children: [
          PageView(
            controller: context.read<CreateFixedScreenIndicatorProvider>().controller,
            children: const [
              CreateFixedMoriningRoutineScreen(),
              CreateFixedDayRoutineScreen(),
              CreateFixedEveningRoutineScreen(),
              CreateFixedNightRoutineScreen(),
            ],
          )
        ],
      ),
    );
  }
}
