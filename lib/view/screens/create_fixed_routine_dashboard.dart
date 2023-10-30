import 'package:flutter/material.dart';
import 'package:healthy_routine/core/app_colors.dart';
import 'package:healthy_routine/core/app_styles.dart';
import 'package:healthy_routine/view/screens/create_fixed_evening_routine_screen.dart';
import 'package:healthy_routine/view/screens/create_fixed_day_routine_screen.dart';
import 'package:healthy_routine/view/screens/create_fixed_morining_routine_screen.dart';
import 'package:healthy_routine/view/screens/create_fixed_night_routine_screen.dart';
import 'package:provider/provider.dart';

import '../state/onboarding_screen_state.dart';

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
        title:const Text(
          'Recommended',
        ),
        centerTitle: true,
        backgroundColor: AppColors.kprimaryColor,
        foregroundColor: AppColors.kwhite,
      ),
      body: Stack(
        children: [
          PageView(
            controller: context.read<CreateFixedScreenState>().controller,
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
