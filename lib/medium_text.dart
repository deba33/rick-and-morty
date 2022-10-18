import 'package:flutter/material.dart';

class MediumText extends StatelessWidget {
  final String text;
  const MediumText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textScaleFactor: 1.2,
    );
  }
}
