import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(defaultValue: '')
  String id;
  @JsonKey(defaultValue: '')
  String username;
  @JsonKey(defaultValue: '')
  String password;

  String? checkIdentity(String username, String password) {
    if (this.username == username && this.password == password) {
      return id;
    }
    return null;
  }

  UserModel({
    required this.id,
    required this.username,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
