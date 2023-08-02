import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpense();
  }
}

class _NewExpense extends State<NewExpense> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime? _selectedDate;
  final formatter = DateFormat.yMd();
  Categories _selectedCategory = Categories.Leisure;

  void presentDatePicker() async {
    // this is used to present a date picker widget
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 20, now.month, now.day);
    final lastDate = DateTime(now.year + 5, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    print(pickedDate);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  void disposes() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount < 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Invalid Input"),
            content: const Text(
              "Please make sure a valid title, amount, date and category was enterd",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Okay"),
              )
            ],
          );
        },
      );
      return;
    }
    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final keyBoardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (context, constraints) {
      final maxWidth = constraints.maxWidth;
      final maxHeight = constraints.maxHeight;
      return SizedBox(
        height: double.infinity,
        width: deviceWidth,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 15.0,
              right: 15.0,
              top: 15.0,
              bottom: keyBoardSpace + 16.0,
            ),
            child: Column(
              children: [
                if (maxWidth < 600)
                  TextFormField(
                    controller: _titleController,
                    maxLength: 50,
                    decoration: InputDecoration(
                      label: const Text("Title"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _titleController,
                          maxLength: 50,
                          decoration: InputDecoration(
                            label: const Text("Title"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: TextFormField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixText: "\$",
                            label: const Text("Amount"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                if (maxWidth < 600)
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixText: "\$",
                            label: const Text("Amount"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      ElevatedButton.icon(
                        label: Text(
                          (_selectedDate == null)
                              ? "Select a date"
                              : formatter.format(_selectedDate!),
                        ),
                        onPressed: presentDatePicker,
                        icon: const Icon(
                          Icons.calendar_month,
                          // size: 25.0,
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      SizedBox(
                        width: 120.0,
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          value: _selectedCategory,
                          items: Categories.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(
                                    category.name.toString(),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(
                              () {
                                _selectedCategory = value;
                              },
                            );
                          },
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton.icon(
                        label: Text(
                          (_selectedDate == null)
                              ? "Select a date"
                              : formatter.format(_selectedDate!),
                        ),
                        onPressed: presentDatePicker,
                        icon: const Icon(
                          Icons.calendar_month,
                          // size: 25.0,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 20.0),
                if (maxWidth < 600)
                  Row(
                    children: [
                      SizedBox(
                        width: 120.0,
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          value: _selectedCategory,
                          items: Categories.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(
                                    category.name.toString(),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(
                              () {
                                _selectedCategory = value;
                              },
                            );
                          },
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          print(_amountController.text);
                        },
                        child: const Text("Cancel Editing"),
                      ),
                      const SizedBox(width: 10.0),
                      ElevatedButton(
                        onPressed: () {
                          print(_titleController.text);
                          Navigator.pop(context);
                          _submitExpenseData();
                        },
                        child: const Text("Save Expense"),
                      ),
                    ],
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          print(_amountController.text);
                        },
                        child: const Text("Cancel Editing"),
                      ),
                      const SizedBox(width: 10.0),
                      ElevatedButton(
                        onPressed: () {
                          print(_titleController.text);
                          Navigator.pop(context);
                          _submitExpenseData();
                        },
                        child: const Text("Save Expense"),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
