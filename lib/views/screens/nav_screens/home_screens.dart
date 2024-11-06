import 'package:flutter/material.dart';
import 'package:multi_store_app/views/screens/nav_screens/widgets/banner_widget.dart';
import 'package:multi_store_app/views/screens/nav_screens/widgets/category_item_widget.dart';
import 'package:multi_store_app/views/screens/nav_screens/widgets/header_widget.dart';

class HomeScreens extends StatelessWidget {
  const HomeScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          HeaderWidget(),
          BannerWidget(),
          CategoriesWidget(),
        ],
      ),
    ));
  }
}
