import 'package:clone_notes/app/modules/home/controllers/home_controller.dart';
import 'package:clone_notes/app/modules/note/controllers/note_controller.dart';
import 'package:get/get.dart';


class NoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NoteController>(
      () => NoteController(Get.find<HomeController>()),
    );
  }
}
