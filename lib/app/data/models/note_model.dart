import 'package:json_annotation/json_annotation.dart';

part 'note_model.g.dart';

@JsonSerializable()
class NoteModel {
  String id;
  String title;
  String content;

  String get description {
    if (content.isNotEmpty && content.contains('\n')) {
      return content.split('\n').first;
    }
    return content;
  }

  NoteModel({required this.id, required this.title, required this.content});

  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      _$NoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$NoteModelToJson(this);
}
