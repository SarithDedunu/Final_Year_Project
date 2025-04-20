import 'package:flutter/material.dart';
import 'package:safespace/screens/chatbot.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:safespace/screens/notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? _username;
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchUsername();
  }

  Future<void> _fetchUsername() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null && user.uid.isNotEmpty) {
        final DocumentSnapshot<Map<String, dynamic>> userDoc =
            await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

        if (userDoc.exists && userDoc.data()?['username'] != null) {
          setState(() {
            _username = userDoc.data()!['username'];
            _isLoading = false;
          });
        } else {
          setState(() {
            _username = 'User'; // Default if username not found in Firestore
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _username = 'Guest'; // Or handle the case where the user is not logged in
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error fetching username: $e';
        _isLoading = false;
      });
      print('Error fetching username from Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _errorMessage.isNotEmpty
                ? Center(child: Text(_errorMessage))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Welcome text and notification icon
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Welcome back, ${_username ?? 'User'}!',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.notifications),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Notifications()),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Mood selection prompt
                      const Text('How are you feeling today?'),
                      const SizedBox(height: 10),
                      // Wrap the Row inside a SingleChildScrollView for horizontal scrolling
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _moodButton('Happy', 'assets/images/happy.png',
                                const Color(0xFFEF5DA8)),
                            _moodButton('Calm', 'assets/images/calm.png',
                                const Color(0xFFAEAFF7)),
                            _moodButton('Relax', 'assets/images/relax.png',
                                const Color(0xFFF09E54)),
                            _moodButton('Focus', 'assets/images/focus.png',
                                const Color(0xFFA0E3E2)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Motivational message
                      const Text(
                        'You are stronger than you think. Take a deep breath, you\'ve got this! 😊',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      // Chat bubble
                      _chatBubble(context, _username ?? 'User'),
                      const SizedBox(height: 20),
                      // Task section header
                      const Text("Today's Task",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      // Task list (example tasks)
                      Expanded(
                        child: ListView(
                          children: [
                            _taskCard(
                                'Peer Group Meetup',
                                "Let's open up to the thing that matters among the people",
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
    );
  }

  // Mood Button Widget
  Widget _moodButton(String mood, String imagePath, Color color) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset(imagePath, width: 40, height: 50),
          ),
          const SizedBox(height: 5),
          Text(mood, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // Chat Bubble Widget
  Widget _chatBubble(BuildContext context, String username) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatBotPage()),
        );
      },
      child: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(19),
        shadowColor: Colors.black.withOpacity(0.3),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: const Color.fromARGB(119, 56, 199, 168),
            borderRadius: BorderRadius.circular(19),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, $username!',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color.fromARGB(255, 1, 0, 0),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Let\'s Chat",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(179, 0, 0, 0),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  'assets/images/app.png',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Task Card Widget
  Widget _taskCard(String title, String description, IconData icon, Color color) {
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