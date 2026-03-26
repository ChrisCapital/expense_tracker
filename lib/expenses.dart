import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Expenses extends StatefulWidget{
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState(){
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses>{
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
    return const Scaffold(
      body: Column(
        children: [
          Text("Chart goes here..."),
          Text('Expenses List...'),
        ],
      ),
    );
  }
}