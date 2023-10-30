import 'package:flutter/material.dart';
import 'package:healthy_routine/core/app_styles.dart';

class ReUseAbleCreateButton extends StatelessWidget {
  final VoidCallback onTap;

  final String buttonTextTitle;

  const ReUseAbleCreateButton({
    required this.onTap,
    required this.buttonTextTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height / 15,
        decoration: ShapeDecoration(
          color: const Color(0xFF7FD8D8),
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFF7FD8D8)),
            borderRadius: BorderRadius.circular(10),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x0C006EE9),
              blurRadius: 20,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 6),
        margin: const EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 4),
        child: Center(
            child: Text(
          buttonTextTitle,
          style: AppStyles.titleTextStylewhitecolor,
        )),
      ),
    );
  }
}
