import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import '../../services/stripe_service.dart';
import 'payment_success_screen.dart';
import 'payment_failure_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  void _handlePayment(BuildContext context) async {
    final cartProvider = context.read<CartProvider>();
    // Get total amount in dollars/euros
    final amount = cartProvider.totalAmount; 

    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cart is empty. Cannot checkout.')),
      );
      return;
    }

    // Convert total amount to the smallest currency unit (e.g., cents) as an integer
    final stripeAmountCents = (amount * 100).toInt(); 

    // Use a loading indicator 
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // Use Stripe for the checkout process (in test mode)
    final success = await StripeService().makePayment(
        stripeAmountCents, 'USD', context); // Pass amount as integer/cents
    
    // Close loading dialog
    if(context.mounted) Navigator.pop(context); 

    if (success && context.mounted) {
      // On successful payment, clear the cart 
      cartProvider.clearCart(); 

      // On successful payment, show a success page.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const PaymentSuccessScreen()),
      );
    } else if (context.mounted) {
      // On failure, show an error message.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const PaymentFailureScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Order Summary', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Divider(),
            // Display items for final review
            Expanded(
              child: ListView.builder(
                itemCount: cartProvider.cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartProvider.cartItems[index];
                  // Assuming item.product.title and item.product.price exist
                  return Text('${item.quantity} x ${item.product.title} - \$${(item.product.price * item.quantity).toStringAsFixed(2)}');
                },
              ),
            ),
            const Divider(),
            Text(
              'Final Total: \$${cartProvider.totalAmount.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _handlePayment(context),
              child: const Text('Pay with Stripe'),
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 55)),
            ),
          ],
        ),
      ),
    );
  }
}