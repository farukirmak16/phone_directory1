import 'package:json_annotation/json_annotation.dart';

part 'contact.g.dart';

@JsonSerializable()
class Contact {
  int id;
  String name;
  String phoneNumber;
  String imageUrl;
  String email;
  String userId; // userId alanı eklendi

  Contact({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.imageUrl,
    required this.email,
    required this.userId, // userId alanı için de required eklendi
  });

  factory Contact.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);
  Map<String, dynamic> toJson() => _$ContactToJson(this);
}
