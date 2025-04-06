import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        title: const Text("Profile"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Info
            Row(
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/profile.jpg'), // Update this path
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Sarina_Kapoor',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        'sarinakapoor20@gmail.com',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.edit, size: 20),
              ],
            ),
            const SizedBox(height: 12),

            // Social Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.facebook, color: Colors.blue),
                SizedBox(width: 10),
                Icon(Icons.alternate_email, color: Colors.red),
                SizedBox(width: 10),
                Icon(Icons.g_mobiledata, color: Colors.blue),
                SizedBox(width: 10),
                Icon(Icons.apple, color: Colors.black),
              ],
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade200,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Invite a friend'),
            ),

            const SizedBox(height: 20),

            // Options list
            Expanded(
              child: ListView(
                children: const [
                  ProfileOptionTile(icon: Icons.description, label: 'Personal Information'),
                  ProfileOptionTile(icon: Icons.track_changes, label: 'Mental Health Goals'),
                  ProfileOptionTile(icon: Icons.mood, label: 'Mood and Activity'),
                  ProfileOptionTile(icon: Icons.bookmark_added, label: 'Saved Resources'),
                  ProfileOptionTile(icon: Icons.support_agent, label: 'Help and Support'),
                  ProfileOptionTile(icon: Icons.logout, label: 'Logout', isLogout: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileOptionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isLogout;

  const ProfileOptionTile({
    super.key,
    required this.icon,
    required this.label,
    this.isLogout = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: isLogout ? Colors.grey.shade200 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(label),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Add page navigation or logout logic
        },
      ),
    );
  }
}

