import 'package:flutter/material.dart';
import 'package:rick_n_morty/medium_text.dart';

class OptionContainer extends StatelessWidget {
  final Color optionColor;
  final String optionText;
  const OptionContainer({
    super.key,
    required this.optionColor,
    required this.optionText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: optionColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 11,
            backgroundColor: (optionText == 'Alive')
                ? Colors.green
                : (optionText == 'Dead')
                    ? Colors.red
                    : Colors.grey,
            child: const CircleAvatar(
              radius: 5,
              backgroundColor: Colors.white,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          MediumText(text: optionText),
        ],
      ),
    );
  }
}
