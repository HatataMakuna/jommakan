// ignore_for_file: use_key_in_widget_constructors
// THE OFFICIAL ROUTES PAGE

import 'package:flutter/material.dart';
import 'package:jom_makan/pages/order/order_history.dart';
import 'package:provider/provider.dart';
import 'package:jom_makan/stores/user_provider.dart'; // Import the UserProvider class
import 'package:jom_makan/pages/main/main_page.dart';
import 'package:jom_makan/pages/welcome.dart';
import 'package:jom_makan/pages/user/edit_profile.dart';
import 'package:jom_makan/pages/user/login.dart';
import 'package:jom_makan/pages/user/create_account.dart';
import 'package:jom_makan/pages/user/forget_password.dart';
import 'package:jom_makan/pages/search/search.dart';

void main() => runApp(
  ChangeNotifierProvider(
    create: (context) => UserProvider(),
    child: const MyApp(),
  )
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    // Access the user name from the provider
    String? userName = Provider.of<UserProvider>(context).userName;

    return MaterialApp(
      // Define the initial route.
      initialRoute: '/',
      routes: {
        // Define named routes.
        '/': (context) => const Welcome(),
        '/user/login': (context) => const LoginPage(),
        '/user/create-account': (context) => const CreateAccount(),
        '/user/forget-password': (context) => ForgetPasswordPage(),
        '/user/edit-profile': (context) => EditProfile(username: userName.toString()),
        '/user/order-history': (context) => const OrderHistoryPage(),
        '/home': (context) => const MainPage(),
        '/search': (context) => const SearchPage(),
      },
    );
  }
}