import 'package:flutter/material.dart';
import '../../core/themes/themes.dart';

class CustomDropdown extends StatelessWidget {
  final String label;
  final IconData icon;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String? Function(String?)? validator;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.icon,
    required this.value,
    required this.items,
    required this.onChanged,
    this.validator,
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
        Container(
          decoration: BoxDecoration(
            color: Colors.white, // Solid white background to isolate from parent
            borderRadius: BorderRadius.circular(16),
          ),
          child: DropdownButtonFormField<String>(
            value: value != null && items.contains(value) ? value : null, // Ensure valid value
            items: items.toSet().toList().map((String item) { // Remove duplicates
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: AppTheme.theme.textTheme.bodyMedium?.copyWith(
                    fontSize: screenWidth * 0.035,
                    color: AppColors.charcoal,
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
            validator: validator,
            dropdownColor: Colors.white, // Pure white for dropdown menu
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: AppColors.oliveGreen,
                size: screenWidth * 0.05,
              ),
              filled: true,
              fillColor: Colors.white, // Pure white for field
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
          ),
        ),
      ],
    );
  }
}