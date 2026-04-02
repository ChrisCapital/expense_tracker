import 'package:flutter/material.dart';


class NewExpense extends StatefulWidget{
  const NewExpense({super.key});

  State<NewExpense> createState(){
    return _NewExpenseState();
  }
}


class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  @override
  Widget build(BuildContext context){

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              label: Text("Title"),
            ),
          ),
          Row(children:[
            //make the amount field here
          ],),
          Row(children: [
            ElevatedButton(onPressed:(){
              print(_titleController.text);
            }, child:Text("save Expense"))
          ])
        ],
      ),
    );
  }
}