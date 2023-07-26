import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'note_model.g.dart';

@JsonSerializable()
class NoteModel {
  @JsonKey(defaultValue: '')
  String id;
  @JsonKey(defaultValue: '')
  String title;
  @JsonKey(defaultValue: '')
  String content;
  DateTime? timeStamp;

  String get description {
    if (content == null) {
      return '';
    }
    if (content.isNotEmpty && content.contains('\n')) {
      return content.split('\n').first;
    }
    return content;
  }

  NoteModel(
      {required this.id,
      required this.title,
      required this.content,
      this.timeStamp});

  factory NoteModel.fromText({required String title, required String content}) {
    return NoteModel(
      id: const Uuid().v4(),
      title: title,
      content: content,
      timeStamp: DateTime.now(),
    );
  }

  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      _$NoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$NoteModelToJson(this);
}
