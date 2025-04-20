import 'package:flutter/material.dart';
import '../../core/themes/themes.dart';

class GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final List<Color> gradientColors;

  const GradientButton({
    super.key,
    required this.label,
    this.onPressed,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 5,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: gradientColors[0].withOpacity(0.4),
              blurRadius: 14,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(
          vertical: screenWidth * 0.03, // Unchanged from previous
          horizontal: screenWidth * 0.03, // Reduced from 0.04
        ),
        child: Center(
          child: Text(
            label,
            style: AppTheme.theme.textTheme.labelMedium?.copyWith(
              fontSize: screenWidth * 0.04, // Unchanged from previous
              fontWeight: FontWeight.w600,
              color: AppColors.oliveGreen,
            ),
          ),
        ),
      ),
    );
  }
}