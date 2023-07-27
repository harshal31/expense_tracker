import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

enum Category { food, travel, leisure, work }

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

final categoryIcons = {
  Category.food: Icons.dining,
  Category.travel: Icons.flight,
  Category.leisure: Icons.movie,
  Category.work: Icons.work
};

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime dateTime;
  final Category category;

  Expense({
    required this.title,
    required this.amount,
    required this.dateTime,
    required this.category,
  }) : id = const Uuid().v4();

  Expense.createExpense({
    required this.title,
    required this.amount,
    required this.dateTime,
    required this.category,
  }) : id = const Uuid().v4();

  String getFormattedDate() =>
      "${dateTime.year}-${dateTime.month}-${dateTime.day}";
}

class ExpenseBucket {
  final Category category;
  final List<Expense> expenses;

  ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forEachCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses.where((element) => element.category == category)
      .toList();

  double getTotalExpense() =>
      expenses
          .map((e) => e.amount)
          .fold(0.0, (previousValue, element) => previousValue + element);
}


