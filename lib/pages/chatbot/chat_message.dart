import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatMessage({super.key, required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) const CircleAvatar(child: Icon(Icons.android)),
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: isUser ? Colors.blue : Colors.grey[300],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              text,
              style: TextStyle(color: isUser ? Colors.white : Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}