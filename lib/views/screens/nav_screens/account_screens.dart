import 'package:flutter/material.dart';
import 'package:multi_store_app/controller/auth_controller.dart';
import 'package:multi_store_app/views/screens/detail/screens/order_screen.dart';

class AccountScreens extends StatefulWidget {
  const AccountScreens({super.key});

  @override
  State<AccountScreens> createState() => _AccountScreensState();
}

class _AccountScreensState extends State<AccountScreens> {
  final AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // await _authController.signOutUser(context: context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return OrderScreen();
                },
              ),
            );
          },
          child: const Text('Đăng xuất'),
        ),
      ),
    );
  }
}
