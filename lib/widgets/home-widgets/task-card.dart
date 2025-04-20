import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import '../../core/themes/themes.dart';

class TaskCard extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final String title;
  final IconData icon;
  final bool completed;
  final VoidCallback onTap;

  const TaskCard({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.title,
    required this.icon,
    required this.completed,
    required this.onTap,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> with SingleTickerProviderStateMixin {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        if (!widget.completed) {
          setState(() {
            _isPressed = true;
          });
          HapticFeedback.lightImpact(); // Haptic feedback on tap
        }
      },
      onTapUp: (_) {
        if (!widget.completed) {
          setState(() {
            _isPressed = false;
          });
          widget.onTap();
        }
      },
      onTapCancel: () {
        if (!widget.completed) {
          setState(() {
            _isPressed = false;
          });
        }
      },
      child: AnimatedScale(
        scale: _isPressed ? 0.98 : 1.0, // Subtle scale animation on tap
        duration: const Duration(milliseconds: 100),
        child: Opacity(
          opacity: widget.completed ? 0.7 : 1.0, // Fade effect for completed tasks
          child: Container(
            padding: EdgeInsets.all(widget.screenWidth * 0.04),
            margin: EdgeInsets.symmetric(vertical: widget.screenHeight * 0.01),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: widget.completed
                    ? [AppColors.grey.withOpacity(0.5), AppColors.grey.withOpacity(0.3)] // Greyed out for completed
                    : [AppColors.pastelPurple, AppColors.lightVioletBlue], // New professional colors
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
              border: Border.all(color: AppColors.glassWhite, width: 1.5), // Glassmorphism border
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(widget.screenWidth * 0.025),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.lightVioletBlue.withOpacity(0.4), AppColors.pastelPurple.withOpacity(0.4)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
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
                    color: AppColors.white,
                    size: widget.screenWidth * 0.06, // Slightly smaller icon
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
                          fontSize: widget.screenWidth * 0.042, // Slightly smaller, responsive
                          color: AppColors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: widget.screenHeight * 0.005),
                      Text(
                        widget.completed ? 'Completed!' : 'Tap to complete',
                        style: AppTheme.theme.textTheme.bodySmall?.copyWith(
                          fontSize: widget.screenWidth * 0.032, // Smaller, responsive
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
                    widget.completed ? Icons.check_circle : Icons.arrow_forward_ios,
                    key: ValueKey(widget.completed),
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