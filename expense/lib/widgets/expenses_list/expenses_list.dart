import 'package:expense/models/expense.dart';
import 'package:expense/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses,required this.removeExpense});
  final List<Expense> expenses;
  final void Function(Expense expense) removeExpense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: expenses.length, 
      itemBuilder: (ctx,index) =>
        Dismissible(
          key: ValueKey(expenses[index]),
          background: Container(color: const Color.fromARGB(255, 250, 117, 117)),
          onDismissed:(direction)  => removeExpense(expenses[index]), 
          child: ExpenseItem(expenses[index]),
        ),
    );
  }
}
