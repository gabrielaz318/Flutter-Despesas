import 'package:flutter/material.dart';

import 'adaptative_button.dart';
import 'adaptive_text_field.dart';
import 'adaptative_date_picker.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm(this.onSubmit, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate!);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            10,
            10,
            10,
            10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              AdaptiveTextField(
                controller: _titleController,
                onSubmitted: (_) => _submitForm(),
                label: 'Título',
                keyboardType: TextInputType.name,
              ),
              AdaptiveTextField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm(),
                controller: _valueController,
                label: 'Valor (R\$)',
              ),
              AdaptativeDatePicker(
                onDateChange: (value) => setState(() => _selectedDate = value),
                selectedDate: _selectedDate,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AdaptativeButton(
                    onPressed: _submitForm,
                    label: 'Nova Transação',
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
