import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage;
  TextEditingController _nameController = TextEditingController(text: 'Sarina_Kapoor');
  TextEditingController _emailController = TextEditingController(text: 'sarinakapoor20@gmail.com');

  Future<void> _pickProfileImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _editProfile() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Profile"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {});
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  // Function to show content when a profile option is tapped (Full-Screen Popup)
  void _showFullScreenPopup(String label) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows full screen
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () => Navigator.pop(context), // Close the modal when tapped outside
          child: Container(
            color: Colors.black.withOpacity(0.5), // Transparent background
            child: Center(
              child: Material(
                color: Colors.white, // Background color of the modal
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Here is the content related to $label.",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Close"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

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
                GestureDetector(
                  onTap: _pickProfileImage,
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!) 
                        : const AssetImage('assets/profile.jpg') as ImageProvider,
                    child: _profileImage == null
                        ? const Icon(Icons.camera_alt, size: 30, color: Colors.white)
                        : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _nameController.text,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        _emailController.text,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, size: 20),
                  onPressed: _editProfile,
                ),
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
                children: [
                  ProfileOptionTile(
                    icon: Icons.description,
                    label: 'Personal Information',
                    onTap: () => _showFullScreenPopup('Personal Information'),
                  ),
                  ProfileOptionTile(
                    icon: Icons.track_changes,
                    label: 'Mental Health Goals',
                    onTap: () => _showFullScreenPopup('Mental Health Goals'),
                  ),
                  ProfileOptionTile(
                    icon: Icons.mood,
                    label: 'Mood and Activity',
                    onTap: () => _showFullScreenPopup('Mood and Activity'),
                  ),
                  ProfileOptionTile(
                    icon: Icons.bookmark_added,
                    label: 'Saved Resources',
                    onTap: () => _showFullScreenPopup('Saved Resources'),
                  ),
                  ProfileOptionTile(
                    icon: Icons.support_agent,
                    label: 'Help and Support',
                    onTap: () => _showFullScreenPopup('Help and Support'),
                  ),
                  ProfileOptionTile(
                    icon: Icons.logout,
                    label: 'Logout',
                    isLogout: true,
                    onTap: () {
                      // Implement logout logic here
                    },
                  ),
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
  final VoidCallback onTap;

  const ProfileOptionTile({
    super.key,
    required this.icon,
    required this.label,
    this.isLogout = false,
    required this.onTap,
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
        onTap: onTap,
      ),
    );
  }
}
