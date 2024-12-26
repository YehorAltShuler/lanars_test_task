import 'package:flutter/material.dart';

class LetterHeader extends StatelessWidget {
  final String letter;

  const LetterHeader({
    super.key,
    required this.letter,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 16),
        Container(
          width: 12,
          alignment: Alignment.center,
          child: Text(
            letter,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
      ],
    );
  }
}
