import 'package:crud_provider/add.dart';
import 'package:flutter/material.dart';

import 'list.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
   ListPage(),
   AddPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(icon: Icon(Icons.list),label: "Data Mahasiswa"),
          BottomNavigationBarItem(icon: Icon(Icons.post_add_sharp),label: "Tamabah   Mahasiswa"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
        ),
    );
  }
}