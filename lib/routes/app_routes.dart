import 'package:flutter/material.dart';
import 'package:foodeck_app/screens/checkout_screen/checkout_screen.dart';
import 'package:foodeck_app/screens/create_account/create_account_screen.dart';
import 'package:foodeck_app/screens/create_account/otp_screen.dart';
import 'package:foodeck_app/screens/food_variantions_screen/food_variations_screen.dart';

import 'package:foodeck_app/screens/home_screen/home_screen.dart';
import 'package:foodeck_app/screens/login_screen/forgot_password_screen.dart';
import 'package:foodeck_app/screens/login_screen/login_screen.dart';
import 'package:foodeck_app/screens/login_screen/login_via_email_screen.dart';
import 'package:foodeck_app/screens/profile_screen/edit_profile_screen/edit_profile_screen.dart';
import 'package:foodeck_app/screens/profile_screen/your_locations/my_locations_on_map.dart';
import 'package:foodeck_app/screens/profile_screen/payment_method_screen/payment_method_screen.dart';
import 'package:foodeck_app/screens/splash_screen/splash_screen.dart';
import 'package:foodeck_app/screens/explore_screen/explore_screen.dart';
import 'package:foodeck_app/screens/notification_screen/notification_screen.dart';
import 'package:foodeck_app/screens/profile_screen/profile_screen.dart';
import 'package:foodeck_app/screens/saved_screen.dart/saved_screen.dart';

class AppRoutes {
  static String splashScreen = "/splash_screen";
  static String loginScreen = "/login_screen";
  static String loginViaEmail = "/login_via_email_screen";
  static String createAccount = "/create_account_screen";
  static String otpScreen = "/otp_screen";
  static String forgotPassword = "/forgot_password_screen";
  static String homeScreen = "/home_screen";
  static String exploreScreen = "/explore_screen";
  static String savedScreen = "/saved_screen";
  static String notificationScreen = "/notification_screen";
  static String profileScreen = "/profile_screen";
  static String editProfileScreen = "/edit_profile_screen";
  static String paymentMethodScreen = "/payment_method_screen";
  static String myLocationScreen = "/my_location_screen";
  static String foodVariantionsScreen = "/food_variantions_screen";
  static String checkOutScreen = "/checkout_screen";

  ///
  ///
  ///
  ///
  static Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => const SplashScreen(),
    loginScreen: (context) => const LoginScreen(),
    loginViaEmail: (context) => const LoginViaEmailScreen(),
    createAccount: (context) => const CreateAccountScreen(),
    otpScreen: (context) => const OTPScreen(
          email: '',
          name: '',
          phone: '',
          password: '',
        ),
    forgotPassword: (context) => const ForgotPasswordScreen(),
    homeScreen: (context) => const HomeScreen(page: 0),
    exploreScreen: (context) => const ExploreScreen(),
    savedScreen: (context) => const SavedScreen(),
    notificationScreen: (context) => const NotificationScreen(),
    profileScreen: (context) => const ProfileScreen(),
    editProfileScreen: (context) => const EditProfileScreen(),
    paymentMethodScreen: (context) => const PaymentMethodScreen(),
    myLocationScreen: (context) => const MyLocationsOnMap(),
    foodVariantionsScreen: (context) => const FoodVariantionsScreen(
          dealsItemInfo: null,
          exploreMoreItemInfo: null,
          dealsItemInfomation: null,
          location: '',
          popularsItemInfo: null,
        ),
    checkOutScreen: (context) => const CheckOutScreen(
          subtotal: '',
          deliverfee: '',
          vat: '',
          coupon: '',
          total: '',
        ),
  };
}
