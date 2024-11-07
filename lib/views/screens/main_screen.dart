import 'package:flutter/material.dart';
import 'package:multi_store_app/views/screens/nav_screens/account_screens.dart';
import 'package:multi_store_app/views/screens/nav_screens/cart_screens.dart';
import 'package:multi_store_app/views/screens/nav_screens/category_screen.dart';
import 'package:multi_store_app/views/screens/nav_screens/favories_screens.dart';
import 'package:multi_store_app/views/screens/nav_screens/home_screens.dart';
import 'package:multi_store_app/views/screens/nav_screens/stores_screens.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex = 0;
  final List<Widget> _screens = [
    const HomeScreens(),
    const FavoriesScreens(),
    const CategoryScreen(),
    const StoresScreens(),
    const CartScreens(),
     AccountScreens(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: _pageIndex,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Image.asset('assets/icons/home.png', width: 25),
              label: "Trang Chủ"),
          BottomNavigationBarItem(
              icon: Image.asset('assets/icons/love.png', width: 25),
              label: "Yêu Thích"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.category), label: "Danh mục"),
          BottomNavigationBarItem(
              icon: Image.asset('assets/icons/mart.png', width: 25),
              label: "Mua Sắm"),
          BottomNavigationBarItem(
              icon: Image.asset('assets/icons/cart.png', width: 25),
              label: "Giỏ Hàng"),
          BottomNavigationBarItem(
              icon: Image.asset('assets/icons/user.png', width: 25),
              label: "Tài Khoản"),
        ],
      ),
      body: _screens[_pageIndex],
    );
  }
}
