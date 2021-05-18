import 'package:flutter/material.dart';
import 'package:intro/Homepage.dart';
import 'package:intro/Noticeboard.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int selectedPage = 0;
  final _pageOptions = [Homepage(), Noticeboard()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pageOptions[selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.speaker_notes,
              size: 30,
            ),
            label: 'NOTICE BOARD',
          ),
        ],
        selectedItemColor: Colors.redAccent,
        elevation: 5.0,
        unselectedItemColor: Colors.redAccent[100],
        currentIndex: selectedPage,
        backgroundColor: Colors.white,
        onTap: (index) {
          if (mounted) {
            setState(() {
              selectedPage = index;
            });
          }
        },
      ),
    );
  }
}
