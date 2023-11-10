// ignore_for_file: prefer_const_constructors

/*
TASKS OUTSIDE THIS FILE
- Change the logo
*/

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: LoginPage()));

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<LoginPage> {
  bool? check = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
      ),
    );
  }

  /* ********** */
  // Login form //
  /* ********** */
  Widget loginForm(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            getLogoImage(),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'EMAIL ADDRESS',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'PASSWORD',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            rememberMeChkBox(),
            SizedBox(height: 40),
            forgetPasswordBtn(context),
            SizedBox(height: 20),
            loginBtn(context),
            SizedBox(height: 20),
            createAccountBtn(context),
            SizedBox(height: 20),
            // footer image
            Image(
              image: ResizeImage(
                AssetImage('images/jm-tarumt-logo.png'),
                width: 318,
                height: 56,
              )
            )
          ],
        ),
      ),
    );
  }

  Widget getLogoImage() {
    return Image(
      image: ResizeImage(
        AssetImage('images/logo.png'),
        width: 319,
        height: 72,
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
        Text('REMEMBER ME'),
      ],
    );
  }

  Widget forgetPasswordBtn(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, '/user/forget-password'),
      child: Text('FORGET PASSWORD?'),
    );
  }

  Widget loginBtn(BuildContext context) {
    return ElevatedButton(
      onPressed: null, // go to user dashboard / home
      child: Text('Login'),
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
        Text('Don\'t have account?'),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, '/user/create-account'), // go to register account page
          child: Text(
            'Create new account',
            style: TextStyle(
              color: Colors.yellow,
            ),
          ),
        ),
      ],
    );
  }
}
