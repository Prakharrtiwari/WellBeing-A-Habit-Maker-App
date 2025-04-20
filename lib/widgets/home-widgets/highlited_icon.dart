import 'package:flutter/material.dart';

import '../../core/themes/themes.dart';


class HighlightedIcon extends StatelessWidget {
  final IconData icon;
  final bool isSelected;

  const HighlightedIcon({
    super.key,
    required this.icon,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 32,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.charcoal.withOpacity(0.15) : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(
        icon,
        size: isSelected ? 26 : 24,
        color: isSelected ? AppColors.charcoal : AppColors.grey,
      ),
    );
  }
}