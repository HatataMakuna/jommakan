// ignore_for_file: prefer_const_constructors

/*
TASKS OUTSIDE THIS FILE
- Change the logo
*/

/*
TASKS INSIDE THIS FILE
- onPressed things need to assign links
- both fields must be required ; invalid username or password error
- OPTIONAL: Adjust text style (color, font size etc.)
- OPTIONAL: Adjust size depending on screen size
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
            getLogoImage(),
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'EMAIL ADDRESS',
              ),
            ),
            SizedBox(height: 10.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'PASSWORD',
              ),
              obscureText: true,
            ),
            SizedBox(height: 10.0),
            rememberMeChkBox(),
            forgetPasswordBtn(context),
            loginBtn(context),
            createAccountBtn(context),
            // footer image
          ],
        ),
      ),
    );
  }

  Widget getLogoImage() {
    return Image(
      image: ResizeImage(
        AssetImage('images/jommakan.JPG'),
        width: 226,
        height: 232,
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
    return TextButton(
      onPressed: null, // go to user dashboard / home
      child: Text('Login'),
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
