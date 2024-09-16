import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:t_yeni_tasarim/core/service/hive.dart';
import 'package:t_yeni_tasarim/core/model/contact.dart';
import 'package:t_yeni_tasarim/core/model/login.dart';
import 'package:t_yeni_tasarim/core/model/register.dart';
import 'package:t_yeni_tasarim/core/model/user.dart';

class ApiClient {
  final dio.Dio _dio;

  ApiClient(this._dio) {
    _dio.interceptors.add(
      dio.InterceptorsWrapper(
        onRequest: (options, handler) async {
          final tokenStorage = Get.find<TokenStorage>();
          final token =
              await tokenStorage.getToken(); // Token'ı async olarak alıyoruz
          if (token != null) {
            options.headers['Authorization'] = 'Bearer ' + token;
          }
          return handler.next(options); // İşlemi bir sonraki aşamaya geçir
        },
      ),
    );
  }

  final String baseUrl = 'https://192.168.12.164';

  // Auth
  Future<User> register(RegisterModel registerModel) async {
    final response = await _dio.post('$baseUrl/api/Auth/register',
        data: registerModel.toJson());
    return User.fromJson(response.data);
  }

  Future<User> login(LoginModel loginModel) async {
    final response =
        await _dio.post('$baseUrl/api/Auth/login', data: loginModel.toJson());
    return User.fromJson(response.data);
  }

  // Contact
  Future<List<Contact>> getContacts() async {
    final response = await _dio.get('$baseUrl/api/Contact');
    final List<dynamic> data = response.data;
    return data.map((json) => Contact.fromJson(json)).toList();
  }

  Future<Contact> getContactById(int id) async {
    final response = await _dio.get('$baseUrl/api/Contact/$id');
    return Contact.fromJson(response.data);
  }

  Future<Contact> createContact(Contact contact) async {
    final response =
        await _dio.post('$baseUrl/api/Contact', data: contact.toJson());
    return Contact.fromJson(response.data);
  }

  Future updateContact(int id, Contact contact) async {
    await _dio.put('$baseUrl/api/Contact/$id', data: contact.toJson());
  }

  Future<void> deleteContact(int id) async {
    await _dio.delete('$baseUrl/api/Contact/$id');
  }

  // User
  Future<List<User>> getUsers() async {
    final response = await _dio.get('$baseUrl/api/User');
    final List<dynamic> data = response.data;
    return data.map((json) => User.fromJson(json)).toList();
  }

  Future<User> getUserById(int id) async {
    final response = await _dio.get('$baseUrl/api/User/$id');
    return User.fromJson(response.data);
  }

  Future<User> createUser(User user) async {
    final response = await _dio.post('$baseUrl/api/User', data: user.toJson());
    return User.fromJson(response.data);
  }

  Future<void> updateUser(int id, User user) async {
    await _dio.put('$baseUrl/api/User/$id', data: user.toJson());
  }

  Future<void> deleteUser(int id) async {
    await _dio.delete('$baseUrl/api/User/$id');
  }

  Future<dio.Response> post(String path,
      {required Map<String, dynamic> data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } catch (e) {
      throw Exception('API request failed: $e');
    }
  }
}
