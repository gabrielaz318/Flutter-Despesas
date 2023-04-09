import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptativeButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  
  const AdaptativeButton({
    required this.label,
    required this.onPressed,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: onPressed,
            child: Text(label),
          )
        : ElevatedButton(
            onPressed: onPressed,
            child: Text(label),
          );
  }
}
