import 'package:flutter/material.dart';
import 'package:listproject/page/beranda.dart';
import 'package:listproject/page/bonus.dart';
import 'package:listproject/page/history.dart';
import 'package:listproject/page/profil.dart';
import 'package:listproject/page/progres.dart';
import 'package:listproject/page/waiting.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  var _widgetOptions = [
    Beranda(),
    Progres(),
    Waiting(),
    History(),
    Bonus(),
    Profil(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.grey,
            ),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.my_library_books_outlined,
              color: Colors.grey,
            ),
            label: 'Progres',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.pending,
              color: Colors.grey,
            ),
            label: 'Waiting',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.history,
              color: Colors.grey,
            ),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.clean_hands_outlined,
              color: Colors.grey,
            ),
            label: 'Bonus',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.grey,
            ),
            label: 'Akun',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        iconSize: 30,
        onTap: _onItemTapped,
      ),
    );
  }
}
