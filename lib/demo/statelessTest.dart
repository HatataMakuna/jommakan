// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart'; // import flutter framework

/* void main() {
  runApp(MyApp());
} */

void main() => runApp(MyApp());

// StatelessWidget allows you to create your own widgets
class MyApp extends StatelessWidget {
  var questionIndex = 0;

  /* 
  void answerQuestion() - called when user selects an option

  ElevatedButton(onPressed: answerQuestion, child: Text('Answer 1')),
  ElevatedButton(onPressed: answerQuestion, child: Text('Answer 2')),
  ElevatedButton(onPressed: answerQuestion, child: Text('Answer 3')),
  */
  void answerQuestion() {
    questionIndex += 1;
    print(questionIndex);
  }

  @override
  Widget build(BuildContext context) {
    var questions = [
      'What\'s your favorite color?',
      'What\'s your favorite animal?'
    ];

    // MaterialApp is a class and we can pass data into it with a feature called the constructor
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My First App'),
        ),
        body: Column(
          children: [
            Text(questions[questionIndex]),

            // anonymous functions - () => print('Answer 1 chosen!'); no need to define external function
            ElevatedButton(onPressed: answerQuestion, child: Text('Answer 1')),
            ElevatedButton(onPressed: () => print('Answer 2 chosen!'), child: Text('Answer 2')),
            ElevatedButton(onPressed: () => print('Answer 3 chosen!'), child: Text('Answer 3')),
          ],
        ),
        // If you wanted items next to each other (instead of above each other - Column()), you would've use a Row().
      ),
    );
  }
}