// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      userName: json['userName'] as String,
      emailConfirmed: json['emailConfirmed'] as bool,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      imageUrl: json['imageUrl'] as String?,
      email: json['email'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'emailConfirmed': instance.emailConfirmed,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'imageUrl': instance.imageUrl,
      'email': instance.email,
    };
