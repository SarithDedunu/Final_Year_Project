import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:safespace/screens/music.dart';
import 'package:safespace/screens/doctor.dart';
import 'package:safespace/screens/profile.dart';
import 'package:safespace/screens/home_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  // List of pages to navigate to
  List<Widget> _pages = [
    HomeScreen(), // Home Page
    SongsPage(), // Songs Page
    Doctors(), // Notifications Page
    ProfilePage(), // Profile Page
  ];

  // Handle tab change
  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SafeSpace')),
      body: _pages[_selectedIndex], // Show selected page
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.blue[100]!,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.music,
                  text: 'Songs',
                ),
                GButton(
                  icon: LineIcons.bell,
                  text: 'Notifications',
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: _onTabChange, // Handle tab change
            ),
          ),
        ),
      ),
    );
  }
}
