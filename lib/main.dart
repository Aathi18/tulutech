import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

// Import services and providers
import 'services/auth_service.dart';
import 'providers/auth_provider.dart'; 
import 'providers/cart_provider.dart';
import 'screens/splash_screen.dart'; // NEW: Import the splash screen
import 'services/stripe_service.dart'; 

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
 
  // NOTE: In a real environment, __firebase_config and __initial_auth_token are needed for Firebase init
  // For the sake of local testing, we assume Firebase is initialized correctly.
  try {
    await Firebase.initializeApp();
  } catch(e) {
    // Handle error if Firebase setup is incomplete
    print("Error initializing Firebase: $e");
  }
  
 await StripeService.init(); 
 runApp(const TuluTechEcommerceApp());
}

class TuluTechEcommerceApp extends StatelessWidget {
 const TuluTechEcommerceApp({super.key});

 @override
 Widget build(BuildContext context) {
 return MultiProvider(
 providers: [
 // 1. Session Persistence: Provides the current Firebase User (User?)
 StreamProvider.value(
 value: AuthService().user,
 initialData: null,
 catchError: (_, __) => null,
 ),
 // 2. Auth Actions & Loading: Provides functions for login/register and manages loading state
 ChangeNotifierProvider(create: (_) => AuthProvider()), 
 
 // 3. Cart Management: Provides cart data and persistence logic
 ChangeNotifierProvider(create: (_) => CartProvider()),
],
 child: MaterialApp(
 title: 'Tulu Tech Shop',
          theme: ThemeData(
          primarySwatch: Colors.blue, 
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.grey.shade50,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue.shade900,
            elevation: 1,
          )
        ),
      // Start with the SplashScreen
      home: const SplashScreen(), 
 ),
 );
 }
}