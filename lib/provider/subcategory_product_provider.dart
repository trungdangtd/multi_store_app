import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_store_app/models/product.dart';

class SubcategoryProductProvider extends StateNotifier<List<Product>> {
  SubcategoryProductProvider() : super([]);

  void setProducts(List<Product> products) {
    state = products;
  }
}

final subcategoryProductProvider =
    StateNotifierProvider<SubcategoryProductProvider, List<Product>>(
        (ref) => SubcategoryProductProvider());
