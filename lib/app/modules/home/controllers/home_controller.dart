import 'package:clone_notes/app/data/models/note_model.dart';
import 'package:clone_notes/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxList<NoteModel> notes = <NoteModel>[].obs;
  final TextEditingController controller = TextEditingController();

  void onGetNotes() {
    // todo: get notes
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onSearchNote() {}

  void onUpdateNote(NoteModel note) {
    NoteModel? updatedNote =
        notes.firstWhereOrNull((element) => element.id == note.id);
    if (updatedNote == null) {
      notes.add(note);
    } else {
      updatedNote = note;
    }
    notes.refresh();
  }

  void refreshNotes() {
    notes.removeWhere(
        (element) => element.title.isEmpty && element.content.isEmpty);
    notes.refresh();
  }
}
