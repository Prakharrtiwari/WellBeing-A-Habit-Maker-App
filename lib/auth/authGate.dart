import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import '../../auth/authService.dart';
import '../screens/home page/homescreen.dart';
import '../screens/splashScreen.dart';
import '../../modal/userModel.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<firebase_auth.User?>(
      stream: firebase_auth.FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          // Retrieve user data from secure storage
          return FutureBuilder<User?>(
            future: AuthService().getStoredUser(),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final customUser = userSnapshot.data;
              if (customUser != null) {
                return HomeScreen(user: customUser);
              } else {
                // Fallback: Create a basic User object if storage is empty
                final firebaseUser = snapshot.data!;
                final fallbackUser = User(
                  uid: firebaseUser.uid,
                  email: firebaseUser.email,
                  displayName: firebaseUser.displayName,
                  photoURL: firebaseUser.photoURL,
                  mobile: '',
                  examType: '',
                  nextAttempt: '',
                  classLevel: '',
                  institute: '',
                  coachingMode: '',
                );
                return HomeScreen(user: fallbackUser);
              }
            },
          );
        } else {
          return const SplashScreen();
        }
      },
    );
  }
}