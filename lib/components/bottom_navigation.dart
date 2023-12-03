import 'package:flutter/material.dart';
import 'package:signalscan/pages/home_page.dart';
import 'package:signalscan/pages/news_page.dart';

import '../pages/signals_page.dart';

// Clase base que contiene el BottomNavigationBar
class BaseApp extends StatefulWidget {
  const BaseApp({super.key});

  @override
  State<BaseApp> createState() => _BaseAppState();
}

class _BaseAppState extends State<BaseApp> {
  int _currentIndex = 0;

  // Lista de elementos del BottomNavigationBar
  final List<BottomNavigationBarItem> _bottomNavigationBarItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.newspaper),
      label: 'Noticias',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.traffic),
      label: 'Señales',
    ),
  ];

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    NewsPage(),
    SignalsPage()
  ];

  // Método para manejar el evento de selección de elementos del BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 165, 36, 36),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        selectedLabelStyle: const TextStyle(color: Colors.white),
        unselectedLabelStyle: const TextStyle(color: Colors.white),
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: _bottomNavigationBarItems,
      ),
    );
  }
}
