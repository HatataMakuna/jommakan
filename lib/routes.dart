import 'package:flutter/material.dart';

// list of pages here
import 'pages/welcome.dart';
import 'pages/user/LoginPage.dart';
import 'pages/user/CreateAccountPage.dart';
import 'pages/user/ForgetPassword.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Define the initial route.
      initialRoute: '/',
      routes: {
        // Define named routes.
        '/': (context) => const Welcome(),
        '/user/login': (context) => const LoginPage(),
        '/user/create-account': (context) => const CreateAccount(),
        '/user/forget-password': (context) => ForgetPasswordPage(),
      },
    );
  }
}