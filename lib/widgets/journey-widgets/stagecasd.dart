import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/themes/themes.dart';


class StageCard extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final String title;
  final String timeline;
  final bool isExpanded;
  final bool isLocked;
  final bool isCompleted;
  final double progress;
  final VoidCallback onToggle;

  const StageCard({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.title,
    required this.timeline,
    required this.isExpanded,
    required this.isLocked,
    required this.isCompleted,
    required this.progress,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.02),
      padding: EdgeInsets.all(screenWidth * 0.045),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: isLocked ? null : onToggle,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  decoration: BoxDecoration(
                    color: isLocked
                        ? AppColors.grey.withOpacity(0.3)
                        : AppColors.goldenYellow.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isCompleted ? Icons.check_circle : Icons.star,
                    color: isLocked ? AppColors.grey : AppColors.goldenYellow,
                    size: screenWidth * 0.07,
                  ),
                ),
                SizedBox(width: screenWidth * 0.04),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.w700,
                          color: isLocked ? AppColors.grey : AppColors.charcoal,
                        ),
                      ),
                      Text(
                        timeline,
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.035,
                          color: isLocked ? AppColors.grey : AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: isLocked ? AppColors.grey : AppColors.charcoal,
                  size: screenWidth * 0.06,
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.015),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.grey.withOpacity(0.3),
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.oliveGreen),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
          if (isCompleted)
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.01),
              child: Row(
                children: [
                  Icon(
                    Icons.emoji_events,
                    color: AppColors.goldenYellow,
                    size: screenWidth * 0.05,
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Text(
                    'Stage Completed!',
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w600,
                      color: AppColors.oliveGreen,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}