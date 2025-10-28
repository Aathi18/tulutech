🛒 TuluTech E-commerce Mobile Application (Flutter)

🌟 Overview

This project is a mobile e-commerce application built with Flutter and Dart. The primary focus of this submission was the successful implementation of a secure payment checkout flow using the Stripe SDK.

✨ Key Features

Payment Integration: Seamless checkout process using the flutter_stripe package.

Splash Screen: A branded startup experience for enhanced polish.

Authentication: Basic user sign-in and registration flow.

Product Catalog: Displays a list of mock e-commerce products.

Shopping Cart: Allows users to add, manage, and remove items before checkout.

💳 Stripe Payment Integration

The core deliverable was integrating the Stripe Payment Sheet to handle transactions. The service layer is isolated to ensure clean architecture.

Implementation Details

Service Layer: All payment logic is encapsulated in lib/services/stripe_service.dart.

Client Secret: The application correctly initializes and uses a Payment Intent client secret (mocked server-side creation) to communicate securely with Stripe.

Test Environment: All transactions are run in Stripe's Sandbox mode using test keys.

Visual Proof of Payment Flow

The following screenshots demonstrate the successful flow using the Stripe test card (4242...):

Screen

Description

Product Listing

Main screen showing available products.





Your Cart

Items selected and total calculated.





Checkout/Order Summary

Final confirmation before launching the Stripe sheet.





Stripe Payment Sheet

Card details entered using the test card (4242...).





Payment Success

Final confirmation screen after a successful transaction.





⚙️ Setup and Installation

Prerequisites

Flutter SDK installed (v3.13.0+ recommended)

Dart SDK (v3.1.0+ recommended)

An Android or iOS device/emulator for running the application.

Running the Project

Clone the Repository:

git clone [https://github.com/Aathi18/tulutech.git](https://github.com/Aathi18/tulutech.git)
cd tulutech


Get Dependencies:

flutter pub get


Run the App:

flutter run


(Note: You must set your Stripe Publishable Key in the application's configuration before running.)

⚠️ Known Impediments

The primary challenge encountered during development was related to the security and short lifespan of Stripe Payment Intent secrets.

Issue

Resolution/Status

Stripe Secret Expiration

Manually refreshing the pi_... client secret was necessary for successful testing. This confirms that a secure, dynamic backend server implementation is required for production.

SDK Parameter Mismatch

Fixed a compilation error by removing invalid amount and currency parameters when initializing SetupPaymentSheetParameters.

Import/Cache Issues

Resolved repeated Couldn't find constructor 'SplashScreen' errors by clearing the cache (flutter clean).
