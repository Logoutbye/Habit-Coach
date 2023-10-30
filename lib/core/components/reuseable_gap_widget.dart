import 'package:flutter/material.dart';

class ReuseableGapWidget extends StatelessWidget {
  const ReuseableGapWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.transparent,
      height: MediaQuery.of(context).size.height / 50,
    );
  }
}
