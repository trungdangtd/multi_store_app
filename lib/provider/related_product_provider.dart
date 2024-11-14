import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_store_app/models/product.dart';

class RelatedProductProvider extends StateNotifier<List<Product>>{
  RelatedProductProvider() : super([]);

  void setProducts(List<Product> products){
    state = products;
  }
}

final relatedProductProvider = StateNotifierProvider<RelatedProductProvider, List<Product>>((ref) => RelatedProductProvider());