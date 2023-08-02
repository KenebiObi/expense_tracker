import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

enum Categories { Food, Travel, Leisure, Work }
// the enum is a value that allows the creation of a custom variable or type
// which is a combination of already defined allowed values like the above example

const categoryIcons = {
  Categories.Food: Icons.lunch_dining,
  Categories.Travel: Icons.flight_takeoff,
  Categories.Leisure: Icons.movie,
  Categories.Work: Icons.work,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();
  // this is another way of initialising a variable in a class
  // here, you can already have a default value adsigned to the variable as it is here
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Categories category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  // used to hold up all the expenses for each category
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where(
              (expense) => expense.category == category,
            )
            .toList();
  final Categories category;
  final List<Expense> expenses;

  double get totalExpenses {
    // a helper to et the total expense for each bucket
    double sum = 0;

    for (var expnese in expenses) {
      sum += expnese.amount;
    }
    return sum;
  }
}
