import 'package:clone_notes/app/data/services/auth_service.dart';
import 'package:clone_notes/app/data/services/firebase_service.dart';
import 'package:get/get.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    final authService = Get.put(AuthService());
    Get.put(FirebaseService(authService));
  }
}
