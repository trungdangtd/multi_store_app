import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_store_app/models/favorite.dart';
import 'package:shared_preferences/shared_preferences.dart';

final favoriesProvider =
    StateNotifierProvider<FavoriteNotifier, Map<String, Favorite>>((ref) {
  return FavoriteNotifier();
});

class FavoriteNotifier extends StateNotifier<Map<String, Favorite>> {
  FavoriteNotifier() : super({}){
    _loadFavorites();
  }

  //a private method that loads the favorite items from shared preferences
  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteString = prefs.getString('favorites');
    if(favoriteString != null){
      final Map<String,dynamic> favoriteMap = jsonDecode(favoriteString);
      final favorites = favoriteMap.map((key, value) => MapEntry(key, Favorite.fromJson(value)));
      state = favorites;
    }
  }

  //a private modthod that save the current state of favorite items to shared preferences
  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteString = jsonEncode(state);
    await prefs.setString('favorites', favoriteString);
  }

  void addProductToFavories(
      {required String productName,
      required int productPrice,
      required String category,
      required List<String> image,
      required String vendorId,
      required int productQuantity,
      required int quantity,
      required String productId,
      required String description,
      required String fullName}) {
    state[productId] = Favorite(
        productName: productName,
        productPrice: productPrice,
        category: category,
        image: image,
        vendorId: vendorId,
        productQuantity: productQuantity,
        quantity: quantity,
        productId: productId,
        description: description,
        fullName: fullName);
    //notify listeners that the state has changed
    state = {...state};
    _saveFavorites();
  }

  //method to remove item from the fovorites
  void removeFavoriesItem(String productId) {
    state.remove(productId);

    //notify listenner that the state has changed
    state = {...state};
    _saveFavorites();
  }

  Map<String, Favorite> get getFavoriesItems => state;
}
