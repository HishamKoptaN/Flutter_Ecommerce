import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:ecommerce/image_from_firebase/lib/Screens/home_page.dart';
import 'pages/all_products.dart';
import 'pages/favorites_screen.dart';

class NavigateBarScreen extends StatefulWidget {
  const NavigateBarScreen({super.key});

  @override
  State<NavigateBarScreen> createState() => _HomePageState();
}

class _HomePageState extends State<NavigateBarScreen> {
  final List<Widget> _pages = [
    const Products(),
    const FavoritesScreen(),
    const FavoritesScreen(),
    const MyHomePage(),
  ];
  int _currentIndex = 2;
  int sizeIcon = 30;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SizedBox(height: 500, child: _pages[_currentIndex]),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.white30,
        onTap: (int index) {
          setState(
            () {
              _currentIndex = index;
            },
          );
        },
        items: [
          SalomonBottomBarItem(
            selectedColor: Colors.red,
            unselectedColor: Colors.grey,
            icon: const Icon(Icons.shopping_cart_outlined, size: 30),
            title: const Text("Shop"),
          ),
          SalomonBottomBarItem(
            selectedColor: Colors.red,
            unselectedColor: Colors.grey,
            icon: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.grey,
                    Colors.grey,
                  ],
                ).createShader(bounds);
              },
              child: const Icon(
                Icons.favorite_border, size: 30,
                color: Colors.white,
                // height: 30.h,
              ),
            ),
            title: const Text("Chats"),
          ),
          SalomonBottomBarItem(
            selectedColor: Colors.red,
            unselectedColor: Colors.grey,
            icon: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.grey,
                    Colors.grey,
                  ],
                ).createShader(bounds);
              },
              child: const Icon(
                Icons.person_2_outlined, size: 30,
                color: Colors.white,
                // height: 30.h,
              ),
            ),
            title: const Text("Moments"),
          ),
          SalomonBottomBarItem(
            selectedColor: Colors.red,
            unselectedColor: Colors.grey,
            icon: const Icon(Icons.home, size: 30),
            title: const Text("Home"),
          ),
        ],
      ),
    );
  }
}
