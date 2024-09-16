import 'package:dio/dio.dart'; // Dio Response sınıfı burada tanımlanır
import 'package:hive/hive.dart';
import 'package:t_yeni_tasarim/core/api/api_client.dart';
import 'package:t_yeni_tasarim/core/service/hive.dart';

class AuthService {
  final ApiClient apiClient;
  final TokenStorage tokenStorage;

  AuthService(this.apiClient, this.tokenStorage);

  Future<void> login(String email, String password) async {
    try {
      final response = await apiClient.post('/login', data: {
        'email': email,
        'password': password,
      });
      handleLoginResponse(response);
    } catch (e) {
      print('Giriş hatası: $e');
    }
  }

  Future<void> register(String username, String password) async {
    try {
      final response = await apiClient.post('/register', data: {
        'username': username,
        'password': password,
      });

      if (response.statusCode == 201) {
        final id = response.data['id']; // API'den userId al
        await saveUserId(id.toString()); // UserId'yi sakla
      } else {
        throw Exception('Failed to register');
      }
    } catch (e) {
      print('Kayıt hatası: $e');
      rethrow;
    }
  }

  void handleLoginResponse(Response response) {
    final data = response.data;

    // Token ve kullanıcı bilgilerini al
    final token = data['token'];
    final user = data['user'];

    // Kullanıcı ID'sini kontrol et
    final userId =
        user != null ? user['id'].toString() : null; // Ensure userId is String

    if (userId != null) {
      // Token'ı sakla
      tokenStorage.saveToken(token);

      // Kullanıcı ID'sini sakla
      saveUserId(userId);

      print('Giriş başarılı! Kullanıcı ID: $userId');
    } else {
      print('Giriş başarılı ama userId eksik');
    }
  }

  Future<void> saveUserId(String id) async {
    final box = await Hive.openBox('authBox');
    await box.put('id', id);
  }

  Future<String> getUserId() async {
    final box = await Hive.openBox('authBox');
    final id = box.get('id');

    if (id == null) {
      throw Exception('User ID not found in Hive');
    }

    return id;
  }

  Future<void> logout() async {
    try {
      // Eğer API üzerinden logout yapmak istiyorsanız, buraya uygun bir istek ekleyin
      // final response = await apiClient.post('/logout');

      // Token'ı ve userId'yi sil
      await tokenStorage.deleteToken();
      await tokenStorage
          .deleteUserId(); // TokenStorage'da kullanıcı ID'sini silmek için bir metod ekleyin

      final a = await tokenStorage.getToken();
      final b = await tokenStorage.getUserId();
      print(a);
      print(b);
      print('Çıkış başarılı');
    } catch (e) {
      print('Çıkış hatası: $e');
      rethrow;
    }
  }
}
