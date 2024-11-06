import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:multi_store_app/global_variables.dart';
import 'package:multi_store_app/models/category.dart';

class CategoryController {
  
  //load the uploaded categories
Future<List<Category>> loadCategoriess() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/categories'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        List<Category> categories =
            data.map((category) => Category.fromJson(category)).toList();
        return categories;
      }else{
        throw Exception('Lỗi khi load danh mục');
      }
    } catch (e) {
      // ignore: avoid_print
      throw Exception('Lỗi khi load danh mục: $e');
    }
  }

}
