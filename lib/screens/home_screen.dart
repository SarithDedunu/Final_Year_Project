import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'chatbot.dart'; // Import ChatBotPage
import 'package:safespace/screens/notifications.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome text and notification icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Welcome back, Sarina!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.notifications,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Notifications()),
                      );
                      // Handle notification icon press here
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Mood selection prompt
              const Text('How are you feeling today?'),
              const SizedBox(height: 10),
              // Mood selection buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _moodButton(
                      'Happy', 'assets/images/happy.png', Color(0xFFEF5DA8)),
                  _moodButton(
                      'Calm', 'assets/images/calm.png', Color(0xFFAEAFF7)),
                  _moodButton(
                      'Relax', 'assets/images/relax.png', Color(0xFFF09E54)),
                  _moodButton(
                      'Focus', 'assets/images/focus.png', Color(0xFFA0E3E2)),
                ],
              ),
              const SizedBox(height: 20),
              // Motivational message
              const Text(
                'You are stronger than you think. Take a deep breath you’ve got this! 😊',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // Chat bubble
              _chatBubble(context),
              const SizedBox(height: 20),
              // Task section header
              const Text("Today's Task",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              // Task list
              Expanded(
                child: ListView(
                  children: [
                    _taskCard(
                        'Peer Group Meetup',
                        'Let’s open up to the thing that matters among the people',
                        Icons.people,
                        Colors.pink.shade100),
                    _taskCard(
                        'Listen to some music',
                        'Heal your mind with our stunning healing tracks and songs',
                        Icons.music_note,
                        Colors.orange.shade100),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Mood Button Widget
  Widget _moodButton(String mood, String imagePath, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Image.asset(imagePath, width: 40, height: 50),
        ),
        SizedBox(height: 5),
        Text(mood, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }

  // Chat Bubble Widget
  Widget _chatBubble(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatBotPage()), // Navigate to ChatBotPage
        );
      },
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                border: Border.all(
                    width: 3, color: const Color.fromARGB(255, 9, 9, 9)),
                borderRadius: BorderRadius.circular(19),
              ),
              child: const Text('Hello, Sarina!\nLet’s Chat',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 10),
          Transform.translate(
            offset: const Offset(0, 35),
            child: Image.asset(
              'assets/images/app.png',
              width: 50,
              height: 50,
            ),
          ),
        ],
      ),
    );
  }

  // Task Card Widget
  Widget _taskCard(
      String title, String description, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 40, color: Colors.pink),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text(description, style: TextStyle(color: Colors.grey[700])),
                const SizedBox(height: 5),
                Text('Join Now →',
                    style: TextStyle(
                        color: Colors.pink.shade700,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
