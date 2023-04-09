import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptativeDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateChange;

  const AdaptativeDatePicker(
      {required this.selectedDate, required this.onDateChange, super.key});

  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 5)),
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      onDateChange(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? SizedBox(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              maximumDate: DateTime.now(),
              initialDateTime: DateTime.now(),
              minimumDate:
                  DateTime.now().subtract(const Duration(days: 365 * 5)),
              onDateTimeChanged: onDateChange,
            ),
          )
        : SizedBox(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selectedDate == null
                        ? 'Nenhuma data selecionada!'
                        : 'Data selecionada ${DateFormat('dd/MM/y').format(selectedDate)}',
                  ),
                ),
                TextButton(
                  onPressed: () => _showDatePicker(context),
                  child: Text(
                    selectedDate == null
                        ? 'Selecionar Data'
                        : 'Selecionar outra Data',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          );
  }
}
