// ignore_for_file: constant_identifier_names

import 'package:clone_notes/app/modules/auth/bindings/login_binding.dart';
import 'package:clone_notes/app/modules/auth/bindings/register_binding.dart';
import 'package:clone_notes/app/modules/auth/views/login_view.dart';
import 'package:clone_notes/app/modules/auth/views/register_view.dart';
import 'package:clone_notes/app/modules/home/bindings/home_binding.dart';
import 'package:clone_notes/app/modules/home/views/home_view.dart';
import 'package:clone_notes/app/modules/note/bindings/note_binding.dart';
import 'package:clone_notes/app/modules/note/views/note_view.dart';
import 'package:clone_notes/app/modules/splash/view/splash_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.NOTE,
      page: () => const NoteView(),
      binding: NoteBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
    ),
  ];
}
