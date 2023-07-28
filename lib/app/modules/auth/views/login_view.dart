import 'package:clone_notes/app/modules/auth/controllers/login_controller.dart';
import 'package:clone_notes/app/routes/app_pages.dart';
import 'package:clone_notes/app/widgets/password_text_field.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                const Center(
                    child: Text(
                  'Clone Notes',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.normal),
                )),
                const SizedBox(height: 40),
                const Text('Username'),
                TextFormField(
                  controller: controller.usernameController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Please enter username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text('Password'),
                PasswordTextField(
                  textEditingController: controller.passwordController,
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    controller.onLogin();
                  },
                  child: Container(
                    color: Colors.blue,
                    width: Get.width,
                    padding: const EdgeInsets.all(16),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.REGISTER);
                  },
                  child: Container(
                    width: Get.width,
                    padding: const EdgeInsets.all(16),
                    child: const Text(
                      "Don't have account? Register now.",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


