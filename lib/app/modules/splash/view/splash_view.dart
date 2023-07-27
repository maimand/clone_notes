import 'package:clone_notes/app/data/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final AuthService authService = Get.find<AuthService>();

  @override
  void initState() {
    authService.autoLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text(
        'Clone Notes',
        style: TextStyle(fontSize: 60, fontWeight: FontWeight.w700),
      )),
    );
  }
}
