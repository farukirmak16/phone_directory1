import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String userName;
  final bool emailConfirmed;
  final String name;
  final String? phoneNumber; // Opsiyonel yapılmış
  final String? imageUrl; // Opsiyonel yapılmış
  final String email;

  User({
    required this.id,
    required this.userName,
    required this.emailConfirmed,
    required this.name,
    this.phoneNumber, // Nullable tanımlandı
    this.imageUrl, // Nullable tanımlandı
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
