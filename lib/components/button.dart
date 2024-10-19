import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatelessWidget {
  final String label;
  final int bgColor;
  final int textColor;
  final int borderColor;
  final bool isLoading;
  final VoidCallback onPressedProps;
  final IconData? icon;
  final double? iconSize;
  const Button(
      {super.key,
      this.label = '',
      this.bgColor = 0,
      this.textColor = 0,
      this.borderColor = 0,
      this.isLoading = false,
      this.icon,
      this.iconSize,
      required this.onPressedProps});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
              spreadRadius: 0.0,
              blurRadius: 8.0,
              color: Colors.black,
              offset: Offset(0.0, 12.0)),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            side: BorderSide(color: Color(borderColor), width: 2),
            minimumSize: const Size(268, 56),
            backgroundColor: Color(bgColor),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0))),
        onPressed: onPressedProps,
        child: (isLoading)
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: const [
                        Shadow(
                          offset: Offset(0, 4),
                          blurRadius: 4.0,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  if (icon != null)
                    Icon(
                      icon,
                      color: Colors.white,
                      size: iconSize,
                    ), // Exibe o ícone se não for nulo
                ],
              ),
      ),
    );
  }
}
