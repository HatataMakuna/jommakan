// ignore_for_file: prefer_const_constructors

// new email address
// new password
// repeat password - must be at least 8 characters

import 'package:flutter/material.dart';
//import 'AccountValidation.dart';

void main() => runApp(MaterialApp(home: CreateAccount()));

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CreateAccountState();
  }
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController = TextEditingController();
  bool isTyping = false;
  bool _showPassword = false;

  //final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Create Account'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: registerForm(),
      ),
    );
  }

  Widget registerForm() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            usernameField(),
            emailField(),
            passwordField(),
            repeatPasswordField(),
            registerButton(),
            // text fields
          ],
        ),
      ),
    );
  }

  Widget usernameField() {
    return TextField(
      controller: _nameController,
      decoration: InputDecoration(labelText: 'Username'),
    );
  }
  

  Widget emailField() {
    ////////////////////
    return TextField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Email (someone@example.com)',
        errorText: _emailErrorText(),
      ),
      onChanged: (value) => _validateEmail(value),
    );
  }

  Widget passwordField() {
    return TextField(
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: 'Password (minimum 8 characters)',
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
      obscureText: !_showPassword, // Hide or show password based on _showPassword value
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
      onChanged: (value) => _validatePassword(value),
      obscureText: !_showPassword, // Hide or show password based on _showPassword value
    );
  }

  Widget registerButton() {
    return ElevatedButton(
      onPressed: () {
        // Handle registration button logic
      },
      child: Text('Register Now'),
      style: ElevatedButton.styleFrom(
        elevation: 5, // Set the elevation (depth) of the button
        shadowColor: Colors.black, // Set the shadow color
      )
    );
  }

  void _validateEmail(String value) {
    setState(() => isTyping = true);
  }

  void _validatePassword(String value) {
    setState(() {});
  }

  // email error message
  String? _emailErrorText() {
    final text = _emailController.value.text;
    if (text.isEmpty) {
      return null; // 'Can't be empty'
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(text)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _passwordErrorText() {
    final text = _passwordController.value.text;
    if (text.isEmpty) {
      return null; // 'Can't be empty'
    } else if (text.length < 8) {
      return 'Password too short';
    }
    return null;
  }

  String? _repeatPasswordErrorText() {
    final textToCompare = _passwordController.value.text;
    final inputText = _repeatPasswordController.value.text;
    if (inputText != textToCompare) {
      return 'Password does not match';
    } else {
      return null;
    }
  }

  void registerUser() {
    // logic here
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}