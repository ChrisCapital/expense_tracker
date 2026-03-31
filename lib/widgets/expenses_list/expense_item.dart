import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';


class ExpenseItem extends StatelessWidget{
  const ExpenseItem({super.key, required this.expense});
  final Expense expense;
  @override

  Widget build(BuildContext context){
    return Card(
      child:Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,

        ),
        child: Column( 
          children: [
            Text(expense.title), // text box at the top of the col
            const SizedBox(height:4), // a little space betwween first row of the col and the second
            Row(children: [
              Text('\$${expense.amount.toStringAsFixed(2)}'),
              Spacer(), // spacer to push everything else over to the right
              Row(children:[ //cat and date closely grouped, so another row in this row
                Icon(categoryIcons[expense.category]),
                const SizedBox(width:8),
                Text(expense.formattedDate) // fix date to not look bad
              ])

            ])
          ]
        )
      ),
    );
  }
}