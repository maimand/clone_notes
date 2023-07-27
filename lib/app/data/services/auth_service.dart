import 'package:clone_notes/app/data/models/user_model.dart';
import 'package:clone_notes/app/data/repository/user_repository.dart';
import 'package:clone_notes/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  final UserRepository userRepository;

  String uid = 'man-test';

  AuthService(this.userRepository);
  
  void autoLogin() {
    Future.delayed(const Duration(seconds: 1), () {
      Get.offAllNamed(Routes.LOGIN);
    });
  }

  Future<UserModel?> registerUser(
      {required String username, required String password}) async {
    try {
      final user = await userRepository.register(username, hashPassword(password));
      uid = user.id;
      return user;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<UserModel?> login(
      {required String username, required String password}) async {
    try {
      final user = await userRepository.login(username, hashPassword(password));
      uid = user.id;
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
