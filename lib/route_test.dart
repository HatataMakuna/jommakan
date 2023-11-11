// THIS FILE IS ONLY FOR EASE OF TESTING PURPOSE

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'stores/user_provider.dart'; // Import the UserProvider class

import 'pages/main/main_page.dart';
import 'pages/user/create_account.dart';
import 'pages/user/forget_password.dart';
import 'pages/user/login.dart';

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
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(), // Change this to which page you want the testing process to start with
        '/user/create-account': (context) => const CreateAccount(),
        '/user/forget-password': (context) => ForgetPasswordPage(),
        '/home': (context) => const MainPage(),
      },
    );
  }
}
