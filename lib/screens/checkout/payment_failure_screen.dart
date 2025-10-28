import 'package:flutter/material.dart';

// Failure Page (error message)
class PaymentFailureScreen extends StatelessWidget {
  const PaymentFailureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Failed')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 100),
            const SizedBox(height: 20),
            const Text(
              'Payment Failed',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('There was an issue processing your payment. Please try again.'),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Return to the Checkout Screen
                Navigator.of(context).pop(); 
              },
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}