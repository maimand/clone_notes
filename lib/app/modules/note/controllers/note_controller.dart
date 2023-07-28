import 'package:clone_notes/app/data/models/note_model.dart';
import 'package:clone_notes/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NoteController extends GetxController {
  final HomeController homeController;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final FocusNode titleNode = FocusNode();
  final FocusNode contentNode = FocusNode();

  Rx<NoteModel> noteModel = NoteModel.fromText(title: '', content: '').obs;
  bool isNewNote = true;

  NoteController(this.homeController);

  @override
  void onInit() {
    getArguments();
    super.onInit();
  }

  @override
  void onReady() {
    titleController.text = noteModel.value.title;
    contentController.text = noteModel.value.content;

    titleController.addListener(onTitleChange);
    contentController.addListener(onContentChange);
    if (titleController.text.isEmpty) {
      titleNode.requestFocus();
    }
    super.onReady();
  }

  void getArguments() {
    final arg = Get.arguments;
    if (arg != null && arg is NoteModel) {
      noteModel.value = NoteModel.fromJson(arg.toJson());
      isNewNote = false;
    }
  }

  void onSubmitTitle() {
    contentNode.requestFocus();
  }

  void onTitleChange() {
    noteModel.value.title = titleController.text;
    updateNote();
  }

  void onContentChange() {
    noteModel.value.content = contentController.text;
    updateNote();
  }

  void updateNote() {
    noteModel.value.timeStamp = DateTime.now();
    noteModel.refresh();
    homeController.onUpdateNote(noteModel.value);
  }

  void onDeleteNote() {
    Get.back();
    homeController.onDeleteNote(noteModel.value);
  }

  void onBackHome() {
    homeController.refreshNotes();
  }
}
