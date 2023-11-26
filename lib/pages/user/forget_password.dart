import 'package:flutter/material.dart';
import 'package:jom_makan/pages/user/reset_password.dart';
import 'package:jom_makan/server/user/check_user_exists.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<StatefulWidget> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final CheckUserExists _checkUserExists = CheckUserExists();
  final TextEditingController _emailController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_vaildateEmail);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _vaildateEmail() {
    final email = _emailController.text;
    bool isValidEmail = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(email);
    setState(() {
      _isButtonEnabled = isValidEmail;
    });
  }

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forget Password'),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
        ),
      ),
      body: emailField(),
    );
  }

  Widget emailField() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Please enter your email to reset your password.',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _isButtonEnabled ? _resetPassword : null,
            // send the reset password link to the input email
            child: const Text('Reset Password'),
          ),
        ],
      ),
    );
  }

  void _resetPassword() async {
    bool isExists = await _checkUserExists.checkUser(email: _emailController.text);
    _loadUserExistsResult(isExists);
  }

  void _loadUserExistsResult(bool isExists) {
    if (isExists) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResetPassword(email: _emailController.text),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sorry'),
            content: const Text('The email you provided does not exist in our database.'),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        }
      );
    }
  }
}