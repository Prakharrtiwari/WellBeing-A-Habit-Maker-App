import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habitapp/core/themes/themes.dart';

class StatItem extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const StatItem({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(screenWidth * 0.02),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: screenWidth * 0.06,
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: screenWidth * 0.04, // Reduced from assumed 0.045
            fontWeight: FontWeight.w700,
            color: AppColors.charcoal,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: screenWidth * 0.032, // Reduced from assumed 0.035
            fontWeight: FontWeight.w500,
            color: AppColors.grey,
          ),
        ),
      ],
    );
  }
}