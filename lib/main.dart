import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:safespace/screens/home_screen.dart';
import 'package:safespace/screens/signin_screen.dart';
import 'package:safespace/screens/signup_screen.dart';
import 'package:safespace/screens/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:safespace/screens/chatbot.dart'; // For example, ChatBotPage

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();  // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeSpace',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,  // Disable the debug banner
      home: const AuthWrapper(),
    );
  }
}

// This widget decides whether the user is logged in or not
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  Future<bool> _checkIfLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboardingComplete') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkIfLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.data == true) {
          return HomeScreen(username: 'User');  // Change this to your username logic
        } else {
          return WelcomeScreen();  // Navigate to WelcomeScreen
        }
      },
    );
  }
}
