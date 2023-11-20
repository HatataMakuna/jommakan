import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jom_makan/stores/user_provider.dart';

class MePage extends StatelessWidget {
  const MePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    // Access the user name from the provider
    String? userName = Provider.of<UserProvider>(context).userName;

    return Scaffold(
      appBar: null,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          // Account circle symbol with the username
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.account_circle, size: 95),
              const SizedBox(width: 50),
              Text(
                '$userName',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Buttons List
          Expanded(
            child: ListView(
              children: [
                // Light blue buttons
                _buildButton(context, 'Edit profile', 0xFFC2EAFF),
                _buildButton(context, 'Order history', 0xFFC2EAFF),
                _buildButton(context, 'Pick up order', 0xFFC2EAFF),
                _buildButton(context, 'Edit Review', 0xFFC2EAFF),
                // Light yellow buttons
                _buildButton(context, 'My Rewards', 0xFFFFE5BA),
                _buildButton(context, 'My Favourites', 0xFFFFE5BA),
                // Light red buttons
                _buildButton(context, 'Logout', 0xFFFFEFEF),
              ],
            ),
          ),
        ]
      )
    );
  }

  Widget _buildButton(BuildContext context, String label, int colorHex) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ElevatedButton(
        onPressed: () {
          if (label == 'Edit profile') {
            // Navigate to edit profile page
            Navigator.of(context).pushNamed('/user/edit-profile');
          }
          else if (label == 'Logout') {
            // Show logout confirmation dialog
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return logoutConfirmation(context);
              },
            );
          } else {
            // Handle other button clicks
          }
        },
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(colorHex),
          minimumSize: const Size(double.infinity, 1), // removes space between buttons
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // no border radius
          ),
        )
      )
    );
  }

  // Logout
  Widget logoutConfirmation(BuildContext context) {
    return AlertDialog(
      content: const Text('Are you sure you want to logout?'),
      actions: [
        ElevatedButton(
          onPressed: () {
            Provider.of<UserProvider>(context, listen: false).logout(); // performs logout logic
            Navigator.of(context).pop(); // Close the dialog
            Navigator.of(context).pushReplacementNamed('/user/login'); // Navigate to login page
          },
          child: const Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog without performing logout logic
          },
          child: const Text('No'),
        ),
      ]
    );
  }
}