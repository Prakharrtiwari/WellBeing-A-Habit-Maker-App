import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../modal/userModel.dart';

class AuthService {
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/userinfo.profile',
    ],
  );
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // Stream for auth state changes
  Stream<firebase_auth.User?> get authStateChanges => _auth.authStateChanges();

  // Helper to print user data with stickers
  void _printUserData(User customUser, String action) {
    print('🎉🎉 $action Successful! 🎉🎉');
    print('🚀 User Data:');
    print('  UID: ${customUser.uid}');
    print('  Email: ${customUser.email}');
    print('  Display Name: ${customUser.displayName}');
    print('  Photo URL: ${customUser.photoURL}');
    print('  Mobile: ${customUser.mobile}');
    print('  Exam Type: ${customUser.examType}');
    print('  Next Attempt: ${customUser.nextAttempt}');
    print('  Class Level: ${customUser.classLevel}');
    print('  Institute: ${customUser.institute}');
    print('  Coaching Mode: ${customUser.coachingMode}');
    print('🎈 End of $action Data 🎈');
  }

  // Helper to store user data in secure storage
  Future<void> _storeUserData(User customUser) async {
    await _secureStorage.write(key: 'uid', value: customUser.uid ?? '');
    await _secureStorage.write(key: 'email', value: customUser.email ?? '');
    await _secureStorage.write(key: 'displayName', value: customUser.displayName ?? '');
    await _secureStorage.write(key: 'photoURL', value: customUser.photoURL ?? '');
    await _secureStorage.write(key: 'mobile', value: customUser.mobile ?? '');
    await _secureStorage.write(key: 'examType', value: customUser.examType ?? '');
    await _secureStorage.write(key: 'nextAttempt', value: customUser.nextAttempt ?? '');
    await _secureStorage.write(key: 'classLevel', value: customUser.classLevel ?? '');
    await _secureStorage.write(key: 'institute', value: customUser.institute ?? '');
    await _secureStorage.write(key: 'coachingMode', value: customUser.coachingMode ?? '');
  }

  // Sign in with Google
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return; // User cancelled

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final firebase_auth.UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      final firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        // Ensure Google Sign-In data is available
        final googleAccount = await _googleSignIn.signInSilently() ?? googleUser;
        final customUser = User(
          uid: firebaseUser.uid,
          email: firebaseUser.email ?? googleAccount.email,
          displayName: firebaseUser.displayName ?? googleAccount.displayName,
          photoURL: firebaseUser.photoURL ?? googleAccount.photoUrl,
          mobile: '',
          examType: '',
          nextAttempt: '',
          classLevel: '',
          institute: '',
          coachingMode: '',
        );

        // Store user data in secure storage
        await _storeUserData(customUser);

        // Print user data with stickers
        _printUserData(customUser, 'Sign-In');

        // Navigate to HomeScreen and clear navigation stack
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
              (route) => false,
          arguments: {'user': customUser},
        );
      }
    } catch (e) {
      print('❌ Error signing in: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing in: $e')),
      );
    }
  }

  // Sign up with Google
  Future<void> signUpWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return; // User cancelled

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final firebase_auth.UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      final firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        // Ensure Google Sign-In data is available
        final googleAccount = await _googleSignIn.signInSilently() ?? googleUser;
        final customUser = User(
          uid: firebaseUser.uid,
          email: firebaseUser.email ?? googleAccount.email,
          displayName: firebaseUser.displayName ?? googleAccount.displayName,
          photoURL: firebaseUser.photoURL ?? googleAccount.photoUrl,
          mobile: '',
          examType: '',
          nextAttempt: '',
          classLevel: '',
          institute: '',
          coachingMode: '',
        );

        // Store user data in secure storage
        await _storeUserData(customUser);

        // Print user data with stickers
        _printUserData(customUser, 'Sign-Up');

        // Navigate to OnboardingScreen and clear navigation stack
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/onboarding',
              (route) => false,
          arguments: {'user': customUser},
        );
      }
    } catch (e) {
      print('❌ Error signing up: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing up: $e')),
      );
    }
  }

  // Sign out and remove all user data
  Future<void> signOut(BuildContext context) async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();

      // Clear all data from secure storage
      await _secureStorage.deleteAll();
      print('🗑️ Secure storage cleared');

      print('🔒 Sign-out successful!');

      // Navigate to SplashScreen and clear navigation stack
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/',
            (route) => false,
      );
    } catch (e) {
      print('❌ Error during sign-out: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing out: $e')),
      );
      rethrow;
    }
  }

  // Retrieve user data from secure storage
  Future<User?> getStoredUser() async {
    try {
      final data = await _secureStorage.readAll();
      if (data.isEmpty) return null;

      return User(
        uid: data['uid'],
        email: data['email'],
        displayName: data['displayName'],
        photoURL: data['photoURL'],
        mobile: data['mobile'],
        examType: data['examType'],
        nextAttempt: data['nextAttempt'],
        classLevel: data['classLevel'],
        institute: data['institute'],
        coachingMode: data['coachingMode'],
      );
    } catch (e) {
      print('❌ Error retrieving user data: $e');
      return null;
    }
  }
}