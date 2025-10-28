import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'auth/login_screen.dart';
import 'home/home_screen.dart';

// Handles session persistence (users should stay logged in) [cite: 12]
class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current user from the stream provided in main.dart
    final user = Provider.of<User?>(context);

    if (user == null) {
      // User is logged out, show Login/Registration
      return const LoginScreen(); 
    } else {
      // User is logged in, show Homepage
      return const HomeScreen(); 
    }
  }
}