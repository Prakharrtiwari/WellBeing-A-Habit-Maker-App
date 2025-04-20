import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/themes/themes.dart';
import '../journey-widgets/optioncard.dart';



class EmotionalWellBeing extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const EmotionalWellBeing({
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
          'Emotional Well-being',
          style: GoogleFonts.poppins(
            fontSize: screenWidth * 0.05,
            fontWeight: FontWeight.w700,
            color: AppColors.charcoal,
            letterSpacing: 0.8,
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        OptionCard(
          screenWidth: screenWidth,
          screenHeight: screenHeight,
          title: 'Mood Meter',
          subtitle: 'Track your emotional state',
          icon: Icons.mood,
          gradientColors: [
            AppColors.goldenYellow,
            AppColors.lightGolden,
          ],
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Mood Meter tapped')),
            );
          },
        ),
        SizedBox(height: screenHeight * 0.02),
        OptionCard(
          screenWidth: screenWidth,
          screenHeight: screenHeight,
          title: 'EQ Lessons',
          subtitle: 'Watch short emotional intelligence videos',
          icon: Icons.video_library,
          gradientColors: [
            AppColors.oliveGreen,
            AppColors.lightOlive,
          ],
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('EQ Lessons tapped')),
            );
          },
        ),
      ],
    );
  }
}