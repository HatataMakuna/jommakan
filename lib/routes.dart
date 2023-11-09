// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

// list of pages here
import 'pages/welcome.dart';
import 'pages/user/login.dart';
import 'pages/user/create_account.dart';
import 'pages/user/forget_password.dart';

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
        //'/home': (context) => 
      },
    );
  }
}