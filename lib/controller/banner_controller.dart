import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:multi_store_app/global_variables.dart';
import 'package:multi_store_app/models/banner.dart';

class BannerController {
  //fetch all banners
  Future<List<BannerModel>> loadBanners() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/banner'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      // ignore: avoid_print
      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        List<BannerModel> banners =
            data.map((banner) => BannerModel.fromJson(banner)).toList();
        return banners;
      } else if (response.statusCode == 404) {
        return [];
      } else {
        throw Exception('Lỗi khi load banner');
      }
    } catch (e) {
      // ignore: avoid_print
      throw Exception('Lỗi khi load banner: $e');
    }
  }
}
