import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_store_app/controller/product_controller.dart';
import 'package:multi_store_app/provider/product_provider.dart';
import 'package:multi_store_app/views/screens/nav_screens/widgets/product_item_widget.dart';

class PopularProductWidget extends ConsumerStatefulWidget {
  const PopularProductWidget({super.key});

  @override
  ConsumerState<PopularProductWidget> createState() =>
      _PopularProductWidgetState();
}

class _PopularProductWidgetState extends ConsumerState<PopularProductWidget> {
  @override
  void initState() {
    super.initState();
    _fetchProduct();
  }

  Future<void> _fetchProduct() async {
    final ProductController productController = ProductController();
    try {
      final products = await productController.loadPopularProducts();
      ref.read(productProvider.notifier).setProducts(products);
    } catch (e) {
      // ignore: avoid_print
      print("Lỗi: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productProvider);
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductItemWidget(
            product: product,
          );
        },
      ),
    );
  }
}
