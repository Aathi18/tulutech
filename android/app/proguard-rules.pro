# --- START Stripe R8/ProGuard Rules ---

# Rules for the core Stripe Android SDK (essential for payment processing)
-keep class com.stripe.android.** { *; }
-dontwarn com.stripe.android.**

# Rules specific to Push Provisioning components (which were causing the build failure)
-keep class com.stripe.android.pushProvisioning.** { *; }
-dontwarn com.stripe.android.pushProvisioning.**
-keep class com.reactnativestripesdk.** { *; }
-dontwarn com.reactnativestripesdk.**

# Rules for common libraries that Stripe may reference (e.g., Google Wallet for payments)
-keep class com.google.android.gms.wallet.** { *; }
-dontwarn com.google.android.gms.wallet.**

# Additional rules for Gson (Stripe uses it internally; prevents serialization crashes)
-keepattributes Signature
-keepattributes *Annotation*
-keep class sun.misc.Unsafe { *; }

# --- END Stripe R8/ProGuard Rules ---