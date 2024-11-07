import 'package:flutter/material.dart';
import 'package:multi_store_app/models/category.dart';
import 'package:multi_store_app/views/screens/detail/screens/widgets/inner_category_content_widget.dart';
import 'package:multi_store_app/views/screens/nav_screens/account_screens.dart';
import 'package:multi_store_app/views/screens/nav_screens/cart_screens.dart';
import 'package:multi_store_app/views/screens/nav_screens/category_screen.dart';
import 'package:multi_store_app/views/screens/nav_screens/favories_screens.dart';
import 'package:multi_store_app/views/screens/nav_screens/stores_screens.dart';

class InnerCategoryScreen extends StatefulWidget {
  final Category category;

  const InnerCategoryScreen({super.key, required this.category});

  @override
  State<InnerCategoryScreen> createState() => _InnerCategoryScreenState();
}

class _InnerCategoryScreenState extends State<InnerCategoryScreen> {
    int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
  final List<Widget> screens = [
    InnerCategoryContentWidget(category: widget.category),
    const FavoriesScreens(),
    const CategoryScreen(),
    const StoresScreens(),
    const CartScreens(),
    AccountScreens(),
  ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: pageIndex,
        onTap: (value) {
          setState(() {
            pageIndex = value;
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
      body: screens[pageIndex],
      
    );
  }
}
