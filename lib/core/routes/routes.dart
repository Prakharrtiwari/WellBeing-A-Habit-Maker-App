import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/material.dart';
import '../../auth/loginPage.dart';
import '../../auth/registerPage.dart';
import '../../modal/userModel.dart';
import '../../screens/alertsScreen.dart';
import '../../screens/discoveryScreen.dart';
import '../../screens/home page/homescreen.dart';
import '../../screens/journeyScreen.dart';
import '../../screens/onboardingScreen.dart';
import '../../screens/splashScreen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _buildRoute(const SplashScreen());
      case '/login':
        return _buildRoute(const LoginScreen());
      case '/register':
        return _buildRoute(const RegisterScreen());
      case '/home':
        final args = settings.arguments as Map<String, dynamic>?;
        final user = args?['user'] as User?; // Custom User model
        return _buildRoute(HomeScreen(user: user));
      case '/journey':
        return _buildRoute(const JourneyScreen());
      case '/discovery':
        return _buildRoute(const DiscoveryScreen());
      case '/alerts':
        return _buildRoute(const AlertsScreen());
      case '/onboarding':
        final args = settings.arguments as Map<String, dynamic>?;
        final user = args?['user'] as User?; // Custom User model
        return _buildRoute(OnboardingScreen(user: user));
      default:
        return _buildRoute(
          Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static PageRouteBuilder _buildRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Start from right
        const end = Offset.zero; // End at center
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}