import 'package:clone_notes/app/data/models/note_model.dart';
import 'package:clone_notes/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class HomeController extends GetxController {
  List<NoteModel> notesData = [];
  final RxList<NoteModel> noteList = <NoteModel>[].obs;
  final TextEditingController controller = TextEditingController();

  @override
  void onReady() {
    onGetNotes();
    super.onReady();
  }

  void onGetNotes() {
    notesData = [
      NoteModel(id: const Uuid().v4(), title: "title 1", content: "content"),
      NoteModel(id: const Uuid().v4(), title: "title 2", content: "content"),
      NoteModel(id: const Uuid().v4(), title: "title 3", content: "content"),
    ];
    noteList.assignAll(List.from(notesData));
  }

  void onAddNote() {
    Get.toNamed(Routes.NOTE);
  }

  void editNote(NoteModel model) {
    Get.toNamed(Routes.NOTE, arguments: model);
  }

  void onSearchNote() {
    if (controller.text.isEmpty) {
      refreshUI();
      return;
    }
    final searchList = notesData.where((element) =>
        element.title.contains(controller.text) ||
        element.content.contains(controller.text));
    noteList.assignAll(searchList);
  }

  void onUpdateNote(NoteModel note) {
    NoteModel? updatedNote =
        notesData.firstWhereOrNull((element) => element.id == note.id);
    if (updatedNote == null) {
      notesData.add(note);
    } else {
      updatedNote = note;
    }
    onSearchNote();
  }

  void refreshUI() {
    noteList
      ..assignAll(List.from(notesData))
      ..refresh();
  }

  void refreshNotes() {
    notesData.removeWhere(
        (element) => element.title.isEmpty && element.content.isEmpty);
    refreshUI();
  }

  void onDeleteNote(NoteModel note) {
    if (notesData.any((element) => element.id == note.id)) {
      notesData.removeWhere((element) => element.id == note.id);
    }
    onSearchNote();
  }
}
