// import 'package:flutter/material.dart';
// import 'package:healthy_routine/core/app_colors.dart';
// import 'package:healthy_routine/core/components/reuseable_gap_widget.dart';
// import 'package:healthy_routine/view/state/schedule_provider.dart';
// import 'package:provider/provider.dart';

// import '../../core/app_styles.dart';

// class BuildRoutineWidget extends StatelessWidget {
//   const BuildRoutineWidget({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var scheduleProvider = Provider.of<ScheduleProvider>(context);

//     return GestureDetector(
//       onTap: () {
//         scheduleProvider.collapseAll();
//       },
//       child: ListView.builder(
//         physics: AlwaysScrollableScrollPhysics(),
//         itemCount: scheduleProvider.schedules.length,
//         itemBuilder: (context, index) {
//           return Column(
//             children: [
//               const ReuseableGapWidget(),
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(16),
//                 margin: const EdgeInsets.only(left: 16, right: 16),
//                 decoration: AppStyles.KContainerStyle,
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           constraints: BoxConstraints(
//                             maxWidth: MediaQuery.of(context).size.width / 1.7,
//                           ),
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 18, vertical: 8),
//                           decoration: ShapeDecoration(
//                             color: AppColors.kprimaryColor,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(18),
//                             ),
//                           ),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 scheduleProvider.schedules[index]['taskName'],
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 10,
//                                   fontFamily: 'Poppins',
//                                   fontWeight: FontWeight.w600,
//                                   height: 0,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             IconButton(
//                               onPressed: () {},
//                               icon: Icon(
//                                 scheduleProvider.schedules[index]['alerts'] ==
//                                         true
//                                     ? Icons.notifications_on
//                                     : Icons.notifications_off,
//                                 color: AppColors.kprimaryColor,
//                               ),
//                             ),
//                             IconButton(
//                               onPressed: () {
//                                 scheduleProvider.toggleExpansion(index);
//                               },
//                               icon: const Icon(
//                                 Icons.arrow_drop_down_circle,
//                                 color: AppColors.kprimaryColor,
//                               ),
//                             )
//                           ],
//                         )
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           constraints: BoxConstraints(
//                             maxWidth: MediaQuery.of(context).size.width / 1.8,
//                           ),
//                           padding: const EdgeInsets.symmetric(vertical: 8),
//                           child: Text(
//                             scheduleProvider.schedules[index]['description'],
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: 12, top: 8),
//                           child: Text(
//                               scheduleProvider.schedules[index]['weekDays']),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               if (scheduleProvider.isExpandedList[index])
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.only(left: 16, right: 16),
//                   margin: const EdgeInsets.only(left: 16, right: 16),
//                   child: Theme(
//                     data: Theme.of(context).copyWith(
//                       dividerColor:
//                           Colors.transparent, // Color of the divider lines
//                     ),
//                     child: ExpansionTile(
//                       initiallyExpanded: true,
//                       collapsedIconColor: AppColors.kgrey,
//                       collapsedBackgroundColor: Colors.transparent,
//                       title: const Text(
//                         'Task',
//                         style: TextStyle(
//                           color: AppColors.kgrey,
//                           fontSize: 14,
//                           fontFamily: 'Poppins',
//                           fontWeight: FontWeight.w500,
//                           height: 0,
//                         ),
//                       ),
//                       children: List.generate(
//                         scheduleProvider.schedules[index]['todos'].length,
//                         (todoIndex) {
//                           var todo = scheduleProvider.schedules[index]['todos']
//                               [todoIndex];
//                           return Row(
//                             children: [
//                               Text(
//                                 '${todoIndex + 1}',
//                                 style: AppStyles.tasktitleTextStyleblackcolor,
//                               ),
//                               Container(
//                                   // width: 193,
//                                   // height: 63,
//                                   margin: EdgeInsets.all(8),
//                                   padding: EdgeInsets.all(8),
//                                   decoration: ShapeDecoration(
//                                     color: AppColors.kprimaryColor,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(16),
//                                     ),
//                                   ),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         '${todo['todoName']}',
//                                         style:
//                                             AppStyles.titleTextStylewhitecolor,
//                                       ),
//                                       Text(
//                                         '${todo['time']}',
//                                         style:
//                                             AppStyles.titleTextStylewhitecolor,
//                                       ),
//                                     ],
//                                   )),
//                             ],
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
