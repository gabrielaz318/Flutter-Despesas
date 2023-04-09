import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveTextField extends StatelessWidget {
  final String label;
  final Function(String) onSubmitted;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const AdaptiveTextField(
      {required this.label,
      required this.keyboardType,
      required this.onSubmitted,
      required this.controller,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: CupertinoTextField(
              controller: controller,
              keyboardType: keyboardType,
              onSubmitted: onSubmitted,
              placeholder: label,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
            ),
        )
        : TextField(
            keyboardType: keyboardType,
            onSubmitted: onSubmitted,
            controller: controller,
            decoration: InputDecoration(labelText: label),
          );
  }
}
