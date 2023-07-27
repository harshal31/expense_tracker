import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double fillHeight;
  final double totalExpense;

  const ChartBar(
      {super.key, required this.fillHeight, required this.totalExpense});

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 500),
      child: FractionallySizedBox(
        heightFactor: totalExpense == 0 ? 0 : fillHeight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)),
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
            ),
          ),
        ),
      ),
    );
  }
}
