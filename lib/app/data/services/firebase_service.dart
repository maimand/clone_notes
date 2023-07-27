import 'package:clone_notes/app/data/models/note_model.dart';
import 'package:clone_notes/app/data/services/auth_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class FirebaseService extends GetxService {
  final AuthService authService;

  static final databaseInstance = FirebaseDatabase.instance;

  String get uid => authService.uid;

  FirebaseService(this.authService);

  Query fetchNoteStream() {
    final Query logs = databaseInstance.ref(uid);
    return logs;
  }

  Future<void> updateNote(NoteModel note) async {
    final Map<String, Map> updates = {};
    updates['/$uid/${note.id}'] = note.toJson();
    return databaseInstance.ref().update(updates);
  }

  Future<void> removeNote(NoteModel note) async {
    await FirebaseDatabase.instance.ref().child('$uid/${note.id}').remove();
  }
}
