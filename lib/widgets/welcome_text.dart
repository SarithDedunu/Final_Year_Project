import 'package:flutter/material.dart';

class WelcomeText extends StatelessWidget {
  final String username;

  const WelcomeText({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return WelcomeText(username: username);
  }
}
