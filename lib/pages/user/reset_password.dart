import 'package:flutter/material.dart';
import 'package:jom_makan/server/user/reset_password.dart';

class ResetPassword extends StatefulWidget {
  final String email;
  const ResetPassword({super.key, required this.email});

  @override
  State<StatefulWidget> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final ResetPasswordLogic _resetPassword = ResetPasswordLogic();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController = TextEditingController();
  bool _showPassword = false;
  bool _isRegistering = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),

    );
  }

  Widget loadPasswordFields() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            enterNewPasswordField(),
            const SizedBox(height: 20),
            repeatPasswordField(),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget enterNewPasswordField() {
    return TextField(
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: 'New Password (minimum 8 characters)',
        errorText: _passwordErrorText(),

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

  Widget repeatPasswordField() {
    return TextField(
      controller: _repeatPasswordController,
      decoration: InputDecoration(
        labelText: 'Repeat Password',
        errorText: _repeatPasswordErrorText(),
        
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
      obscureText: !_showPassword, // Hide or show password based on _showPassword value
    );
  }

  Widget resetPasswordButton() {
    return ElevatedButton(
      onPressed: _hasEmptyFields() || _hasErrors() ? null : () {
        setState(() {
          _isRegistering = true;
        });

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirmation'),
              content: const Text('Are you sure you want to reset your password?'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
                ElevatedButton(
                  child: const Text('Register'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    executeResetPassword();
                  },
                ),
              ],
            );
          }
        );
      },
      style: ElevatedButton.styleFrom(
        elevation: 5, // Set the elevation (depth) of the button
        shadowColor: Colors.black, // Set the shadow color
      ),
      child: const Text('Reset Password'),
    );
  }

  String? _passwordErrorText() {
    final text = _passwordController.value.text;
    if (text.isEmpty) {
      return null;
    } else if (text.length < 8) {
      return 'Password too short';
    }
    return null;
  }

  String? _repeatPasswordErrorText() {
    if (_isRegistering) {
      final textToCompare = _passwordController.value.text;
      final inputText = _repeatPasswordController.value.text;
      if (inputText != textToCompare) {
        return 'Password does not match';
      } else {
        return null;
      }
    }
    return null;
  }

  void _validatePassword(String value) {
    setState(() {});
  }

  void _validateRepeatPassword(String value) {
    setState(() {});
  }

  bool _hasErrors() {
    return _passwordErrorText() != null ||
      _repeatPasswordErrorText() != null;
  }

  bool _hasEmptyFields() {
    return _passwordController.text.isEmpty ||
      _repeatPasswordController.text.isEmpty;
  }

  void executeResetPassword() async {
    bool isSuccess = await _resetPassword.resetPassword(
      newPassword: _passwordController.text, email: widget.email
    );
    _loadResetPasswordResult(isSuccess);
  }

  void _loadResetPasswordResult(bool isSuccess) {
    if (isSuccess) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Reset Password Successful'),
            content: const Text('Your password has been successfully reset. You can now login with your new password.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  // Reset the registration status when canceling
                  setState(() {
                    _isRegistering = false;
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
              ElevatedButton(
                onPressed: goToLogin,
                child: const Text('Go to Login'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sorry'),
            content: const Text('An error occurred while attempting to reset your password. Please try again later.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),
              )
            ]
          );
        }
      );
    }
  }

  void goToLogin() {
    print("Navigating to login page");
    setState(() {
      Navigator.pushNamed(context, '/user/login');
    });
  }
}