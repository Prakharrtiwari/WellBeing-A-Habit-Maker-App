import 'package:flutter/material.dart';
import '../../core/themes/themes.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final int? maxLength;

  const CustomTextField({
    super.key,
    required this.label,
    required this.icon,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.theme.textTheme.bodyMedium?.copyWith(
            fontSize: screenWidth * 0.035,
            fontWeight: FontWeight.w600,
            color: AppColors.charcoal,
          ),
        ),
        SizedBox(height: screenWidth * 0.015),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          maxLength: maxLength,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: AppColors.oliveGreen,
              size: screenWidth * 0.05,
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColors.lightOliveee),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColors.oliveGreen, width: 1.5),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: screenWidth * 0.03,
              horizontal: screenWidth * 0.03,
            ),
          ),
          style: AppTheme.theme.textTheme.bodyMedium?.copyWith(
            fontSize: screenWidth * 0.035,
            color: AppColors.charcoal,
          ),
        ),
      ],
    );
  }
}