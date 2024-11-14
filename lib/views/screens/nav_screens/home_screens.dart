import 'package:flutter/material.dart';
import 'package:multi_store_app/views/screens/nav_screens/widgets/banner_widget.dart';
import 'package:multi_store_app/views/screens/nav_screens/widgets/category_item_widget.dart';
import 'package:multi_store_app/views/screens/nav_screens/widgets/header_widget.dart';
import 'package:multi_store_app/views/screens/nav_screens/widgets/popular_product_widget.dart';
import 'package:multi_store_app/views/screens/nav_screens/widgets/reusable_text_widget.dart';
import 'package:multi_store_app/views/screens/nav_screens/widgets/top_rated_widget.dart';

class HomeScreens extends StatelessWidget {
  const HomeScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            MediaQuery.of(context).size.height * 0.20,
          ),
          child: const HeaderWidget(),
        ),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              BannerWidget(),
              CategoriesWidget(),
              ReusableTextWidget(
                title: 'Sản phẩm phổ biến',
                subtitle: '',
              ),
              PopularProductWidget(),
              ReusableTextWidget(title: 'Sản Phẩm Đánh Giá Cao', subtitle: ''),
              TopRatedWidget(),
            ],
          ),
        ));
  }
}
