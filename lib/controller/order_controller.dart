import 'dart:convert';

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

      manageHttpRespone(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Đặt hàng thành công');
          });
    } catch (e) {
      showSnackBar(context, 'Lỗi khi đặt hàng: $e');
    }
  }

  //method to Get orders by buyerId
  Future<List<Order>> loadOrders({required String buyerId}) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/orders/$buyerId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      //check if the response is successful
      if (response.statusCode == 200) {
        //parse the json respone body into dynamic List
        //this convert the json data into a format that can be further processed in Dart
        List<dynamic> data = jsonDecode(response.body);
        //Map the dynamic List to a List of Order objects
        List<Order> orders =
            data.map((order) => Order.fromJson(order)).toList();
        return orders;
      }
      {
        throw Exception('Lỗi khi tải đơn hàng');
      }
    } catch (e) {
      throw Exception('Lỗi khi tải đơn hàng: $e');
    }
  }

  //delete order by id
  Future<void> deleteOrder({required String id, required context}) async {
    try {
      http.Response response = await http.delete(
        Uri.parse('$uri/api/orders/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      manageHttpRespone(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Đã xoá đơn hàng');
          });
    } catch (e) {
      showSnackBar(context, 'Lỗi khi xoá đơn hàng: $e');
    }
  }
}
