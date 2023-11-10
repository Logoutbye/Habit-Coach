import 'package:flutter/material.dart';
import 'package:healthy_routine/core/app_strings.dart';
import 'package:healthy_routine/core/app_styles.dart';
import 'package:healthy_routine/core/components/reuseable_gap_widget.dart';
import 'package:healthy_routine/core/routings/routes_name.dart';
import '../../../core/app_colors.dart';

// class floatingActionWidget extends StatelessWidget {
//   const floatingActionWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return FloatingActionButton(
//       tooltip: 'Make Your Schedule',
//       backgroundColor: AppColors.kprimaryColor,
//       child: const Icon(
//         Icons.add,
//         color: AppColors.kwhite,
//       ),
//       onPressed: () {
//         showModalBottomSheet(
//           context: context,
//           builder: (context) => const BottomModelSheetWidget(),
//         );
//       },
//     );
//   }
// }

class RoutineCreationBottomModelSheetWidget extends StatefulWidget {
  const RoutineCreationBottomModelSheetWidget({super.key});

  @override
  _RoutineCreationBottomModelSheetWidgetState createState() => _RoutineCreationBottomModelSheetWidgetState();
}

class _RoutineCreationBottomModelSheetWidgetState extends State<RoutineCreationBottomModelSheetWidget> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            height: height / 120,
            width: width / 8,
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            decoration: BoxDecoration(
              color: AppColors.kprimaryDullColor,
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          // Content
          Text(
            'Create Routines',
            style: AppStyles.titleTextStyleprimarycolor,
          ),
          ReuseableGapWidget(),
          ReuseableGapWidget(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, RoutesName.create_fixed_routine);
                },
                child: Column(
                  children: [
                    Image.asset(
                      AppStrings.fixedRoutineIconPath,
                      color: AppColors.kprimaryColor,
                      height: MediaQuery.of(context).size.height / 18,
                    ),
                    Text(
                      'Fixed Routine',
                      style: AppStyles.weekDaysTextPrimarycolor,
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                      context, RoutesName.create_flexible_routine);
                },
                child: Column(
                  children: [
                    Image.asset(
                      AppStrings.flexibleRoutineIconPath,
                      color: AppColors.kprimaryColor,
                      height: MediaQuery.of(context).size.height / 18,
                    ),
                    Text(
                      'Flexible Routine',
                      style: AppStyles.weekDaysTextPrimarycolor,
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: height / 15,
          )
        ],
      ),
    );
  }
}
