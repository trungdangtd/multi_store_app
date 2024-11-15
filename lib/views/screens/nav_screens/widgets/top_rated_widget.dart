import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_store_app/controller/product_controller.dart';
import 'package:multi_store_app/provider/product_provider.dart';
import 'package:multi_store_app/provider/top_rated_product_provider.dart';
import 'package:multi_store_app/views/screens/nav_screens/widgets/product_item_widget.dart';

class TopRatedWidget extends ConsumerStatefulWidget {
  const TopRatedWidget({super.key});

  @override
  ConsumerState<TopRatedWidget> createState() => _PopularProductWidgetState();
}

class _PopularProductWidgetState extends ConsumerState<TopRatedWidget> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    final products = ref.read(productProvider);
    if (products.isEmpty) {
      _fetchProduct();
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchProduct() async {
    final ProductController productController = ProductController();
    try {
      final products = await productController.loadTopRatedProduct();
      ref.read(topRatedProductProvider.notifier).setProducts(products);
    } catch (e) {
      // ignore: avoid_print
      print("Lỗi: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productProvider);
    return SizedBox(
      height: 250,
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : ListView.builder(
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
