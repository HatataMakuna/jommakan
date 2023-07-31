// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function selectHandler;
  final String answerText;

  Answer(this.selectHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue), // set the button background color to blue
          foregroundColor: MaterialStatePropertyAll<Color>(Colors.white), // set the button foregound color to white
        ),
        onPressed: () => selectHandler,
        child: Text(answerText),
      ),
    );
  }
}