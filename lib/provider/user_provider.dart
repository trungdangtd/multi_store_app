import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_store_app/models/user.dart';

class UserProvider extends StateNotifier<User?> {
  UserProvider()
      : super(User(
            id: '',
            fullname: '',
            email: '',
            state: '',
            city: '',
            locality: '',
            password: '',
            token: ''));

  User? get user => state;

  void setUser(String userJson) {
    state = User.fromJson(userJson);
  }

}

final userProvider =
      StateNotifierProvider<UserProvider, User?>((ref) => UserProvider());
