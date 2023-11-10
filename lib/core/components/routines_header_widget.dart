import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:healthy_routine/core/app_colors.dart';
import 'package:healthy_routine/core/app_styles.dart';
import 'package:healthy_routine/core/components/reuseable_gap_widget.dart';
import 'package:healthy_routine/services/get_random_health_tips.dart';

import '../routings/routes_name.dart';

class RoutinesHeaderWidget extends StatelessWidget {
  final String title;
  const RoutinesHeaderWidget({
    required this.title,
    Key? key,
  }) : super(key: key);

  String getRandomEmoji(String greeting) {
    Map<String, List<String>> emojiMap = {
      'Good Morning': [
        '🌞',
        '🌅',
        '🌄',
        '🌇',
        '😃',
        '🌞',
        '🌤️',
        '🌼',
        '🌺',
        '🍳'
      ],
      'Good Afternoon': [
        '☀️',
        '🌇',
        '🌅',
        '🌞',
        '🌆',
        '🌤️',
        '🌴',
        '🍹',
        '🍔',
        '🌮'
      ],
      'Good Evening': [
        '🌙',
        '🌜',
        '🌃',
        '🌌',
        '🌛',
        '🌠',
        '🍵',
        '🌃',
        '🍷',
        '🌆'
      ],
      'Good Night': [
        '🌜',
        '🌛',
        '🌙',
        '🌃',
        '🌌',
        '🌚',
        '🌟',
        '🛌',
        '😴',
        '🌜'
      ],
    };

    List<String> emojis = emojiMap[greeting] ?? [];

    if (emojis.isNotEmpty) {
      // Select a random emoji from the list
      Random random = Random();
      int randomIndex = random.nextInt(emojis.length);
      return emojis[randomIndex];
    } else {
      // Default emoji if the greeting is not recognized
      return '❓';
    }
  }

  String getGreeting() {
    var hour = DateTime.now().hour;

    if (hour < 4) {
      return 'Good Night';
    } else if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else if (hour < 20) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  @override
  Widget build(BuildContext context) {
    var greeting = getGreeting();
    var timeOfDay = 'night';

    if (greeting == 'Good Morning') {
      timeOfDay = 'morning';
    } else if (greeting == 'Good Afternoon') {
      timeOfDay = 'midday';
    } else if (greeting == 'Good Evening') {
      timeOfDay = 'evening';
    }

    return Container(
      decoration: const ShapeDecoration(
        color: AppColors.kprimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(29),
            bottomRight: Radius.circular(29),
          ),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      height: MediaQuery.of(context).size.height / 4.5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              ReuseableGapWidget(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontFamily: AppStyles.appFontFamily,
                        fontSize: 22,
                        color: AppColors.kwhite),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (title == 'Flexible Routines') {
                          Navigator.pushNamed(
                              context, RoutesName.create_flexible_routine);
                        } else {
                          Navigator.pushNamed(
                              context, RoutesName.create_fixed_routine);
                        }
                      },
                      child: Text(
                        'Add New',
                        style: AppStyles.titleTextStyleprimarycolor,
                      ))
                ],
              ),
              ReuseableGapWidget(),
              Row(
                children: [
                  // DefaultTextStyle(
                  //   style: const TextStyle(
                  //       fontFamily: AppStyles.appFontFamily, fontSize: 22),
                  //   child: AnimatedTextKit(
                  //     animatedTexts: [
                  //       TyperAnimatedText(
                  //         '$greeting ${getRandomEmoji(greeting)}',
                  //       ),
                  //     ],
                  //     onTap: () {
                  //       print("Tap Event");
                  //     },
                  //   ),
                  // ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontFamily: AppStyles.appFontFamily,
                  ),
                  child: AnimatedTextKit(
                    pause: Duration(seconds: 3),
                    animatedTexts: [
                      TyperAnimatedText(getRandomHealthTip(timeOfDay),
                          curve: Curves.easeOutCubic),
                      TyperAnimatedText(getRandomHealthTip(timeOfDay),
                          curve: Curves.bounceInOut),
                      TyperAnimatedText(getRandomHealthTip(timeOfDay),
                          curve: Curves.fastOutSlowIn),
                      TyperAnimatedText(getRandomHealthTip(timeOfDay),
                          curve: Curves.decelerate),
                      TyperAnimatedText(getRandomHealthTip(timeOfDay),
                          curve: Curves.ease),
                      TyperAnimatedText(getRandomHealthTip(timeOfDay),
                          curve: Curves.linear),
                      TyperAnimatedText(getRandomHealthTip(timeOfDay),
                          curve: Curves.easeIn),
                      TyperAnimatedText(getRandomHealthTip(timeOfDay),
                          curve: Curves.easeInBack),
                      TyperAnimatedText(getRandomHealthTip(timeOfDay),
                          curve: Curves.easeInCirc),
                      TyperAnimatedText(getRandomHealthTip(timeOfDay),
                          curve: Curves.easeOutQuint),
                    ],
                    onTap: () {
                      print("Tap Event");
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
