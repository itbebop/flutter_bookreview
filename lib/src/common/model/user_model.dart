import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  final String? uid; // 고유키
  final String? name;
  final String? email;

  const UserModel({
    this.uid,
    this.name,
    this.email,
  });

  // UserRepository에서 사용
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  @override
  List<Object?> get props => [
        uid,
        name,
        email,
      ];
}
