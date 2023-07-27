import 'package:clone_notes/app/data/models/note_model.dart';
import 'package:clone_notes/app/data/repository/note_repository.dart';
import 'package:clone_notes/app/routes/app_pages.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final NoteRepository noteRepository;

  List<NoteModel> notesData = [];
  final RxList<NoteModel> noteList = <NoteModel>[].obs;
  final TextEditingController controller = TextEditingController();

  late final Stream<DatabaseEvent> stream;

  HomeController(this.noteRepository);

  @override
  void onReady() {
    onGetNotes();
    setupStream();
    super.onReady();
  }

  void onGetNotes() async {
    try {
      final data = await noteRepository.fetchNoteStream().once();
      mapDatabaseEventToNotes(data);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  void setupStream() {
    try {
      stream = noteRepository.fetchNoteStream().onValue;
      stream.listen((DatabaseEvent event) {
        try {
          mapDatabaseEventToNotes(event);
        } on Exception catch (e) {
          debugPrint(e.toString());
        }
      });
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  void mapDatabaseEventToNotes(DatabaseEvent event) {
    final mapData = event.snapshot.value;
    if (mapData == null || mapData is! Map) {
      throw Exception('Failed to load note');
    }
    final List<NoteModel> notes = [];
    mapData.forEach((key, values) {
      if (values is Map) {
        notes.add(NoteModel(
            id: key,
            title: values['title'] ?? '',
            content: values['content'] ?? '',
            timeStamp:
                DateTime.tryParse(values['timeStamp']) ?? DateTime.now()));
      }
    });
    notesData.assignAll(List.from(notes));
    onSearchNote();
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
    sortNotesData();
  }

  void sortNotesData() {
    noteList
      ..sort((a, b) {
        return (b.timeStamp ?? DateTime.now())
            .compareTo(a.timeStamp ?? DateTime.now());
      })
      ..refresh();
  }

  void onUpdateNote(NoteModel note) {
    final int index = notesData.indexWhere((element) => element.id == note.id);
    if (index == -1) {
      if (note.title.isNotEmpty && note.content.isNotEmpty) {
        noteRepository.updateNote(note);
      }
      return;
    }
    final selectedNote = notesData.elementAt(index);
    if (selectedNote.title != note.title ||
        selectedNote.content != note.content) {
      selectedNote
        ..title = note.title
        ..content = note.content
        ..timeStamp = DateTime.now();
      noteRepository.updateNote(selectedNote);
    }
    onSearchNote();
  }

  void refreshUI() {
    noteList
      ..assignAll(List.from(notesData))
      ..refresh();
    sortNotesData();
  }

  void refreshNotes() {
    notesData
      ..forEach((element) {
        if (element.title.isEmpty && element.content.isEmpty) {
          noteRepository.removeNote(element);
        }
      })
      ..removeWhere(
          (element) => element.title.isEmpty && element.content.isEmpty);
    onSearchNote();
  }

  void onDeleteNote(NoteModel note) {
    if (notesData.any((element) => element.id == note.id)) {
      noteRepository.removeNote(note);
    }
  }
}
