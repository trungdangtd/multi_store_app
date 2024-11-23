import 'package:flutter/material.dart';
import 'package:multi_store_app/controller/product_controller.dart';
import 'package:multi_store_app/models/product.dart';
import 'package:multi_store_app/views/screens/nav_screens/widgets/product_item_widget.dart';

class SearchProductScreen extends StatefulWidget {
  const SearchProductScreen({super.key});

  @override
  State<SearchProductScreen> createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ProductController _productController = ProductController();

  List<Product> _searchedProducts = [];
  bool _isLoading = false;

  void _searchProducts() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final query = _searchController.text.trim();
      if (query.isNotEmpty) {
        final products = await _productController.sreachProducts(query);
        setState(() {
          _searchedProducts = products;
        });
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final crossAxisCount = screenWidth < 600 ? 2 : 4;

    final childAspectRatio = screenWidth < 600 ? 3 / 4 : 4 / 5;
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
              labelText: "Tìm kiếm sản phẩm",
              suffixIcon: IconButton(
                  onPressed: _searchProducts, icon: const Icon(Icons.search))),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            )
          else if (_searchedProducts.isEmpty)
            const Center(
              child: Text(
                'Không tìm thấy sản phẩm nào',
              ),
            )
          else
            Expanded(
              child: GridView.builder(
                  itemCount: _searchedProducts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: childAspectRatio,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8),
                  itemBuilder: (context, index) {
                    final product = _searchedProducts[index];
                    return ProductItemWidget(
                      product: product,
                    );
                  }),
            )
        ],
      ),
    );
  }
}
