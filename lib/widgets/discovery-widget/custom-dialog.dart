import 'package:flutter/material.dart';

import '../../core/themes/themes.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final List<Widget>? actions;
  final double screenWidth;

  const CustomDialog({
    super.key,
    required this.title,
    required this.content,
    this.actions,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      elevation: 10,
      title: Text(
        title,
        style: AppTheme.theme.textTheme.titleLarge?.copyWith(
          fontSize: screenWidth * 0.05,
          fontWeight: FontWeight.w700,
          color: AppColors.charcoal,
        ),
      ),
      content: content,
      actions: actions,
    );
  }
}