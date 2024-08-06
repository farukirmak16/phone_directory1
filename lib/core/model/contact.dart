import 'package:json_annotation/json_annotation.dart';

part 'contact.g.dart';

@JsonSerializable()
class Contact {
  late final int id;
  late final String name;
  late final String phoneNumber;
  late final String imageUrl;
  late final String email;

  Contact({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.imageUrl,
    required this.email,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => _$ContactFromJson(json);
  Map<String, dynamic> toJson() => _$ContactToJson(this);
}
