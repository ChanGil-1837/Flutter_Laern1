import 'package:expense/widgets/expenses_list/expenses_list.dart';
import 'package:expense/models/expense.dart';
import 'package:expense/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _Expenses();
  }
}

class _Expenses extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: "my", amount: 1, date: DateTime.now(), category: Category.food),
    Expense(
        title: "name", amount: 2, date: DateTime.now(), category: Category.work)
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(context: context, builder: (context) {
      return const NewExpense();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Flutter Expense Tracker",
        ),
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('The chart'),
          Expanded(
            child: ExpensesList(expenses: _registeredExpenses),
          ),
        ],
      )
    );
  }
}
