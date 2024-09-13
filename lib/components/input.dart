import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final TextEditingController? controller;
  final String? title;
  final Color titleColor;
  final Color borderColor;
  final Color fillColor;

  const InputField({
    super.key,
    required this.labelText,
    this.obscureText = false,
    this.controller,
    this.title,
    this.titleColor = Colors.white,
    this.borderColor = Colors.grey,
    this.fillColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                title!,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: titleColor,
                    ),
              ),
            ),
          TextField(
            obscureText: obscureText,
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: fillColor,
              labelText: labelText,
              labelStyle: TextStyle(color: borderColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: borderColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
