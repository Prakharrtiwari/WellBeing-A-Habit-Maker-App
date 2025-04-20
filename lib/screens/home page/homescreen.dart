import 'package:flutter/material.dart';

import '../../modal/userModel.dart';
import 'homeContent.dart';

class HomeScreen extends StatelessWidget {
  final User? user; // Custom User model
  const HomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return HomeContent(user: user);
  }
}