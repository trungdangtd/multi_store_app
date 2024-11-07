import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_store_app/global_variables.dart';
import 'package:multi_store_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:multi_store_app/provider/user_provider.dart';
import 'package:multi_store_app/services/manage_http_respone.dart';
import 'package:multi_store_app/views/screens/authentication_screens/login_screen.dart';
import 'package:multi_store_app/views/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

final providerContainer = ProviderContainer();
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
          password: password,
          token: '');
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginScreen()));
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
          onSuccess: () async {
            //access sharedpreferent for token and user data storage
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            //exrtact the authentification token from the response body
            String token = jsonDecode(respone.body)['token'];

            //STORE the authentification token in the shared preferences
            await preferences.setString('auth_token', token);

            //encode the user data revieved form the backend as json
            final userJson = jsonEncode(jsonDecode(respone.body)['user']);

            //update the application state with the user data using riverpod
            providerContainer.read(userProvider.notifier).setUser(userJson);

            //store the date in shared preferences for future use
            await preferences.setString('user', userJson);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MainScreen()),
                (route) => false);
            showSnackBar(context, 'Đăng nhập thành công');
          });
    } catch (e) {
      // ignore: avoid_print
      print("Error: $e");
    }
  }
}
