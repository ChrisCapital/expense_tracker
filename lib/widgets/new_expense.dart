import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid input"),
          content: const Text(
              "Please make sure to have a valid title, amount, and date!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text("Okay"),
            )
          ],
        ),
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
    Navigator.pop(context);
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // grab the keyboard height so we can pad the bottom of the modal
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: [
                // ---------- TITLE / AMOUNT ROW ----------
                if (width >= 600)
                  Row(
                    children: [
                      Expanded(child: _buildTitleField()),
                      const SizedBox(width: 24),
                      Expanded(child: _buildAmountField()),
                    ],
                  )
                else
                  _buildTitleField(),

                // ---------- DATE / CATEGORY ROW ----------
                if (width >= 600)
                  Row(
                    children: [
                      _buildCategoryDropdown(),
                      const SizedBox(width: 24),
                      Expanded(child: _buildDatePickerRow()),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(child: _buildAmountField()),
                      const SizedBox(width: 16),
                      Expanded(child: _buildDatePickerRow()),
                    ],
                  ),

                const SizedBox(height: 16),

                // ---------- BUTTONS ROW ----------
                if (width >= 600)
                  Row(
                    children: [
                      const Spacer(),
                      _buildCancelButton(),
                      _buildSaveButton(),
                    ],
                  )
                else
                  Row(
                    children: [
                      _buildCategoryDropdown(),
                      const Spacer(),
                      _buildCancelButton(),
                      _buildSaveButton(),
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }

  // ---------- helper widgets to avoid duplicating code in the two layouts ----------

  Widget _buildTitleField() {
    return TextField(
      controller: _titleController,
      maxLength: 50,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
        label: Text("Title"),
      ),
    );
  }

  Widget _buildAmountField() {
    return TextField(
      controller: _amountController,
      maxLength: 10,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        prefixText: '\$',
        label: Text("Amount"),
      ),
    );
  }

  Widget _buildDatePickerRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          _selectedDate == null
              ? 'Select Date'
              : formatter.format(_selectedDate!),
        ),
        IconButton(
          onPressed: _presentDatePicker,
          icon: const Icon(Icons.calendar_month),
        ),
      ],
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButton(
      value: _selectedCategory,
      items: Category.values
          .map(
            (category) => DropdownMenuItem(
              value: category,
              child: Text(category.name.toUpperCase()),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value == null) return;
        setState(() {
          _selectedCategory = value;
        });
      },
    );
  }

  Widget _buildCancelButton() {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text("Cancel"),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: _submitExpenseData,
      child: const Text("Save Expense"),
    );
  }
}