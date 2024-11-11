import 'package:multi_store_app/global_variables.dart';
import 'package:multi_store_app/models/order.dart';
import 'package:http/http.dart' as http;
import 'package:multi_store_app/services/manage_http_respone.dart';

class OrderController {
  uploadOrders({
    required String id,
    required String fullName,
    required String email,
    required String state,
    required String city,
    required String locality,
    required String productName,
    required int productPrice,
    required int quantity,
    required String category,
    required String image,
    required String buyerId,
    required String vendorId,
    required bool processing,
    required bool delivered,
    required context,
  }) async {
    try {
      final Order order = Order(
          id: id,
          fullName: fullName,
          email: email,
          state: state,
          city: city,
          locality: locality,
          productName: productName,
          productPrice: productPrice,
          quantity: quantity,
          category: category,
          image: image,
          buyerId: buyerId,
          vendorId: vendorId,
          processing: processing,
          delivered: delivered);

      http.Response response = await http.post(
        Uri.parse("$uri/api/orders"),
        body: order.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      manageHttpRespone(response: response, context: context, onSuccess: () {
        showSnackBar(context, 'Đặt hàng thành công');
      });
    } catch (e) {
      showSnackBar(context, 'Lỗi khi đặt hàng: $e');
    }
  }
}
