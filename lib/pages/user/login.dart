import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jom_makan/stores/user_provider.dart';
import 'package:jom_makan/server/user/login_user.dart';
import 'package:jom_makan/components/logo.dart';

//void main() => runApp(MaterialApp(home: LoginPage()));

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<LoginPage> {
  bool? check = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginUser _loginUser = LoginUser(); // Instantiate LoginUser class
  final Logo _logo = Logo();

  String _errorText = ''; // To store error text

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        /* leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ), */
      ),
      body: loginForm(context),
    );
  }

  /* ********** */
  // Login form //
  /* ********** */
  Widget loginForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            _logo.getLogoImage(),
            const SizedBox(height: 20),
            if (_errorText.isNotEmpty) // Show error text if login failed
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(_errorText, style: const TextStyle(color: Colors.red)),
              ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'EMAIL ADDRESS')
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'PASSWORD'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            rememberMeChkBox(),
            const SizedBox(height: 40),
            forgetPasswordBtn(context),
            const SizedBox(height: 20),
            loginBtn(context),
            const SizedBox(height: 20),
            createAccountBtn(context),
            const SizedBox(height: 20),
            // footer image
            _logo.getLogoWithTarumt(),
          ],
        ),
      ),
    );
  }
  
  Widget rememberMeChkBox() {
    return Row(
      children: [
        Checkbox(
          hoverColor: Colors.grey,
          value: check,
          onChanged: (bool? value) {
            setState(() {
              check = value;
            });
          },
        ),
        const Text('REMEMBER ME'),
      ],
    );
  }

  Widget forgetPasswordBtn(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, '/user/forget-password'),
      child: const Text('FORGET PASSWORD?'),
    );
  }

  Widget loginBtn(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _performLogin(context), // go to user dashboard / home
      child: const Text('Login'),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  Widget createAccountBtn(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Don\'t have account?'),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, '/user/create-account'), // go to register account page
          child: const Text(
            'Create new account',
            style: TextStyle(
              color: Colors.yellow,
            ),
          ),
        ),
      ],
    );
  }

  // Function to perform login
  void _performLogin(BuildContext context) async {
    String email = _emailController.text;
    String password = _passwordController.text;

    // Call the loginUser function from LoginUser class
    var loginResult = await _loginUser.loginUser(email: email, password: password);

    if (loginResult['success']) {
      // Login was successful, get the username
      var username = loginResult['username'];
      var userID = loginResult['userID'];

      // update the user name in the provider
      Provider.of<UserProvider>(context, listen: false).setUserName(username);
      Provider.of<UserProvider>(context, listen: false).setUserID(userID);

      // navigate to the home page
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Login failed, show an error message
      setState(() {
        _errorText = 'Invalid email or password';
      });

      // Clear the password field
      _passwordController.clear();
    }
  }
}
