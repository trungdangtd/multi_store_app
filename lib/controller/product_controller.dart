import 'dart:convert';

import 'package:multi_store_app/global_variables.dart';
import 'package:multi_store_app/models/product.dart';
import 'package:http/http.dart' as http;

class ProductController {
  Future<List<Product>> loadPopularProducts() async {
    try {
      http.Response response = await http.get(
        Uri.parse("$uri/api/popular-products"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;

        List<Product> products = data
            .map((product) => Product.fromMap(product as Map<String, dynamic>))
            .toList();
        return products;
      } else if (response.statusCode == 404) {
        return [];
      } else {
        throw Exception('Lỗi khi load sản phẩm phổ biến');
      }
    } catch (e) {
      throw Exception('Lỗi khi load sản phẩm phổ biến: $e');
    }
  }

  Future<List<Product>> loadProductByCategory(String category) async {
    try {
      http.Response response = await http.get(
        Uri.parse("$uri/api/products-by-category/$category"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;

        List<Product> products = data
            .map((product) => Product.fromMap(product as Map<String, dynamic>))
            .toList();
        return products;
      } else if (response.statusCode == 404) {
        return [];
      } else {
        throw Exception('Lỗi khi load sản phẩm theo danh mục');
      }
    } catch (e) {
      throw Exception('Lỗi khi load sản phẩm theo danh mục: $e');
    }
  }

  //display related products by subcategory
  Future<List<Product>> loadRelatedProductBySubCategory(
      String productId) async {
    try {
      http.Response response = await http.get(
        Uri.parse("$uri/api/related-products-by-subcategory/$productId"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;

        List<Product> relatedProducts = data
            .map((product) => Product.fromMap(product as Map<String, dynamic>))
            .toList();
        return relatedProducts;
      } else if (response.statusCode == 404) {
        return [];
      } else {
        throw Exception('Lỗi khi load sản phẩm liên quan');
      }
    } catch (e) {
      throw Exception('Lỗi khi load sản phẩm liên quan: $e');
    }
  }

  //method to get the top 10 highest rated products
  Future<List<Product>> loadTopRatedProduct() async {
    try {
      http.Response response = await http.get(
        Uri.parse("$uri/api/top-rated-products"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;

        List<Product> topReatedProducts = data
            .map((product) => Product.fromMap(product as Map<String, dynamic>))
            .toList();
        return topReatedProducts;
      } else if (response.statusCode == 404) {
        return [];
      } else {
        throw Exception('Lỗi khi load sản phẩm top ');
      }
    } catch (e) {
      throw Exception('Lỗi khi load sản phẩm top : $e');
    }
  }

  Future<List<Product>> loadProductBySubCategory(String subCategory) async {
    try {
      http.Response response = await http.get(
        Uri.parse("$uri/api/products-by-subcategory/$subCategory"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;

        List<Product> relatedProducts = data
            .map((product) => Product.fromMap(product as Map<String, dynamic>))
            .toList();
        return relatedProducts;
      } else if (response.statusCode == 404) {
        return [];
      } else {
        throw Exception('Lỗi khi load sản phẩm theo danh mục con');
      }
    } catch (e) {
      throw Exception('Lỗi khi load sản phẩm theo danh mục con: $e');
    }
  }

  Future<List<Product>> sreachProducts(String query) async {
    try {
      http.Response response = await http.get(
        Uri.parse("$uri/api/search-products?query=$query"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print('search response: ${response.body}');
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;

        List<Product> sreachProducts = data
            .map((product) => Product.fromMap(product as Map<String, dynamic>))
            .toList();
        return sreachProducts;
      } else if (response.statusCode == 404) {
        return [];
      } else {
        throw Exception('Lỗi khi tìm kiếm sản phẩm');
      }
    } catch (e) {
      throw Exception('Lỗi khi tìm kiếm sản phẩm: $e');
    }
  }
}
