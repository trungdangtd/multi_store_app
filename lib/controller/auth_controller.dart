import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_store_app/global_variables.dart';
import 'package:multi_store_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:multi_store_app/provider/delivered_order_count_provider.dart';
import 'package:multi_store_app/provider/user_provider.dart';
import 'package:multi_store_app/services/manage_http_respone.dart';
import 'package:multi_store_app/views/screens/authentication_screens/login_screen.dart';
import 'package:multi_store_app/views/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';



class AuthController {
  Future<void> signUpUsers({
    required BuildContext context,
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
    required BuildContext context,
    required String email,
    required String password,
    required WidgetRef ref,
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
            ref.read(userProvider.notifier).setUser(userJson);

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

  //signOut

  Future<void> signOutUser({required BuildContext context,required WidgetRef ref}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      //clear the token and user form share pree
      await preferences.remove('auth_token');
      await preferences.remove('user');
      //clear the user state
      ref.read(userProvider.notifier).signOut();
      ref.read(deliveredOrderCountProvider.notifier).resetCount();
      //navigate to the login screen

      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return const LoginScreen();
      }), (route) => false);

      // ignore: use_build_context_synchronously
      showSnackBar(context, 'đăng xuất thành công');
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, 'Lỗi khi đăng xuất');
    }
  }

  //update user state, city and locality
  Future<void> updateUserLocation({
    required BuildContext context,
    required String id,
    required String state,
    required String city,
    required String locality,
    required WidgetRef ref,
  }) async {
    try {
      http.Response respone = await http.put(Uri.parse('$uri/api/users/$id'),
          body:
              jsonEncode({'state': state, 'city': city, 'locality': locality}),
          headers: <String, String>{
            "Content-Type":
                'application/json; charset=UTF-8', //specify the context type as json
          } //Set the Header for the request
          );
      manageHttpRespone(
          response: respone,
          context: context,
          onSuccess: () async {
            final updatedUser = jsonDecode(respone.body);

            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            final userJson = jsonEncode(updatedUser);

            //update the application state with the user data using riverpod
            ref.read(userProvider.notifier).setUser(userJson);

            //store the date in shared preferences for future use
            await preferences.setString('user', userJson);
            showSnackBar(context, 'Cập nhật thành công');
          });
    } catch (e) {
      showSnackBar(context, 'Lỗi khi cập nhật');
    }
  }
}
