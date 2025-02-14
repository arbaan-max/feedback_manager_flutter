import 'package:flutter/material.dart';
import 'package:scan_to_excel/views/get_feed_backs.dart';
import 'package:scan_to_excel/views/submit_feed_back.dart';

class AppControllerPage extends StatefulWidget {
  const AppControllerPage({super.key});

  @override
  State<AppControllerPage> createState() => _AppControllerPageState();
}

class _AppControllerPageState extends State<AppControllerPage> {
  int _selectedIndex = 0;

  // List of pages corresponding to each navigation item
  final List<Widget> _pages = const [
    FeedBackFormPage(),
    GetFeedBacksPage(),
    Center(child: Text('Empty Page')),
  ];

  // Method to handle bottom navigation item tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.feedback),
            label: "Submit Feedback",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Get Feedbacks",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.hourglass_empty),
            label: "Empty",
          ),
        ],
      ),
    );
  }
}
