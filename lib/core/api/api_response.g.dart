// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse _$ApiResponseFromJson(Map<String, dynamic> json) => ApiResponse(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$ApiResponseToJson(ApiResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
