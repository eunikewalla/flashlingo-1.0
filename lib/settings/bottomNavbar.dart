import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flashlingo1_0/page/HomePage.dart';
import 'package:flashlingo1_0/page/LevelPage.dart';
import 'package:flashlingo1_0/page/accountPage.dart';
import 'package:flashlingo1_0/settings/ColorScheme.dart';
import 'package:flutter/material.dart';

class BottomNavbar extends StatefulWidget {
  final int currentIndex;

  const BottomNavbar({Key? key, required this.currentIndex}) : super(key: key);

  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.white,
      color: lightBlue,
      animationDuration: const Duration(milliseconds: 300),
      index: _currentIndex,
      items: const [
        Icon(
          Icons.home,
          color: Colors.black,
        ),
        Icon(
          Icons.developer_board_rounded,
          color: Colors.black,
        ),
        Icon(
          Icons.account_circle_rounded,
          color: Colors.black,
        ),
      ],
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        switch (index) {
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
            break;
          case 1:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LevelPage()),
            );
            break;

          case 2:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => accountPage()),
            );
            break;
        }
      },
    );
  }
}
