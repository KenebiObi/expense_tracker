import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';

class ExpensesApp extends StatefulWidget {
  const ExpensesApp({super.key});

  @override
  State<ExpensesApp> createState() {
    return _ExpensesApp();
  }
}

class _ExpensesApp extends State<ExpensesApp> {
  // List of expenses
  final List<Expense> _registeredExpenses = [
    Expense(
      title: "Laptop",
      amount: 19.90,
      date: DateTime.now(),
      category: Categories.Work,
    ),
    Expense(
      title: "Meat",
      amount: 5.90,
      date: DateTime.now(),
      category: Categories.Food,
    ),
    Expense(
      title: "Las Vegas",
      amount: 300.90,
      date: DateTime.now(),
      category: Categories.Travel,
    ),
    Expense(
      title: "Meat",
      amount: 5.90,
      date: DateTime.now(),
      category: Categories.Food,
    ),
    Expense(
      title: "Meat",
      amount: 5.90,
      date: DateTime.now(),
      category: Categories.Food,
    ),
    Expense(
      title: "Meat",
      amount: 5.90,
      date: DateTime.now(),
      category: Categories.Food,
    ),
    Expense(
      title: "Meat",
      amount: 5.90,
      date: DateTime.now(),
      category: Categories.Food,
    ),
    Expense(
      title: "Meat",
      amount: 5.90,
      date: DateTime.now(),
      category: Categories.Food,
    ),
  ];

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  // delete an expense from the list of expenses
  void _deleteExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 4),
        content: const Text(
          "Expenses deleted",
        ),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(
              () {
                _registeredExpenses.insert(expenseIndex, expense);
              },
            );
          },
        ),
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }

// Modal bottom sheet to input new expenses
  void _openAppExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => NewExpense(onAddExpense: _addExpense),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    print("Width $deviceWidth");
    print("Height $deviceHeight");

    Widget _mainContent = const Center(
      child: Text(
        "No expenses found, start adding some",
      ),
    );

    if (_registeredExpenses.isNotEmpty) {
      _mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _deleteExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          IconButton(
            onPressed: _openAppExpenseOverlay,
            icon: const Icon(
              Icons.add,
              size: 30.0,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: (deviceWidth < 600)
            ? Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Chart(expenses: _registeredExpenses),
                  const SizedBox(height: 20.0),
                  Expanded(
                    child: _mainContent,
                  )
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: Chart(expenses: _registeredExpenses),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: _mainContent,
                  )
                ],
              ),
      ),
    );
  }
}
