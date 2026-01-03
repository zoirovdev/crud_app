import 'package:crud_app/pages/post_page.dart';
import 'package:crud_app/pages/todo_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // 1. Define the list of pages you want to show
  final List<Widget> _pages = [
    const PostPage(),      // Your existing API page
    const TodoPage(),   // A new placeholder page (see below)
  ];

  // 2. Function to handle tap events
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 3. The body changes based on the selected index
      body: _pages[_selectedIndex],
      
      // 4. The Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Highlights the correct icon
        onTap: (index) => _onItemTapped(index),         // Updates the state
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Posts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist),
            label: 'Todos',
          ),
        ],
      ),
    );
  }
}
