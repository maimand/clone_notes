import 'package:clone_notes/app/data/services/auth_service.dart';
import 'package:clone_notes/app/modules/auth/controllers/login_controller.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(Get.find<AuthService>()),
    );
  }
}
