import 'package:first_expense_tracker/models/expense.dart';
import 'package:first_expense_tracker/widgets/charts/chart_bar.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;

  List<ExpenseBucket> get expensesBucket {
    return [
      ExpenseBucket.forEachCategory(expenses, Category.food),
      ExpenseBucket.forEachCategory(expenses, Category.leisure),
      ExpenseBucket.forEachCategory(expenses, Category.travel),
      ExpenseBucket.forEachCategory(expenses, Category.work)
    ];
  }

  double getMaxFillFactor() {
    var max = 0.0;
    for (final expense in expensesBucket) {
      if (expense.getTotalExpense() > max) {
        max = expense.getTotalExpense();
      }
    }
    return max;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0),
          ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
          borderRadius: BorderRadius.circular(16.0),
        ),
        width: double.infinity,
        height: expenses.isEmpty
            ? 0
            : (MediaQuery.of(context).size.longestSide / 3.8),
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ...expensesBucket.map(
                    (e) {
                      final fill = e.getTotalExpense() / getMaxFillFactor();
                      return Expanded(
                        child: ChartBar(
                          fillHeight: fill,
                          totalExpense: e.getTotalExpense(),
                        ),
                      );
                    },
                  ).toList()
                ],
              ),
            ),
            Row(
              children: [
                ...expensesBucket
                    .map((bucket) => Expanded(
                          child: Icon(
                            categoryIcons[bucket.category],
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.6),
                          ),
                        ))
                    .toList()
              ],
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
