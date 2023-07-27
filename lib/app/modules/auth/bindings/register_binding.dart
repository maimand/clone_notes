import 'package:clone_notes/app/data/services/auth_service.dart';
import 'package:clone_notes/app/modules/auth/controllers/register_controller.dart';
import 'package:get/get.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(
      () => RegisterController(Get.find<AuthService>()),
    );
  }
}
