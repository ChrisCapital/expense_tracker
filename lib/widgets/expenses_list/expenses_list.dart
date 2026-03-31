
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget{
  const ExpensesList({super.key, required this.expenses});
  
  final List<Expense> expenses;
  @override
  Widget build(BuildContext context){
    
    return ListView.builder( //build each item that appears on screen as you scroll
      itemCount : expenses.length,
      itemBuilder: (ctx,index)=> ExpenseItem(expense: expenses[index]),
    );
  }
}