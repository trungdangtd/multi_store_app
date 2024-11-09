import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_store_app/models/cart.dart';

final cartProvider =
    StateNotifierProvider<CartNotifier, Map<String, Cart>>((ref) {
      return CartNotifier({});
    });

class CartNotifier extends StateNotifier<Map<String, Cart>> {
  CartNotifier(super.state);

  //method to add product to the cart
  void addProductToCart(
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
    if (state.containsKey(productId)) {
      //if the product is already in the cart, increase the quantity
      state = {
        ...state,
        productId: Cart(
            productName: state[productId]!.productName,
            productPrice: state[productId]!.productPrice,
            category: state[productId]!.category,
            image: state[productId]!.image,
            vendorId: state[productId]!.vendorId,
            productQuantity: state[productId]!.productQuantity,
            quantity: state[productId]!.quantity + 1,
            productId: state[productId]!.productId,
            description: state[productId]!.description,
            fullName: state[productId]!.fullName)
      };
    } else {
      //if the product is not in the cart, add it to the cart
      state = {
        ...state,
        productId: Cart(
            productName: productName,
            productPrice: productPrice,
            category: category,
            image: image,
            vendorId: vendorId,
            productQuantity: productQuantity,
            quantity: quantity,
            productId: productId,
            description: description,
            fullName: fullName)
      };
    }
  }

  //method to increment the quantity of a product in the cart
  void inCrementCartItem(String productId) {
    if (state.containsKey(productId)) {
      state[productId]!.quantity++;

      //notify listenner that the state has changed
      state = {...state};
    }
  }

  //method to decrement the quantity of a product in the cart
  void deCrementCartItem(String productId) {
    if (state.containsKey(productId)) {
      state[productId]!.quantity--;

      //notify listenner that the state has changed
      state = {...state};
    }
  }

  //method to remove item from the cart
  void removeCartItem(String productId) {
    state.remove(productId);

    //notify listenner that the state has changed
    state = {...state};
  }

  //method to calculate the total items we have of the cart
  double calculateTotalAmount() {
    double totalAmuont = 0.0;
    state.forEach((productId, cartItem) {
      totalAmuont += cartItem.quantity * cartItem.productPrice;
    });
    return totalAmuont;
  }
}
