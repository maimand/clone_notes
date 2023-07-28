import 'package:clone_notes/app/modules/auth/controllers/register_controller.dart';
import 'package:clone_notes/app/widgets/password_text_field.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
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
                const Text(
                  'Clone Notes',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.normal),
                ),
                const SizedBox(height: 8),
                const Text('Create a new account'),
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
                    controller.onRegister();
                  },
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.blue),
                    width: Get.width,
                    padding: const EdgeInsets.all(16),
                    child: const Text(
                      'Register',
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
                    Get.back();
                  },
                  child: Container(
                    width: Get.width,
                    padding: const EdgeInsets.all(16),
                    child: const Text(
                      "Already have account! Let's Login.",
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
