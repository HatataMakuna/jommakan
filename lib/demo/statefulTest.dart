// ignore_for_file: prefer_const_constructors

/*
WHAT IS STATE?
In general, state is data/information your app or your widgets. In your app, state can be things like a username or in our case or the index of the question we want to show.

App-wide state : Authenticated Users, Loaded Jobs, ...

Widget state : Current User Input, Is a Loading Spinner being shown?

STATELESS vs. STATEFUL
STATELESS
- Input Data (Data can change (externally))
- Widget
- Renders UI (Gets (re)-rendered when input data changes)

STATEFUL
- Input Data (Data can change (externally))
- Widget - has Internal state
- Renders UI (Gets (re)-rendered when input data or local state changes)

ONE WIDGET PER FILE IS RECOMMENDED
*/

import 'package:flutter/material.dart'; // import flutter framework

import './quiz.dart';
import './result.dart';

/* void main() {
  runApp(MyApp());
} */

void main() => runApp(MyApp());

// StatelessWidget allows you to create your own widgets
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

// MyAppState - public
// _MyAppState - private
class _MyAppState extends State<MyApp> {
  final questions = [
    {
      'questionText': 'What\'s your favorite color?',
      'answers': [
        {'text': 'Black', 'score': 10},
        {'text': 'Red', 'score': 5},
        {'text': 'Green', 'score': 3},
        {'text': 'White', 'score': 1}
      ],
    },
    {
      'questionText': 'What\'s your favorite animal?',
      'answers': [
        {'text': 'Rabbit', 'score': 3},
        {'text': 'Snake', 'score': 11},
        {'text': 'Elephant', 'score': 5},
        {'text': 'Lion', 'score': 9}
      ],
    },
  ];
  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  /* 
  void answerQuestion() - called when user selects an option

  ElevatedButton(onPressed: answerQuestion, child: Text('Answer 1')),
  ElevatedButton(onPressed: answerQuestion, child: Text('Answer 2')),
  ElevatedButton(onPressed: answerQuestion, child: Text('Answer 3')),
  */
  void _answerQuestion(int score) {
    _totalScore += score;

    setState(() {
      _questionIndex += 1;
    });
    print(_questionIndex);
    if (_questionIndex < questions.length) {
      print('We have more questions!');
    } else {
      print('No more questions!');
    }
  }

  @override
  Widget build(BuildContext context) {
    final questions = [
      {
        'questionText': 'What\'s your favorite color?',
        'answers': ['Black', 'Red', 'Green', 'White'],
      },
      {
        'questionText': 'What\'s your favorite animal?',
        'answers': ['Rabbit', 'Snake', 'Elephant', 'Lion'],
      },
    ];

    // questions = []; // does not work if questions is a const

    // MaterialApp is a class and we can pass data into it with a feature called the constructor
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My First App'),
        ),
        body: _questionIndex < questions.length ?
        Quiz(
          answerQuestion: _answerQuestion,
          questionIndex: _questionIndex,
          questions: questions,
        )
         : Result(_totalScore, _resetQuiz),
        // If you wanted items next to each other (instead of above each other - Column()), you would've use a Row().
      ),
    );
  }
}