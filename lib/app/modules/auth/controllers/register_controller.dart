import 'dart:async';

import 'package:clone_notes/app/data/services/auth_service.dart';
import 'package:clone_notes/app/routes/app_pages.dart';
import 'package:clone_notes/app/utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final AuthService authService;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  RegisterController(this.authService);

  void onRegister() async {
    try {
      CommonUtils.showLoading();
      final res = await authService.registerUser(
          username: usernameController.text.trim(),
          password: passwordController.text.trim());
      if (res != null) {
        unawaited(Get.offAllNamed(Routes.HOME));
      } else {
        CommonUtils.showToast('Username already taken');
      }
    } on Exception catch (e) {
      CommonUtils.showToast('There is something wrong!');
      debugPrint(e.toString());
    } finally {
      CommonUtils.closeLoading();
    }
  }
}
