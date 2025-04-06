import 'package:flutter/material.dart';
import 'package:safespace/screens/music.dart';
import 'package:safespace/screens/notify.dart';
import 'package:safespace/screens/navbar.dart';
import 'package:safespace/screens/profile.dart';
import 'package:safespace/screens/home_screen.dart';
import 'package:safespace/screens/welcome_screen.dart';
import 'package:safespace/screens/splashscreen.dart'; // ✅ Import splashscreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SafeSpace',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(), // ✅ Show splash first
    );
  }
}

class SafeSpaceApp extends StatefulWidget {
  const SafeSpaceApp({super.key});

  @override
  _SafeSpaceAppState createState() => _SafeSpaceAppState();
}

class _SafeSpaceAppState extends State<SafeSpaceApp> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    SongsPage(),
    NotificationsPage(),
    ProfilePage(),
  ];

  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavBar(
        selectedIndex: _selectedIndex,
        onTabChange: _onTabChange,
      ),
    );
  }
}
