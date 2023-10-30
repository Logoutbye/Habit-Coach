import 'package:flutter/material.dart';

// navigate to first screen
// navigatorKey.currentState!.popUntil((route) => route.isFirst);

class SlideTransitionPage extends PageRouteBuilder {
  final Widget page;
  final bool applySlideTransition;

  // Define a shorter default animation duration
  static const Duration defaultAnimationDuration = Duration(milliseconds: 200);

  SlideTransitionPage({
    required this.page,
    this.applySlideTransition = true,
    Duration transitionDuration =
        defaultAnimationDuration, // Set default duration
  }) : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            if (applySlideTransition) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOut, // Use a curve for smoother animation
                  reverseCurve: Curves
                      .easeIn, // Use a curve for smoother reverse animation
                )),
                child: child,
              );
            } else {
              return child;
            }
          },
          transitionDuration:
              transitionDuration, // Use the provided or default duration
        );
}




// slow one 

// class SlideTransitionPage extends PageRouteBuilder {
//   final Widget page;
//   final bool applySlideTransition;

//   SlideTransitionPage({required this.page, this.applySlideTransition = true})
//       : super(
//           pageBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//           ) =>
//               page,
//           transitionsBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//             Widget child,
//           ) {
//             if (applySlideTransition) {
//               return SlideTransition(
//                 position: Tween<Offset>(
//                   begin: const Offset(1.0, 0.0), // starting position
//                   end: Offset.zero, // ending position
//                 ).animate(animation),
//                 child: child,
//               );
//             } else {
//               return child;
//             }
//           },
//         );
// }
// call this way
//  Navigator.push(
//                           context,
//                           SlideTransitionPage(
//                               applySlideTransition: true, page: AboutScreen()));

