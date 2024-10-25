import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String placeholder;
  final bool obscureText;
  final TextEditingController? controller;
  final String? title;
  final Color titleColor;
  final Color borderColor;
  final Color fillColor;
  final String? Function(String?)? validator; // funcao de validacao
  final String? errorMessage; // mensagem de erro
  final double? width;
  final TextInputType type;
  final Function(String)? onChange;

  const CustomTextFormField({
    super.key,
    required this.placeholder,
    this.obscureText = false,
    this.controller,
    this.title,
    this.titleColor = Colors.white,
    this.borderColor = const Color.fromRGBO(79, 84, 97, 80),
    this.fillColor = const Color.fromRGBO(33, 36, 41, 100),
    this.validator,
    this.errorMessage,
    this.width = 320.0,
    this.type = TextInputType.text,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
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
                      fontSize: 22,
                    ),
              ),
            ),
          TextFormField(
            onChanged: onChange,
            keyboardType: type,
            obscureText: obscureText,
            controller: controller,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: fillColor,
              hintText: placeholder,
              labelStyle: TextStyle(color: borderColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: borderColor, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: borderColor, width: 2.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: borderColor, width: 2.0),
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
