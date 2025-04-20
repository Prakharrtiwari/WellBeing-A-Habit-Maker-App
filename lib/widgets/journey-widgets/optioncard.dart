import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/themes/themes.dart';

class OptionCard extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> gradientColors;
  final VoidCallback onTap;
  final bool isCompleted;

  const OptionCard({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradientColors,
    required this.onTap,
    this.isCompleted = false,
  });

  @override
  _OptionCardState createState() => _OptionCardState();
}

class _OptionCardState extends State<OptionCard> with SingleTickerProviderStateMixin {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        if (!widget.isCompleted) {
          setState(() {
            _isPressed = true;
          });
          HapticFeedback.lightImpact();
        }
      },
      onTapUp: (_) {
        if (!widget.isCompleted) {
          setState(() {
            _isPressed = false;
          });
          widget.onTap();
        }
      },
      onTapCancel: () {
        if (!widget.isCompleted) {
          setState(() {
            _isPressed = false;
          });
        }
      },
      child: AnimatedScale(
        scale: _isPressed ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Opacity(
          opacity: widget.isCompleted ? 0.7 : 1.0,
          child: Container(
            padding: EdgeInsets.all(widget.screenWidth * 0.04),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: widget.isCompleted
                    ? [AppColors.grey.withOpacity(0.5), AppColors.grey.withOpacity(0.3)]
                    : widget.gradientColors.isNotEmpty
                    ? widget.gradientColors
                    : [AppColors.pastelPurple, AppColors.lightVioletBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.darkBlue.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
              border: Border.all(color: AppColors.glassWhite, width: 1.5),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(widget.screenWidth * 0.025),
                  decoration: BoxDecoration(
                    color: AppColors.white, // White sphere background
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Icon(
                    widget.icon,
                    color: Colors.black, // Black icon color
                    size: widget.screenWidth * 0.06,
                  ),
                ),
                SizedBox(width: widget.screenWidth * 0.035),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: AppTheme.theme.textTheme.labelMedium?.copyWith(
                          fontSize: widget.screenWidth * 0.042,
                          color: AppColors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: widget.screenHeight * 0.005),
                      Text(
                        widget.subtitle,
                        style: AppTheme.theme.textTheme.bodySmall?.copyWith(
                          fontSize: widget.screenWidth * 0.032,
                          color: AppColors.white.withOpacity(0.9),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    widget.isCompleted ? Icons.check_circle : Icons.arrow_forward_ios,
                    key: ValueKey(widget.isCompleted),
                    color: AppColors.white.withOpacity(0.9),
                    size: widget.screenWidth * 0.045,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}