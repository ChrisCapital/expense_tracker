import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/new_expense.dart';

class Expenses extends StatefulWidget{
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState(){
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses>{
  void _openAddExpenseOverlay(){
    showModalBottomSheet(
      isScrollControlled: true,
      context:context,
      builder: (ctx)=> NewExpense(
        onAddExpense: _addExpense,
      ));
  }
  void _addExpense(Expense expense){
    setState((){
      _registeredExpenses.add(expense);
    });
  }
  final List<Expense> _registeredExpenses = [
    Expense(
      title: "Ginos Pizza",
      amount:25.00,
      date: DateTime.now(),
      category: Category.food,   
    ),
    Expense(
      title: "Amtrack Ticket",
      amount:19.99,
      date: DateTime.now(),
      category: Category.travel,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar:AppBar(
    title: const Text("Expense Tracker"),
    actions: [
      IconButton(
        icon: const Icon(Icons.add),
        onPressed: _openAddExpenseOverlay,
      ),
    ],
  ),
  
      body: Column(
        children: [
          const Text("Chart goes here..."),
          Expanded(
            child: ExpensesList(expenses: _registeredExpenses)),
        ],
      ),
    );
  }
}