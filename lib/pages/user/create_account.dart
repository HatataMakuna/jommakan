import 'package:flutter/material.dart';
import 'package:jom_makan/server/register.dart';

//void main() => runApp(const MaterialApp(home: CreateAccount()));

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
  final Register _register = Register(); // Instantiate Register (server-side) class

  //final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: registerForm(),
    );
  }

  Widget registerForm() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            nameField(),
            const SizedBox(height: 20),
            emailField(),
            const SizedBox(height: 20),
            passwordField(),
            const SizedBox(height: 20),
            repeatPasswordField(),
            const SizedBox(height: 40),
            registerButton(),
            // text fields
          ],
        ),
      ),
    );
  }

  // Text Fields
  Widget nameField() {
    return TextField(
      controller: _nameController,
      decoration: const InputDecoration(labelText: 'Name'),
    );
  }

  Widget emailField() {
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
      onChanged: (value) => _validateRepeatPassword(value),
      obscureText: !_showPassword, // Hide or show password based on _showPassword value
    );
  }

  // Register Button
  Widget registerButton() {
    return ElevatedButton(
      // Disable the button if there are errors or empty fields
      onPressed: _hasEmptyFields() || _hasErrors() ? null : () {
        // confirm register
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirm Registration?'),
              content: const Text('Are you sure you want to register?'),
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
                    registerUser(); // Call the registerUser function
                  }
                )
              ]
            );
          },
        );
      },
      child: const Text('Register Now'),
      style: ElevatedButton.styleFrom(
        elevation: 5, // Set the elevation (depth) of the button
        shadowColor: Colors.black, // Set the shadow color
      ),
    );
  }

  // Validations
  void _validateEmail(String value) {
    setState(() => isTyping = true);
  }

  void _validatePassword(String value) {
    setState(() {});
  }

  void _validateRepeatPassword(String value) {
    setState(() {});
  }

  // Navigate to login page
  void goToLogin() {
    print("Navigating to login page");
    setState(() {
      Navigator.pushNamed(context, '/user/login');
    });
  }

  // Error Messages
  String? _emailErrorText() {
    final text = _emailController.value.text;
    if (text.isEmpty) {
      return null;
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(text)) {
      return 'Please enter a valid email';
    }
    return null;
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
    final textToCompare = _passwordController.value.text;
    final inputText = _repeatPasswordController.value.text;
    if (inputText != textToCompare) {
      return 'Password does not match';
    } else {
      return null;
    }
  }

  // Check whether the registration form has any errors
  bool _hasErrors() {
    return _emailErrorText() != null ||
      _passwordErrorText() != null ||
      _repeatPasswordErrorText() != null;
  }

  // Check whether the registration form has any empty fields
  bool _hasEmptyFields() {
    return _nameController.text.isEmpty || 
      _emailController.text.isEmpty ||
      _passwordController.text.isEmpty ||
      _repeatPasswordController.text.isEmpty;
  }

  // Passing the data to "server/register.dart" for performing the server-side script
  void registerUser() async {
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    bool registrationResult = await _register.registerUser(
      name: name, email: email, password: password,
    );

    if (registrationResult) {
      // Registration was successful, handle navigation or other tasks here
      _showSuccessDialog();
    } else {
      // Registration failed, show an error message or handle it accordingly
      _showFailureDialog();
    }
  }

  // Show dialog message where the user has been successfully registered
  Future<void> _showSuccessDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registration Successful'),
          content: const Text('You have been successfully registered.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
            ElevatedButton(
              onPressed: goToLogin,
              child: const Text('Go to Login'),
            ),
          ]
        );
      }
    );
  }

  // Show dialog message where registration failed
  Future<void> _showFailureDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registration Failed'),
          content: const Text('Sorry, registration failed. Please try again.'),
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

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}