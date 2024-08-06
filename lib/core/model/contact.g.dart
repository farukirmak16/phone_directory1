// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contact _$ContactFromJson(Map<String, dynamic> json) => Contact(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      imageUrl: json['imageUrl'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'imageUrl': instance.imageUrl,
      'email': instance.email,
    };
