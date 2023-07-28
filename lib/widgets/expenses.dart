import 'package:first_expense_tracker/utility_widgets/either.dart';
import 'package:first_expense_tracker/widgets/charts/chart.dart';
import 'package:first_expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'expenses/expenses_list.dart';
import '../models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _expenses = [
    Expense(
        title: "Flutter Course",
        amount: 19.99,
        dateTime: DateTime.now(),
        category: Category.work),
    Expense(
        title: "Cinema",
        amount: 29.99,
        dateTime: DateTime.now(),
        category: Category.leisure),
  ];

  _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(_addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _expenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    int index = _expenses.indexOf(expense);
    setState(() {
      _expenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
            label: "Undo",
            onPressed: () => {
                  setState(() {
                    _expenses.insert(index, expense);
                  })
                }),
        content: const Text("Expense Deleted"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text(
        "No expenses found. Start adding some!",
      ),
    );

    if (_expenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _expenses,
        removeExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Flutter Expense Tracker",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            iconSize: 30.0,
            icon: const Icon(Icons.add_outlined),
          ),
        ],
      ),
      body: Either(
        first: Column(
          children: [
            Chart(expenses: _expenses),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: mainContent,
            ),
          ],
        ),
        second: Row(
          children: [
            Expanded(
              child: Chart(
                expenses: _expenses,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: mainContent,
            ),
          ],
        ),
      ),
    );
  }
}
