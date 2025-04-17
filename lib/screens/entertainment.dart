import 'package:flutter/material.dart';
import 'package:safespace/dummydata/dummy_data.dart';



class Entertainment extends StatelessWidget {
  const Entertainment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Entertainment"),
        backgroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF5F5FF),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection("Music Tracks", musicImages),
            const SizedBox(height: 24),
            _buildSection("Meditation", meditationImages),
            const SizedBox(height: 24),
            _buildSection("Breathing Exercises", breathingImages),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Map<String, String>> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return _buildCard(item['image']!, item['title']!);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCard(String imageUrl, String title) {
    return Container(
      width: 140,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
