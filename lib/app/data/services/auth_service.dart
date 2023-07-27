import 'package:clone_notes/app/data/models/user_model.dart';
import 'package:clone_notes/app/data/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  final UserRepository userRepository;

  String uid = 'man-test';

  AuthService(this.userRepository);

  Future<void> registerUser(
      {required String username, required String password}) {
    return userRepository.register(username, hashPassword(password));
  }

  Future<UserModel?> login(
      {required String username, required String password}) async {
    try {
      final user = userRepository.login(username, hashPassword(password));
      return user;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  String hashPassword(String password) {
    return '${password}secretKey';
  }
}
