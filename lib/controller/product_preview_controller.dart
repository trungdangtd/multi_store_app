import 'package:multi_store_app/global_variables.dart';
import 'package:multi_store_app/models/product_preview.dart';
import 'package:http/http.dart' as http;
import 'package:multi_store_app/services/manage_http_respone.dart';
class ProductPreviewController {
  uploadReview({
    required String buyerId,
    required String email,
    required String fullName,
    required String productId,
    required double rating,
    required String review,
    required context,
  }) async {
    // Upload review to the server
    try {
      final ProductPreview productPreview = ProductPreview(
        id: '',
        buyerId: buyerId,
        email: email,
        fullName: fullName,
        productId: productId,
        rating: rating,
        review: review,
      );
      http.Response response = await http.post(
        Uri.parse("$uri/api/product-review"),
        body: productPreview.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      manageHttpRespone(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Đánh giá thành công');
          });
    } catch (e) {
      showSnackBar(context, 'Lỗi khi đánh giá: $e');
    }
  }
}
