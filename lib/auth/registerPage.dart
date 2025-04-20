import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/themes/themes.dart';
import 'authService.dart'; // For haptic feedback


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final authService = AuthService();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/images/bg10.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              // Register Title and Quote
              Positioned(
                top: screenHeight * 0.20,
                left: screenWidth * 0.06,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Transform(
                      transform: Matrix4.skewX(-0.2), // Left skew
                      child: Text(
                        'Register',
                        style: theme.textTheme.headlineLarge?.copyWith(
                          fontSize: screenWidth * 0.1,
                          height: 1.5,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Container(
                      width: screenWidth * 0.8, // Wider to fill space
                      child: Text(
                        'Elevate Your Mindset: Study Today for a Better Tomorrow.',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontSize: screenWidth * 0.055,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Google Sign-In Button
              Positioned(
                top: screenHeight * 0.40,
                left: screenWidth * 0.25,
                right: screenWidth * 0.25,
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    authService.signUpWithGoogle(context);
                  },
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.01,
                      horizontal: screenWidth * 0.03,
                    ),
                    decoration: AppTheme.buttonDecoration,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'lib/assets/images/google.png',
                          width: (screenWidth * 0.06).clamp(20, 24),
                          height: (screenWidth * 0.06).clamp(20, 24),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Flexible(
                          child: Text(
                            'Signup with Google',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontSize: (screenWidth * 0.035).clamp(12, 14),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}