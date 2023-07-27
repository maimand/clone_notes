import 'package:clone_notes/app/data/models/note_model.dart';
import 'package:clone_notes/app/data/services/auth_service.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class NoteRepository {

  Query fetchNoteStream();

  Future<void> updateNote(NoteModel note);

  Future<void> removeNote(NoteModel note);

}

class RemoteNoteRepository implements NoteRepository {

  final AuthService authService;

  static final databaseInstance = FirebaseDatabase.instance.ref('notes');

  String get uid => authService.uid;

  RemoteNoteRepository(this.authService);

  @override
  Query fetchNoteStream() {
    final Query logs = databaseInstance.child(uid);
    return logs;
  }

  @override
  Future<void> updateNote(NoteModel note) async {
    final Map<String, Map> updates = {};
    updates['/$uid/${note.id}'] = note.toJson();
    return databaseInstance.update(updates);
  }


  @override
  Future<void> removeNote(NoteModel note) async {
    await databaseInstance.child('$uid/${note.id}').remove();
  }

}