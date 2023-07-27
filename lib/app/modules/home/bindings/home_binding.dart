import 'package:clone_notes/app/data/repository/note_repository.dart';
import 'package:clone_notes/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';


class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(Get.find<RemoteNoteRepository>()),
    );
  }
}
