import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_store_app/models/category.dart';

class CategoryProvider extends StateNotifier<List<Category>>{
  CategoryProvider() : super([]);

  void setCategories(List<Category> categories){
    state = categories;
  }
}

final cateProvider = StateNotifierProvider<CategoryProvider, List<Category>>((ref) => CategoryProvider());