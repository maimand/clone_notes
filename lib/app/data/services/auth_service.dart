import 'dart:async';

import 'package:clone_notes/app/data/constants/keys.dart';
import 'package:clone_notes/app/data/models/user_model.dart';
import 'package:clone_notes/app/data/repository/user_repository.dart';
import 'package:clone_notes/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthService extends GetxService {
  final UserRepository userRepository;
  final GetStorage storage = GetStorage();

  UserModel? currentUser;

  String get uid => currentUser?.id ?? '';

  AuthService(this.userRepository);

  void autoLogin() async {
    final id = getUsername();
    final password = getPassword();
    if (id == null || password == null) {
      await Future.delayed(const Duration(seconds: 1), () {
        Get.offAllNamed(Routes.LOGIN);
      });
      return;
    }
    final res = await userRepository.login(id, password);
    if (res != null) {
      currentUser = res;
      await Future.delayed(const Duration(seconds: 1), () {
        unawaited(Get.offAllNamed(Routes.HOME));
      });
    } else {
      logOut();
      await Future.delayed(const Duration(seconds: 1), () {
        Get.offAllNamed(Routes.LOGIN);
      });
    }
  }

  Future<UserModel?> registerUser(
      {required String username, required String password}) async {
    try {
      final user =
          await userRepository.register(username, hashPassword(password));
      currentUser = user;
      setUsername(user.username);
      setPassword(user.password);
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
      currentUser = user;
      setUsername(user.username);
      setPassword(user.password);
      return user;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  String hashPassword(String password) {
    return '${password}secretKey';
  }

  void setUsername(String? value) => storage.write(AppKey.usernameKey, value);

  void setPassword(String? value) => storage.write(AppKey.passwordKey, value);

  String? getUsername() => storage.read(AppKey.usernameKey);

  String? getPassword() => storage.read(AppKey.passwordKey);

  void logOut() {
    Get.offAllNamed(Routes.LOGIN);
    currentUser = null;
    storage
      ..remove(AppKey.usernameKey)
      ..remove(AppKey.passwordKey);
  }
}
