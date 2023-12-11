import 'package:flutter/material.dart';
import 'package:jom_makan/pages/user/login.dart';
import 'package:jom_makan/stores/user_provider.dart';
import 'package:provider/provider.dart';

class LogoutView extends StatelessWidget {
  const LogoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: AlertDialog(
          title: const Text('Confirm Logout?'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {},
            ),
            ElevatedButton(
              child: const Text('Yes'),
              onPressed: () {
                //Navigator.of(context).pop();
                Provider.of<UserProvider>(context, listen: false).logout();

                logout(context);
              }
            ),
          ],
        ),
      ),
    );
  }

  void logout(BuildContext context) {
    // Pop until the root route
    //Navigator.popUntil(context, ModalRoute.withName('/'));

    Navigator.pushReplacement(
      context, MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }
}