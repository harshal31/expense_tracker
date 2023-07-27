import 'package:first_expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(this.addExpense, {super.key});

  final void Function(Expense expense) addExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final __amountController = TextEditingController();
  final _titleFocus = FocusNode();
  final _amountFocus = FocusNode();
  String? _titleError;
  String? _amountError;
  DateTime? _selectedDate;
  IconData? _titleClearIcon;
  IconData? _amountClearIcon;
  Category? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _titleController.addListener(() {
      setState(() {
        if (_titleController.text.trim().isNotEmpty) {
          _titleClearIcon = Icons.clear;
          _titleError = null;
        } else {
          _titleClearIcon = null;
          _titleError = "Please provide valid title";
        }
      });
    });
    __amountController.addListener(() {
      setState(() {
        if (__amountController.text.trim().isNotEmpty) {
          _amountClearIcon = Icons.clear;
          _amountError = null;
        } else {
          _amountClearIcon = null;
          _amountError = "Please provide valid amount e.g 1.99";
        }
      });
    });
  }

  void _showDatePickerDialog() async {
    final initialDate = DateTime.now();
    final firstDate =
        DateTime(initialDate.year - 1, initialDate.month, initialDate.day);
    final lastDate = DateTime.now();
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _saveExpense() {
    setState(() {
      if (_titleController.text.trim().isEmpty) {
        _titleError = "Please provide valid title";
        return;
      } else {
        _titleError = null;
      }

      if (__amountController.text.trim().isEmpty ||
          double.parse(__amountController.text.trim()) <= 0) {
        _amountError = "Please provide valid amount e.g 1.99";
        return;
      } else {
        _amountError = null;
      }

      if (_selectedDate == null) {
        showDialog(
            context: context,
            builder: (ctx) => createAlertDialog(
                ctx, "Please select a valid Date", "For e.g 2023/09/08"));
        return;
      }

      if (_selectedCategory == null) {
        showDialog(
            context: context,
            builder: (ctx) => createAlertDialog(
                ctx, "Please select a valid Category", "Work, Leisure, ..etc"));
        return;
      }

      widget.addExpense(
        Expense.createExpense(
            title: _titleController.text,
            amount: double.parse(__amountController.text),
            dateTime: _selectedDate!,
            category: _selectedCategory!),
      );
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.close_outlined),
                iconSize: 35.0,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          TextField(
            controller: _titleController,
            maxLength: 50,
            textAlignVertical: TextAlignVertical.center,
            textInputAction: TextInputAction.next,
            onSubmitted: (term) =>
                _fieldFocusChange(context, _titleFocus, _amountFocus),
            decoration: InputDecoration(
                alignLabelWithHint: true,
                errorText: _titleError,
                label: Text(
                  "Title",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                suffix: IconButton(
                  icon: Icon(_titleClearIcon),
                  onPressed: () => _titleController.clear(),
                )),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Expanded(
                child: TextField(
                  controller: __amountController,
                  textAlignVertical: TextAlignVertical.center,
                  focusNode: _amountFocus,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      alignLabelWithHint: true,
                      errorText: _amountError,
                      prefix: Text(
                        "₹ ",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      label: Text(
                        "Amount",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      suffix: IconButton(
                        icon: Icon(_amountClearIcon),
                        onPressed: () => __amountController.clear(),
                      )),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: _showDatePickerDialog,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          _selectedDate != null
                              ? DateFormat.yMd().format(_selectedDate!)
                              : "No Selected Date",
                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      const SizedBox(width: 4,),
                      const Icon(Icons.calendar_month_outlined),
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 16.0),
          const SizedBox(height: 16.0),
          Row(
            children: [
              DropdownButton(
                icon: const Icon(Icons.arrow_circle_down_outlined),
                value: _selectedCategory,
                hint: dropDownItem(context, Icons.select_all, "Category"),
                items: Category.values
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: dropDownItem(context, categoryIcons[e], e.name),
                      ),
                    )
                    .toList(),
                onChanged: (str) {
                  if (str == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = str;
                  });
                },
              ),
              const SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: Row(
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          width: 2,
                          color: Colors.red.withOpacity(0.5),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Cancel",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _saveExpense,
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            width: 2,
                            color: Colors.green.withOpacity(0.5),
                          ),
                        ),
                        child: Text(
                          "Save Expense",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget createAlertDialog(
      BuildContext context, String messageTitle, String body) {
    return AlertDialog(
      title: Text(
        messageTitle,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
      ),
      content: Text(
        body,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Okay",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }

  Widget dropDownItem(BuildContext context, IconData? iconData, String value) {
    return Row(
      children: [
        Icon(iconData),
        const SizedBox(
          width: 6.0,
        ),
        Text(
          value.capitalize(),
          style: Theme.of(context).textTheme.titleSmall,
        )
      ],
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  void dispose() {
    _titleController.dispose();
    __amountController.dispose();
    _amountFocus.dispose();
    _titleFocus.dispose();
    super.dispose();
  }
}
