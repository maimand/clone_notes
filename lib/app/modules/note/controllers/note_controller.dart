import 'package:clone_notes/app/data/models/note_model.dart';
import 'package:clone_notes/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class NoteController extends GetxController {
  final HomeController homeController;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final FocusNode titleNode = FocusNode();
  final FocusNode contentNode = FocusNode();

  RxList<NoteModel> notes = <NoteModel>[].obs;
  late NoteModel noteModel;

  NoteController(this.homeController);

  @override
  void onInit() {
    getArguments();
    super.onInit();
  }

  @override
  void onReady() {
    titleController.text = noteModel.title;
    contentController.text = noteModel.content;

    titleController.addListener(onTitleChange);
    contentController.addListener(onContentChange);
    if(titleController.text.isEmpty) {
      titleNode.requestFocus();
    }
    super.onReady();
  }

  void getArguments() {
    final arg = Get.arguments;
    if (arg != null && arg is NoteModel) {
      noteModel = arg;
    } else {
      noteModel =
          NoteModel(id: const Uuid().v4(), title: '', content: '');
    }
  }

  void onSubmitTitle() {
    contentNode.requestFocus();
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
