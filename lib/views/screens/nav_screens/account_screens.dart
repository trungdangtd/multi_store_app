import 'package:flutter/material.dart';
import 'package:multi_store_app/controller/auth_controller.dart';

class AccountScreens extends StatelessWidget {
   AccountScreens({super.key});
  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: ()async{
          await _authController.signOutUser(context: context);
        }, child: Text('Đăng xuất'),),
      ),
    );
  }
}
