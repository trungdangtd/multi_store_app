import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_store_app/controller/order_controller.dart';
import 'package:multi_store_app/services/manage_http_respone.dart';

class DeliveredOrderCountProvider extends StateNotifier<int> {
  DeliveredOrderCountProvider() : super(0);

  Future<void> fetchDeliveredOrderCount(String buyerId, context) async {
    try {
      OrderController orderController = OrderController();
      int count =
          await orderController.getDeleveredOrderCount(buyerId: buyerId);
      state = count;
    } catch (e) {
      showSnackBar(context, 'Lỗi khi lấy số lượng đơn hàng đã giao: $e');
    }
  }

  //method to reset the count
  void resetCount() {
    state = 0;
  }
}

final deliveredOrderCountProvider =
    StateNotifierProvider<DeliveredOrderCountProvider, int>(
        (ref) => DeliveredOrderCountProvider());