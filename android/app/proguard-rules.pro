--- START Stripe R8/ProGuard Rules ---

Rules for the core Stripe Android SDK (essential for payment processing)

-keep public class com.stripe.android.** { ; }
-dontwarn com.stripe.android.*

Rules specific to Push Provisioning components (which were causing the build failure)

-keep class com.reactnativestripesdk.** { ; }
-dontwarn com.reactnativestripesdk.*

Rules for common libraries that Stripe may reference

-keep class com.google.android.gms.wallet.** { ; }
-dontwarn com.google.android.gms.wallet.*

--- END Stripe R8/ProGuard Rules ---