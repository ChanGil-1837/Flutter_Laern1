import 'package:expense/widgets/expenses_list/expenses_list.dart';
import 'package:expense/models/expense.dart';
import 'package:expense/widgets/new_expense.dart';
import 'package:expense/widgets/widgets/chart.dart';
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
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return NewExpense(onAddExpense: _addExpense);
        });
  }

  void _addExpense(Expense expsnse) {
    setState(() {
      _registeredExpenses.add(expsnse);
    });
  }

  void _removeExpense(Expense expsnse) {
    final expenseIndex = _registeredExpenses.indexOf(expsnse);
    setState(() {
      _registeredExpenses.remove(expsnse);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Expense deleted"),
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
        label: "Undo",
        onPressed: () {
          setState(() {
            _registeredExpenses.insert(expenseIndex, expsnse);
          });
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
      child: Text("No expenses found. Start adding some!"),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
          expenses: _registeredExpenses, removeExpense: _removeExpense);
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Flutter Expense Tracker",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: _openAddExpenseOverlay,
                icon: const Icon(Icons.add, color: Colors.white))
          ],
        ),
        body: width < 400
            ? Column(
                children: [
                  Chart(expenses: _registeredExpenses),
                  Expanded(
                    child: mainContent,
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(child : Chart(expenses: _registeredExpenses)),
                  Expanded(
                    child: mainContent,
                  ),
                ],
              ));
  }
}
