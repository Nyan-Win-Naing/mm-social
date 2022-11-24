import 'package:flutter/material.dart';
import 'package:mm_social/pages/chat_page.dart';
import 'package:mm_social/pages/contact_page.dart';
import 'package:mm_social/pages/feeds_page.dart';
import 'package:mm_social/pages/profile_page.dart';
import 'package:mm_social/resources/colors.dart';

class BottomNavPage extends StatefulWidget {
  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {

  int _selectedIndex = 0;

  List<Widget> _widgetOptions = [
    ChatPage(),
    ContactPage(),
    FeedsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          backgroundColor: PRIMARY_COLOR,
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.message_outlined,
              ),
              label: "Chats",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.contacts_outlined,
              ),
              label: "Contacts",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.dynamic_feed_rounded,
              ),
              label: "Feeds",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "Profile",
            ),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 12.0,
        ),
      ),
    );
  }
}
