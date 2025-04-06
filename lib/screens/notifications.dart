import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            _notificationCard('Reminder: Take a break!', 'It\'s important to take regular breaks for your mental health.', Icons.alarm, Colors.orange.shade100),
            _notificationCard('New Task Available!', 'Check your task list for new items to complete today.', Icons.task, Colors.green.shade100),
            _notificationCard('Don\'t forget to check your progress', 'See how well you have been doing lately with your tasks!', Icons.assessment, Colors.blue.shade100),
            _notificationCard('Message from a Counselor', 'A counselor has sent you a message, please check it out.', Icons.message, Colors.purple.shade100),
          ],
        ),
      ),
    );
  }

  // A custom widget for the notification card
  Widget _notificationCard(String title, String subtitle, IconData icon, Color color) {
    return Card(
      color: color,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(title, style: TextStyle(color: Colors.white)),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.white70)),
        onTap: () {
          // Handle tap on the notification card (e.g., open a detailed view)
          print('Notification tapped: $title');
        },
      ),
    );
  }
}
