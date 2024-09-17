import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final TextEditingController? controller;
  final String? title;
  final Color titleColor;
  final Color borderColor;
  final Color fillColor;
  final String? Function(String?)? validator; // funcao de validacao
  final String? errorMessage; // mensagem de erro

  const CustomTextFormField({
    super.key,
    required this.labelText,
    this.obscureText = false,
    this.controller,
    this.title,
    this.titleColor = Colors.white,
    this.borderColor = Colors.grey,
    this.fillColor = Colors.white,
    this.validator,
    this.errorMessage,
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
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                title!,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: titleColor,
                    ),
              ),
            ),
          TextFormField(
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
              errorText: errorMessage, // mostra mensagem de erro se houver
            ),
            validator: validator, // funcao de validacao personalizada
          ),
        ],
      ),
    );
  }
}
