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
  Map<String, dynamic> _responses = {};

  @override
  void initState() {
    super.initState();
    _loadResponses();
  }

  void _loadResponses() async {
    String data = await rootBundle.loadString('lib/pages/chatbot/responses.json');
    _responses = json.decode(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Customer Support',
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
            onPressed: () => _handleSubmitted(_textController.text),
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
    // Basic logic for bot responses
    String response = ''; // Provide an initial value
    String lowerCaseUserMessage = userMessage.toLowerCase();

    for (var rule in _responses['responses']) {
      if (lowerCaseUserMessage.contains(rule['trigger'])) {
        response = rule['response'];
        break;
      }
    }

    _addMessage(response.isNotEmpty ? response : _responses['default']['response'], false);
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