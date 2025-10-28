import 'package:flutter/material.dart';
// Note: flutter_svg import is no longer strictly necessary if the image is removed, 
// but we keep it for now just in case.
import 'package:flutter_svg/flutter_svg.dart'; 
import 'wrapper.dart'; // Import your main navigation wrapper

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToMain(); // Start navigation timer immediately
  }

  void _navigateToMain() async {
    // Wait for 3 seconds before navigating to the main content
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      // Navigate to the main application wrapper (Wrapper)
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const Wrapper(), 
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Clean white background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ONLY display the title text as requested
          children: [
            Text(
              'Tulu Tech Shop',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: Colors.blue.shade800,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
