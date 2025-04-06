import 'package:safespace/main.dart';
import 'package:flutter/material.dart';
import 'package:safespace/screens/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Where we go after onboarding

class ChatOnboardingScreen extends StatefulWidget {
  const ChatOnboardingScreen({super.key});

  @override
  _ChatOnboardingScreenState createState() => _ChatOnboardingScreenState();
}

class _ChatOnboardingScreenState extends State<ChatOnboardingScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [
    "Hi! Welcome to SafeSpace. I'm here to guide you through the app.",
    "Are you ready to start learning about the features?"
  ];

  @override
  void initState() {
    super.initState();
  }

  void _sendMessage() {
    if (_controller.text.isEmpty) return;

    setState(() {
      _messages.add("You: ${_controller.text}");
      _messages.add(_getBotResponse(_controller.text));
    });

    _controller.clear();
  }

  String _getBotResponse(String userInput) {
    // Simple logic for responses, can be expanded
    if (userInput.toLowerCase().contains("yes")) {
      return "Great! Let’s get started. The app helps you track your mental health, provides resources, and more!";
    } else if (userInput.toLowerCase().contains("no")) {
      return "No worries! Take your time, and we’ll be here when you’re ready.";
    } else {
      return "I'm not sure what you mean. Can you say 'Yes' or 'No' to continue?";
    }
  }

  void _finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingComplete', true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SafeSpaceApp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat Onboarding")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: _messages[index].startsWith("You:")
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _messages[index].startsWith("You:")
                            ? Colors.blueAccent
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        _messages[index],
                        style: TextStyle(
                          color: _messages[index].startsWith("You:")
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Type your response...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
          // Finish button once user reaches the end
          if (_messages.last.contains("No worries!"))
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _finishOnboarding,
                child: const Text("Finish Onboarding"),
              ),
            ),
        ],
      ),
    );
  }
}
