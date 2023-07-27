import 'package:clone_notes/app/data/repository/note_repository.dart';
import 'package:clone_notes/app/data/repository/user_repository.dart';
import 'package:clone_notes/app/data/services/auth_service.dart';
import 'package:get/get.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    final userRepository = Get.put(RemoteUserRepository());
    final authService = Get.put(AuthService(userRepository));
    Get.put(RemoteNoteRepository(authService));
  }
}
