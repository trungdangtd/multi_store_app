import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_store_app/models/subcategory.dart';

class SubCategoryProvider extends StateNotifier<List<Subcategory>> {
  SubCategoryProvider() : super([]);

  void setSubCategories(List<Subcategory> subCategories) {
    state = subCategories;
  }
}

final subcategoryProvider =
    StateNotifierProvider<SubCategoryProvider, List<Subcategory>>(
        (ref) => SubCategoryProvider());
