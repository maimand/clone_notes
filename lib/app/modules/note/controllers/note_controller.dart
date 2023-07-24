import 'package:clone_notes/app/data/models/note_model.dart';
import 'package:clone_notes/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class NoteController extends GetxController {
  final HomeController homeController;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  RxList<NoteModel> notes = <NoteModel>[].obs;
  late NoteModel noteModel;

  NoteController(this.homeController);

  @override
  void onReady() {
    titleController.addListener(onTitleChange);
    contentController.addListener(onContentChange);
    super.onReady();
  }

  void getArguments() {
    final arg = Get.arguments;
    if (arg != null && arg is NoteModel) {
      noteModel = arg;
    } else {
      noteModel =
          NoteModel(id: const Uuid().v4(), title: 'New Title', content: '');
    }
  }

  void onTitleChange() {
    noteModel.title = titleController.text;
    updateNote();
  }

  void onContentChange() {
    noteModel.content = contentController.text;
    updateNote();
  }

  void updateNote() {
    homeController.onUpdateNote(noteModel);
  }
}
