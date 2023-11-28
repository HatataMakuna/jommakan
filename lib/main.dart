// ignore_for_file: use_key_in_widget_constructors
// THE OFFICIAL ROUTES PAGE
import 'package:flutter/material.dart';
import 'package:jom_makan/access_denied.dart';
import 'package:jom_makan/pages/order/order_history.dart';
import 'package:jom_makan/pages/rider/rider_info.dart';
import 'package:provider/provider.dart';
import 'package:jom_makan/stores/user_provider.dart'; // Import the UserProvider class
import 'package:jom_makan/pages/main/main_page.dart';
import 'package:jom_makan/pages/welcome.dart';
import 'package:jom_makan/pages/user/edit_profile.dart';
import 'package:jom_makan/pages/user/login.dart';
import 'package:jom_makan/pages/user/create_account.dart';
import 'package:jom_makan/pages/user/forget_password.dart';
import 'package:jom_makan/pages/search/search.dart';
import 'package:jom_makan/pages/Admin/admin_main.dart';

void main() {
  //debugCheckHasMaterialLocalizations(BuildContext context);
  //debugCheckHasDirectionality(BuildContext context);
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    // Access the user name from the provider
    String? userName = Provider.of<UserProvider>(context).userName;

    bool hasRequiredRole(BuildContext context, String requiredRole) {
      String? userRole = Provider.of<UserProvider>(context).userRole;
      return userRole == requiredRole;
    }

    return MaterialApp(
      // Define the initial route.
      initialRoute: '/',
      routes: {
        // Both users accessible
        '/': (context) => const Welcome(),
        '/user/login': (context) => const LoginPage(),
        '/user/create-account': (context) => const CreateAccount(),
        '/user/forget-password': (context) => const ForgetPasswordPage(),

        // Users only
        '/user/edit-profile': (context) => hasRequiredRole(context, 'User') ? EditProfile(username: userName.toString()) : const AccessDeniedPage(),
        '/user/order-history': (context) => hasRequiredRole(context, 'User') ? const OrderHistoryPage() : const AccessDeniedPage(),
        '/home': (context) => hasRequiredRole(context, 'User') ? const MainPage() : const AccessDeniedPage(),
        '/search': (context) => hasRequiredRole(context, 'User') ? const SearchPage() : const AccessDeniedPage(),
        '/rider/rider-info': (context) => hasRequiredRole(context, 'User') ? const RiderInfo() : const AccessDeniedPage(),

        // Admin only
        '/admin': (context) => hasRequiredRole(context, 'Admin') ? const AdminMainPage() : const AccessDeniedPage(),
      },
    );
  }
}