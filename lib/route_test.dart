// THIS FILE IS ONLY FOR EASE OF TESTING PURPOSE

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'stores/user_provider.dart'; // Import the UserProvider class

import 'pages/main/main_page.dart';
import 'pages/user/create_account.dart';
import 'pages/user/edit_profile.dart';
import 'pages/user/forget_password.dart';
import 'pages/user/login.dart';
import 'pages/search/search.dart';

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
    // Schedule the modification after the build phase has completed
    Future.delayed(Duration.zero, () {
      Provider.of<UserProvider>(context, listen: false).setUserName('Testing');
    });
    
    // Access the user name from the provider
    String? userName = Provider.of<UserProvider>(context).userName;

    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const MainPage(), // Change this to which page you want the testing process to start with
        '/user/login': (context) => const LoginPage(),
        '/user/create-account': (context) => const CreateAccount(),
        '/user/forget-password': (context) => ForgetPasswordPage(),
        '/user/edit-profile': (context) => EditProfile(username: userName.toString()),
        '/home': (context) => const MainPage(),
        '/search': (context) => const SearchPage(),
      },
    );
  }
}
