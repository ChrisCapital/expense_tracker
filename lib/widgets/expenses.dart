import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
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
   void _removeExpense(Expense expense){
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState((){
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds:5),
        content: Text("Expense Deleted"),
        action: SnackBarAction(
          label:"Undo", 
          onPressed:(){
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
        }),
      ),
    );
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
    Widget mainContent = const Center(
      child: Text("No Expense. Click + to add one!")
      );
      if(_registeredExpenses.isNotEmpty){
        mainContent = ExpensesList(
          expenses: _registeredExpenses,
          onRemoveExpense: _removeExpense,
        );
      }
    
    
    
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
          Chart(expenses: _registeredExpenses),
          Expanded(
            child: mainContent),
        ],
      ),
    );
  }
}