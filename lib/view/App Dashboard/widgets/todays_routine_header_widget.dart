import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:healthy_routine/core/app_colors.dart';
import 'package:healthy_routine/core/components/reuseable_gap_widget.dart';
import 'package:healthy_routine/view/App%20Dashboard/Widgets/routine_creation_bottom_model_sheet_widget.dart';

import '../../../core/app_styles.dart';

class TodaysRoutineHeaderWidget extends StatelessWidget {
  const TodaysRoutineHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var greeting = getGreeting();
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
      height: MediaQuery.of(context).size.height / 7.5,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            children: [
              ReuseableGapWidget(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Today\'s Routines',
                    style: const TextStyle(
                        fontFamily: AppStyles.appFontFamily,
                        fontSize: 18,
                        color: AppColors.kwhite),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) =>
                              const RoutineCreationBottomModelSheetWidget(),
                        );
                      },
                      child: Text(
                        'Add New',
                        style: AppStyles.titleTextStyleprimarycolor,
                      ))
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DefaultTextStyle(
                    style: const TextStyle(
                        fontFamily: AppStyles.appFontFamily, fontSize: 18),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText(
                            '$greeting ${getRandomEmoji(greeting)}'),
                      ],
                      onTap: () {
                        print("Tap Event");
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
}
