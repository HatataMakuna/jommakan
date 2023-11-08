import 'package:flutter/material.dart';

import 'cart.dart';
import 'home.dart';
import 'favourites.dart';
import 'me.dart';
import 'rewards.dart';

void main() => runApp(const MaterialApp(home: MainPage()));

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const FavouritesPage(),
    const CartPage(),
    const RewardsPage(),
    const MePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 15,
        selectedIconTheme: const IconThemeData(color: Colors.blue, size: 35),
        selectedItemColor: Colors.blue,
        selectedLabelStyle: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        unselectedItemColor: Colors.black, // Set the default color to black
        //unselectedLabelStyle: const TextStyle(color: Colors.black),
        showUnselectedLabels: true,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Rewards',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Me',
          ),
        ],
      ),
    );
  }
}
