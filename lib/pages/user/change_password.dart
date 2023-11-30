import 'package:flutter/material.dart';
import 'package:jom_makan/server/user/user_profile.dart';
import 'package:jom_makan/stores/user_provider.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<StatefulWidget> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final UserProfile _userProfile = UserProfile();
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _repeatPasswordController = TextEditingController();

  String? _passwordError;
  String? _repeatPasswordError;
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Change Password',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            currentPassword(),
            const SizedBox(height: 15),
            newPassword(),
            const SizedBox(height: 15),
            repeatPassword(),
            const SizedBox(height: 15),
            saveButton(),
          ],
        ),
      ),
    );
  }

  Widget currentPassword() {
    return TextField(
      controller: _currentPasswordController,
      obscureText: true,
      decoration: const InputDecoration(labelText: 'Current Password'),
    );
  }

  Widget newPassword() {
    return TextField(
      controller: _newPasswordController,
      decoration: InputDecoration(
        labelText: 'New Password (minimum 8 characters)',
        errorText: _passwordError,

        // "Show Password" icon
        suffixIcon: IconButton(
          icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              _showPassword = !_showPassword;
            });
          },
        ),
      ),
      onChanged: (value) => _validatePassword(value),
      obscureText: !_showPassword,
    );
  }

  Widget repeatPassword() {
    return TextField(
      controller: _repeatPasswordController,
      decoration: InputDecoration(
        labelText: 'Repeat New Password',
        errorText: _repeatPasswordError,

        // "Show Password" icon
        suffixIcon: IconButton(
          icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              _showPassword = !_showPassword;
            });
          },
        ),
      ),
      onChanged: (value) => _validateRepeatPassword(value),
      obscureText: !_showPassword, 
    );
  }

  void _validatePassword(String value) {
    if (value.length < 8) {
      _passwordError = 'Password must be at least 8 characters';
    } else {
      _passwordError = null;
    }
    setState(() {});
  }

  void _validateRepeatPassword(String value) {
    if (value != _newPasswordController.text) {
      _repeatPasswordError = 'Passwords do not match';
    } else {
      _repeatPasswordError = null;
    }
    setState(() {});
  }

  Widget saveButton() {
    return ElevatedButton(
      onPressed: _saveChanges,
      child: const Text('Save Changes'),
    );
  }

  void _saveChanges() async {
    int userID = Provider.of<UserProvider>(context, listen: false).userID!;
    final String currentPassword = _currentPasswordController.text;
    final String newPassword = _newPasswordController.text;
    final String repeatPassword = _repeatPasswordController.text;

    // Validate the inputs
    _validatePassword(newPassword);
    _validateRepeatPassword(repeatPassword);

    // Check for empty inputs
    if (currentPassword.isEmpty || newPassword.isEmpty || repeatPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in the missing fields')),
      );
      return;
    }
    if (_passwordError != null || _repeatPasswordError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fix the password errors')),
      );
      return;
    }

    // Check if the current password matches with the database
    bool isCurrentPasswordMatch = await _userProfile.checkCurrentPassword(userID, currentPassword);

    if (!isCurrentPasswordMatch) {
      showInvalidCurrentPasswordMessage();
    } else {
      // If there are no errors, show confirmation message
      showConfirmationMessage();
    }
  }

  void showInvalidCurrentPasswordMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Invalid current password')),
    );
  }

  void showConfirmationMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Are you sure you want to save your changes?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            ElevatedButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog

                // Update the new password
                updatePassword(_newPasswordController.text);
              },
            ),
          ],
        );
      }
    );
  }

  void updatePassword(String newPassword) async {
    int userID = Provider.of<UserProvider>(context, listen: false).userID!;
    bool isUpdateSuccessful = await _userProfile.updatePassword(userID, newPassword);

    if (isUpdateSuccessful) {
      showUpdateSuccessfulMessage();
    } else {
      showUpdateFailedMessage();
    }
  }

  void showUpdateSuccessfulMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully')),
    );
  }

  void showUpdateFailedMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Failed to update profile. Please try again.')),
    );
  }
}