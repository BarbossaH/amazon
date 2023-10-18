import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  final String text;
  final VoidCallback voidCallback;
  const CustomButtom({super.key, required this.text, required this.voidCallback});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: voidCallback,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
        ),
        child: Text(text));
  }
}
