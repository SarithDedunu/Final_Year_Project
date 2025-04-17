import '../screens/chatbot.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String username;

  const ChatBubble({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatBotPage()));
      },
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                border: Border.all(width: 3, color: const Color.fromARGB(255, 9, 9, 9)),
                borderRadius: BorderRadius.circular(19),
              ),
              child: Text(
                'Hello, $username!\nLet\'s Chat',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Transform.translate(
            offset: const Offset(0, 35),
            child: Image.asset('assets/images/app.png', width: 50, height: 50),
          ),
        ],
      ),
    );
  }
}
