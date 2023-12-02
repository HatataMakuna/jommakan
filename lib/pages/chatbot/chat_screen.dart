import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jom_makan/pages/chatbot/chat_message.dart';

void main() {
  runApp(const MaterialApp(home: ChatScreen()));
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  List<Map<String, dynamic>> _responsesList = [];

  @override
  void initState() {
    super.initState();
    _loadResponses();
    _initMessage();
  }

  void _initMessage() {
    _addMessage('Hello! How can I help you today?', false);
  }

  void _loadResponses() async {
    String data = await rootBundle.loadString('assets/responses.json');
    final responses = json.decode(data)['responses'];
    List<Map<String, dynamic>> typedResponses = [];
    for (final response in responses) {
      typedResponses.add(response);
    }
    setState(() {
      _responsesList = typedResponses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'JomMakan Customer Support Chatbot',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          _buildComposer(),
        ],
      ),
    );
  }

  Widget _buildComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: const InputDecoration.collapsed(
                hintText: 'Send a message',
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () => _textController.text.isEmpty ? null : _handleSubmitted(_textController.text),
          ),
        ],
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    _addMessage(text, true); // User's message
    _generateResponse(text); // Bot's response
  }

  void _generateResponse(String userMessage) {
    String response = ''; // Provide an initial value

    for (final responses in _responsesList) {
      dynamic trigger = responses['trigger'];
      String lowerCaseUserMessage = userMessage.toLowerCase();

      if (trigger is String && lowerCaseUserMessage.contains(trigger)) {
        response = responses['response'];
        break;
      } else if (trigger is List<dynamic>) {
        for (var triggerItem in trigger) {
          if (lowerCaseUserMessage.contains(triggerItem)) {
            response = responses['response'];
            break;
          }
        }
      }
    }

    if (response.isNotEmpty) {
      _addMessage(response, false);
    } else {
      _addMessage(_responsesList.last['response'], false);
    }
  }

  void _addMessage(String text, bool isUser) {
    ChatMessage message = ChatMessage(
      text: text,
      isUser: isUser,
    );
    setState(() {
      _messages.insert(0, message);
    });
  }
}