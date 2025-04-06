import 'package:flutter/material.dart';
import 'package:safespace/screens/chatbot.dart';

class ChatBubble extends StatelessWidget {
  final VoidCallback? onTap;
  final String userName;
  
  const ChatBubble({
    super.key,
    this.onTap,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatBotPage()),
        );
      },
      child: Container(
        // ... [rest of the widget code from above]
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Hello, $userName!', // Now dynamic
                  // ... [rest stays the same]
                ),
              ],
            ),
            // ... [other elements]
          ],
        ),
      ),
    );
  }
}