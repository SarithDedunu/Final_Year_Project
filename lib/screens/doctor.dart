import 'package:flutter/material.dart';

class Doctors extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sariha_Kapoor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Find the doctor suitable to you',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Search bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search the Doctor, Category',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Category section
            const Text(
              'Category',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Category items
            Column(
              children: [
                ListTile(
                  title: const Text(
                    'Cognitive Behavioral Therapists',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Trauma Therapists'),
                      Text('Addiction Counsellors'),
                    ],
                  ),
                ),
                const Divider(),
                const ListTile(
                  title: Text('Psychiat'),
                ),
                const Divider(),
              ],
            ),
            const SizedBox(height: 16),
            // Specialist section
            const Text(
              'Specialist',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Here you can add your specialist list or other content
            Expanded(
              child: Center(
                child: Text("Specialist doctors will be listed here"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}