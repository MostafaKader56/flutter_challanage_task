import 'package:flutter/material.dart';

class AppMainButton extends StatelessWidget {
  const AppMainButton({
    super.key,
    required this.theme,
    required this.onPressed,
    required this.label,
    this.bgColor,
  });

  final ThemeData theme;
  final VoidCallback onPressed;
  final String label;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        backgroundColor: bgColor ?? theme.colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(
        label,
        style: theme.textTheme.titleMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
