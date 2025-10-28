# 🛒 **TuluTech E-commerce Mobile Application (Flutter)**

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-v3.13.0+-blue?logo=flutter&logoColor=white" alt="Flutter Version"/>
  <img src="https://img.shields.io/badge/Dart-v3.1.0+-blue?logo=dart&logoColor=white" alt="Dart Version"/>
  <img src="https://img.shields.io/badge/Stripe-Payments-8A2BE2?logo=stripe&logoColor=white" alt="Stripe"/>
  <img src="https://img.shields.io/badge/Platform-Android%20|%20iOS-success?logo=android&logoColor=white" alt="Platform"/>
</p>

---

## 🌟 **Overview**

This project is a **mobile e-commerce application** built with **Flutter** and **Dart**.  
The primary focus of this submission was the **successful implementation of a secure payment checkout flow using the Stripe SDK**.

---

## ✨ **Key Features**

✅ **Payment Integration** – Seamless checkout process using the `flutter_stripe` package.  
🎨 **Splash Screen** – Branded startup experience featuring the **Tulu Tech logo** with animation.  
🔐 **Authentication** – Basic user sign-in and registration using Firebase Auth.  
🛍️ **Product Catalog** – Displays a list of mock e-commerce products (fetched from DummyJSON API).  
🧺 **Shopping Cart** – Add, manage, and remove items before checkout with persistent storage.  
💳 **Stripe Payment Sheet** – Smooth in-app payment experience in **test mode**.

---

## 💳 **Stripe Payment Integration**

The **core deliverable** was integrating the **Stripe Payment Sheet** for handling transactions securely and efficiently.

### 🧩 Implementation Details

| Layer | Description |
|:--|:--|
| **Service Layer** | All payment logic is encapsulated in `lib/services/stripe_service.dart`. |
| **Client Secret** | Application initializes and uses a Payment Intent client secret (mocked server-side) for secure Stripe communication. |
| **Test Mode** | All payments were executed in **Stripe’s Sandbox environment** using test keys. |

---

## 🖼️ **Visual Proof of Payment Flow**

| Screen | Description |
|:--|:--|
| 🏠 **Product Listing** | Main screen showing available products. |
| 🛒 **Your Cart** | Displays selected items and calculated totals. |
| 📦 **Checkout / Order Summary** | Final confirmation before opening Stripe Sheet. |
| 💳 **Stripe Payment Sheet** | Card details entered using test card `4242 4242 4242 4242`. |
| ✅ **Payment Success** | Final confirmation screen after a successful transaction. |

---

## ⚙️ **Setup & Installation**

### 🧰 **Prerequisites**
- Flutter SDK **v3.13.0+**
- Dart SDK **v3.1.0+**
- Android Studio or VS Code with Flutter extensions
- Android/iOS device or emulator

---

### 🚀 **Running the Project**

1️⃣ **Clone the Repository**
```bash
git clone https://github.com/Aathi18/tulutech.git
cd tulutech

2️⃣ Install Dependencies

flutter pub get

3️⃣ Set Stripe Keys

Edit your config or environment file and add your Stripe Publishable Key.

4️⃣ Run the App
flutter run

⚠️ Known Impediments
🧩 Issue	🔧 Resolution / Status
Stripe Secret Expiration	Stripe PaymentIntent client secrets expire quickly — manual refresh required during testing. ✅
SDK Parameter Mismatch	Fixed by removing invalid amount and currency from SetupPaymentSheetParameters. ✅
Flutter Cache Error	Resolved Couldn't find constructor 'SplashScreen' by running flutter clean. ✅
