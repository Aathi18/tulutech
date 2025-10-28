import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter/material.dart';

class StripeService {
  // Use your TEST publishable key here (safe to include in app)
  static String publishableKey = "pk_test_51SMQft08XMrGrb4oWMrQn8X8VQR852GW5Muj8j7EgvaLXPov88rfbE9q2jCDEwuvdCXx72mn7Jn22O2IJ08FGUVA00C2dx0gaR"; 

  static Future<void> init() async {
    Stripe.publishableKey = publishableKey;
  }

  // MOCK function: This MUST be an HTTP call to your secure backend in a real app.
  Future<Map<String, dynamic>> _createPaymentIntent(int amount, String currency) async {
    print("MOCK: Calling backend to create Payment Intent for $amount $currency...");
    
    // *** PASTE THE NEW, FRESH SETUP INTENT client_secret HERE (seti_..._secret_...) ***
    // Using a Setup Intent secret to bypass the expiring Payment Intent secret issue
    const validClientSecret = 'pi_3SND3o08XMrGrb4o0eU0EvEy_secret_dXyzg5ScqSMdAs2ckGmBMPEC8'; 
    
    return {
      // NOTE: We still use 'client_secret' as the key for the Payment Sheet
      'client_secret': validClientSecret, 
      'status': 'requires_payment_method', // Use this status for consistency
    };
  }

  // Amount is now expected in the smallest currency unit (cents)
  Future<bool> makePayment(int amount, String currency, BuildContext context) async {
    try {
      final paymentIntentData = await _createPaymentIntent(amount, currency); 
      
      // Initialize the Payment Sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // The key difference is we must include the amount and currency 
          // here since we are using a Setup Intent secret.
         // amount: amount, 
         // currency: currency, 
          paymentIntentClientSecret: paymentIntentData['client_secret'],
          merchantDisplayName: 'Tulu Tech Shop',
          style: ThemeMode.light, 
        ),
      );

      // Present the Payment Sheet and confirm payment
      await Stripe.instance.presentPaymentSheet();
      
      // Payment successful
      return true;

    } on StripeException catch (e) {
      // Payment failure 
      print('Stripe Error: ${e.error.code} - ${e.error.message}');
      return false;
    } catch (e) {
      // General failure 
      print('General Payment Error: $e');
      return false;
    }
  }
}