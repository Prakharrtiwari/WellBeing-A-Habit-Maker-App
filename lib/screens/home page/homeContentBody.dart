import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart';
import 'package:habitapp/modal/userModel.dart';
import '../../auth/authService.dart';
import '../../core/themes/themes.dart';
import '../../widgets/home-widgets/emotional_wellbeing.dart';
import '../../widgets/home-widgets/quickstats.dart';
import '../../widgets/home-widgets/task-section.dart';

class HomeContentBody extends StatefulWidget {
  final Animation<double> fadeAnimation;
  final AnimationController animationController;
  final User? user; // Custom User model

  const HomeContentBody({
    super.key,
    required this.fadeAnimation,
    required this.animationController,
    required this.user,
  });

  @override
  State<HomeContentBody> createState() => _HomeContentBodyState();
}

class _HomeContentBodyState extends State<HomeContentBody> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _onTaskComplete() {
    _confettiController.play();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final authService = AuthService();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.12),
        child: Container(
          width: screenWidth,
          height: screenHeight * 0.20,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(0, 6),
                blurRadius: 10,
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.charcoal,
                AppColors.oliveGreen,
              ],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: -screenWidth * 0.3,
                top: -screenHeight * 0.1,
                child: Container(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.3,
                  decoration: BoxDecoration(
                    color: AppColors.glassWhite,
                    borderRadius: const BorderRadius.all(Radius.elliptical(300, 200)),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                ),
              ),
              Positioned(
                left: screenWidth * 0.06,
                top: screenHeight * 0.08,
                child: Row(
                  children: [
                    Container(
                      width: screenWidth * 0.12,
                      height: screenWidth * 0.12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.self_improvement,
                        color: AppColors.charcoal,
                        size: 28,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.03),
                    Text(
                      'WellBeing',
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: screenWidth * 0.06,
                top: screenHeight * 0.08,
                child: GestureDetector(
                  onTap: () {
                    authService.signOut(context);
                  },
                  child: Container(
                    width: screenWidth * 0.12,
                    height: screenWidth * 0.12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: widget.user?.photoURL != null
                        ? ClipOval(
                      child: Image.network(
                        widget.user!.photoURL!,
                        fit: BoxFit.cover,
                      ),
                    )
                        : Icon(
                      Icons.person,
                      color: AppColors.charcoal,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  QuickStats(screenWidth: screenWidth, screenHeight: screenHeight),
                  SizedBox(height: screenHeight * 0.035),
                  TaskSection(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    onTaskComplete: _onTaskComplete,
                  ),
                  SizedBox(height: screenHeight * 0.035),
                  EmotionalWellBeing(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              particleDrag: 0.05,
              emissionFrequency: 0.05,
              numberOfParticles: 50,
              gravity: 0.05,
              colors: const [
                Colors.red,
                Colors.blue,
                Colors.yellow,
                Colors.green,
                Colors.purple,
              ],
            ),
          ),
        ],
      ),
    );
  }
}