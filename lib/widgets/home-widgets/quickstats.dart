import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habitapp/core/themes/themes.dart';
import 'package:habitapp/widgets/home-widgets/stat-item.dart';

class QuickStats extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const QuickStats({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Progress',
          style: GoogleFonts.poppins(
            fontSize: screenWidth * 0.045, // Reduced from 0.05
            fontWeight: FontWeight.w700,
            color: AppColors.charcoal,
            letterSpacing: 0.8,
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        Container(
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatItem(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                label: 'Current Stage',
                value: 'Beginner',
                icon: Icons.flash_on,
                color: AppColors.goldenYellow,
              ),
              StatItem(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                label: 'Reward Points',
                value: '250',
                icon: Icons.monetization_on,
                color: AppColors.oliveGreen,
              ),
              StatItem(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                label: 'Daily Streak',
                value: '7 Days',
                icon: Icons.local_fire_department,
                color: AppColors.lightGolden,
              ),
            ],
          ),
        ),
      ],
    );
  }
}