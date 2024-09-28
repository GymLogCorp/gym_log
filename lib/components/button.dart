import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatelessWidget {
  final String label;
  final int bgColor;
  final int textColor;
  final int borderColor;
  final bool isLoading;
  final VoidCallback onPressed; // Função de callback para a ação do botão
  final double? width;
  final double? height;
  final IconData? icon;
  final double? iconSize;

  const Button({
    super.key,
    this.label = '',
    this.bgColor = 0xFF000000, // Preto
    this.textColor = 0xFFFFFFFF, // Branco
    this.borderColor = 0xFF000000, // Preto
    this.isLoading = false,
    required this.onPressed,
    this.width,
    this.height,
    this.icon,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            spreadRadius: 0.0,
            blurRadius: 8.0,
            color: Colors.black,
            offset: Offset(0.0, 12.0),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          side: BorderSide(color: Color(borderColor), width: 2),
          backgroundColor: Color(bgColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          minimumSize: Size(width ?? double.infinity, height ?? 0.0),
        ),
        onPressed: onPressed, // Executa a função quando o botão é pressionado
        child: Row(
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
