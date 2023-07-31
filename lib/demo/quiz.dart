// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import './question.dart';
import './answer.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  Quiz({
    required this.questions,
    required this.answerQuestion,
    required this.questionIndex
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
            Question(
              questions[questionIndex]['questionText'].toString()
            ),

            // ... - spread operator ; they take a list and pull all the values in the list out of it and add them to the surrounding list as individual values
            ...(questions[questionIndex]['answers'] as List<Map<String, Object>>).map((answer) {
              return Answer(() => answerQuestion(answer['score']), answer['text'].toString());
            }).toList()

            //Answer(_answerQuestion),
            /* Text(questions[_questionIndex]),

            // anonymous functions - () => print('Answer 1 chosen!'); no need to define external function
            ElevatedButton(onPressed: _answerQuestion, child: Text('Answer 1')),
            ElevatedButton(onPressed: () => print('Answer 2 chosen!'), child: Text('Answer 2')),
            ElevatedButton(onPressed: () => print('Answer 3 chosen!'), child: Text('Answer 3')), */
          ],
    );
  }
}