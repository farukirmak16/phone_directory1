import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable()
class ApiResponse {
  final int id;
  final String name;

  ApiResponse({required this.id, required this.name});

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}
