import 'dart:convert';

import 'package:multi_store_app/global_variables.dart';
import 'package:multi_store_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:multi_store_app/services/manage_http_respone.dart';

class AuthController {
  Future<void> signUpUsers({
    required context,
    required String email,
    required String fullname,
    required String password,
  }) async {
    try {
      User user = User(
          id: '',
          fullname: fullname,
          email: email,
          state: '',
          city: '',
          locality: '',
          password: password, token: '');
      http.Response respone = await http.post(Uri.parse('$uri/api/signup'),
          body:
              user.toJson(), //convert user object to json for the request body
          headers: <String, String>{
            "Content-Type":
                'application/json; charset=UTF-8', //specify the context type as json
          } //Set the Header for the request
          );
      manageHttpRespone(
          response: respone,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Tài khoản đã được tạo thành công');
          });
    } catch (e) {
      // ignore: avoid_print
      print("Error: $e");
    }
  }

  //sign in fuction
  Future<void> signInUsers({
    required context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response respone = await http.post(Uri.parse('$uri/api/signin'),
          body: jsonEncode({'email': email, 'password': password}),
          headers: <String, String>{
            "Content-Type":
                'application/json; charset=UTF-8', //specify the context type as json
          } //Set the Header for the request
          );
      manageHttpRespone(
          response: respone,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Đăng nhập thành công');
          });
    } catch (e) {
      // ignore: avoid_print
      print("Error: $e");
    }
  }
}
