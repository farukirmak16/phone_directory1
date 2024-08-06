import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final String? icon;
  final bool isSocialButton;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isSocialButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon != null ? Image.asset(icon!, height: 24.0) : Container(),
      label: Text(
        text,
        style: TextStyle(
          color: isSocialButton ? Colors.black : Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        foregroundColor: isSocialButton ? Colors.black : Colors.white,
        backgroundColor: isSocialButton ? Colors.white : Colors.blue, // Mavi renk
        minimumSize: const Size(double.infinity, 50),
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
      ),
    );
  }
}
