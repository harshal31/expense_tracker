import 'package:first_expense_tracker/models/expense.dart';
import 'package:first_expense_tracker/widgets/expenses/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatefulWidget {
  final List<Expense> expenses;
  final void Function(Expense expense) removeExpense;

  const ExpensesList(
      {super.key, required this.expenses, required this.removeExpense});

  @override
  State<ExpensesList> createState() => _ExpenseState();
}

class _ExpenseState extends State<ExpensesList> {
  bool _isReached = false;
  DismissDirection? _dismissDirection;

  @override
  Widget build(BuildContext context) {
    var backgroundColor = _isReached
        ? Theme.of(context).colorScheme.error.withOpacity(0.5)
        : Colors.green.withOpacity(0.5);

    return ListView.builder(
      itemCount: widget.expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        resizeDuration: const Duration(milliseconds: 400),
        movementDuration: const Duration(milliseconds: 400),
        background: Container(
          alignment: (_dismissDirection == null ||
                  _dismissDirection == DismissDirection.startToEnd
              ? Alignment.centerLeft
              : Alignment.centerRight),
          margin: Theme.of(context).cardTheme.margin,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: backgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) =>
                  ScaleTransition(scale: animation, child: child),
              child: Icon(
                _isReached ? Icons.delete_outline : Icons.save_alt_outlined,
                key: ValueKey(_isReached),
              ),
            ),
          ),
        ),
        onUpdate: (detail) => {
          setState(() {
            _dismissDirection = detail.direction;
            _isReached = detail.reached;
          })
        },
        key: ValueKey(widget.expenses[index]),
        onDismissed: (dis) {
          setState(() {
            final expense = widget.expenses[index];
            widget.removeExpense(expense);
            widget.expenses.remove(expense);
          });
        },
        child: ExpenseItem(
          widget.expenses[index],
        ),
      ),
    );
  }
}
