import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:t_yeni_tasarim/core/api/api_client.dart';
import 'package:t_yeni_tasarim/core/model/contact.dart';
import 'package:t_yeni_tasarim/core/service/auth_service.dart';
import 'package:t_yeni_tasarim/core/service/hive.dart';

class ContactService extends GetxService {
  final ApiClient apiClient;
  final AuthService authService;
  final Dio dio = Dio();

  ContactService({required this.apiClient, required this.authService});

  final String _baseUrl = 'https://192.168.12.164/api/Contact';

  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<Options> _getAuthOptions() async {
    String? token = await _getToken();
    if (token == null || token.isEmpty) {
      throw Exception("Token eksik!");
    }
    return Options(headers: {'Authorization': 'Bearer $token'});
  }

  Future<void> addContact(Contact contact) async {
    try {
      final userId = await authService.getUserId();
      final options = await _getAuthOptions();

      final response = await dio.post(
        _baseUrl,
        data: {
          'userId': userId,
          ...contact.toJson(),
        },
        options: options,
      );

      if (response.statusCode != 201) {
        throw Exception('Kişi eklenemedi: ${response.statusCode}');
      }
      Get.snackbar('Başarılı', 'Kişi başarıyla eklendi');
    } on DioException catch (e) {
      _handleDioError(e, 'Kişi eklenirken');
    } catch (e) {
      _handleGenericError(e, 'Kişi eklenirken');
    }
  }

  Future<List<Contact>> getContacts() async {
    try {
      final options = await _getAuthOptions();
      final response = await dio.get(_baseUrl, options: options);

      if (response.statusCode == 200) {
        return (response.data as List)
            .map((item) => Contact.fromJson(item))
            .toList();
      } else {
        throw Exception('Kişiler alınamadı: ${response.statusCode}');
      }
    } on DioException catch (e) {
      _handleDioError(e, 'Kişiler alınırken');
      return [];
    } catch (e) {
      _handleGenericError(e, 'Kişiler alınırken');
      return [];
    }
  }

  Future<Contact> getContactById(int id) async {
    try {
      final options = await _getAuthOptions();
      final response = await dio.get('$_baseUrl/$id', options: options);

      if (response.statusCode == 200) {
        return Contact.fromJson(response.data);
      } else {
        throw Exception('Kişi alınamadı: ${response.statusCode}');
      }
    } on DioException catch (e) {
      _handleDioError(e, 'Kişi alınırken');
      rethrow;
    } catch (e) {
      _handleGenericError(e, 'Kişi alınırken');
      rethrow;
    }
  }

  Future<void> updateContact(int contactId, Contact contact) async {
    try {
      final options = await _getAuthOptions();

      final response = await dio.put(
        '$_baseUrl/$contactId',
        data: contact.toJson(),
        options: options,
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        Get.snackbar('Başarılı', 'Kişi başarıyla güncellendi');
      } else {
        throw Exception('Güncelleme başarısız: ${response.statusCode}');
      }
    } on DioException catch (e) {
      _handleDioError(e, 'Kişi güncellenirken');
    } catch (e) {
      _handleGenericError(e, 'Kişi güncellenirken');
    }
  }

  Future<void> deleteContact(int id) async {
    try {
      final options = await _getAuthOptions();
      final response = await dio.delete('$_baseUrl/$id', options: options);

      if (response.statusCode == 200 || response.statusCode == 204) {
        Get.snackbar('Başarılı', 'Kişi başarıyla silindi');
      } else {
        throw Exception('Kişi silinemedi: ${response.statusCode}');
      }
    } on DioException catch (e) {
      _handleDioError(e, 'Kişi silinirken');
    } catch (e) {
      _handleGenericError(e, 'Kişi silinirken');
    }
  }

  // Future<Map<String, dynamic>?> uploadImage(String base64Image) async {
  //   try {
  //     final token = ['token']; // Token, authService üzerinden alındı

  //     final response = await dio.post(
  //       // apiClient yerine doğrudan dio kullanıldı
  //       '/upload',
  //       data: {
  //         'image': base64Image,
  //       },
  //       options: Options(
  //         headers: {'Authorization': 'Bearer $token'},
  //       ),
  //     );

  //     if (response.statusCode == 200) {
  //       return response.data; // API'den dönen response
  //     } else {
  //       throw Exception('Resim yüklenirken bir hata oluştu.');
  //     }
  //   } catch (e) {
  //     print('Resim yüklenirken hata oluştu: $e');
  //     return null;
  //   }
  // }

  void _handleDioError(DioException e, String context) {
    print('$context hata oluştu: ${e.message}');
    if (e.response != null) {
      print('Hata detayları: ${e.response?.data}');
    }
    Get.snackbar('Hata', '$context bir hata oluştu: ${e.message}');
  }

  void _handleGenericError(dynamic e, String context) {
    print('$context beklenmeyen bir hata oluştu: $e');
    Get.snackbar('Hata', '$context beklenmeyen bir hata oluştu: $e');
  }
}
