import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:t_yeni_tasarim/core/service/auth_service.dart';
import 'package:t_yeni_tasarim/core/service/hive.dart';
import 'package:t_yeni_tasarim/ui/controller/controller_contactlist.dart';
import 'dart:convert'; // JSON için

import '../view/view_contact_list.dart';

class LoginViewController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var rememberMe = false.obs;

  final TokenStorage tokenStorage = Get.find<TokenStorage>();
  final AuthService authService = Get.find<AuthService>();
  final ContactListViewController listController =
      Get.find<ContactListViewController>();

  void setEmail(String newEmail) {
    email.value = newEmail;
  }

  void setPassword(String newPassword) {
    password.value = newPassword;
  }

  void setRememberMe(bool value) {
    rememberMe.value = value;
  }

  void login() async {
    try {
      final response = await http.post(
        Uri.parse('https://192.168.12.164/api/Auth/login'),
        body: jsonEncode({
          'email': email.value,
          'password': password.value,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        final user = data['user'];
        final userId = user != null ? user['id'] : null;

        if (token == null) {
          print('Giriş başarılı ama token eksik: ${response.body}');
          return;
        }

        if (userId == null) {
          print('Giriş başarılı ama userId eksik: ${response.body}');
          return;
        }

        // Token'ı kaydet
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        print('Saklanan token: $token');

        // Token'ı ve userId'yi TokenStorage ve AuthService'e kaydet
        await tokenStorage.saveToken(token);
        await authService.saveUserId(userId.toString());

        print('Giriş başarılı');

        await listController.loadContacts();

        Get.offAll(() => const ContactListView());
      } else {
        print('Giriş başarısız: ${response.body}');
      }
    } catch (e) {
      print('Giriş sırasında bir hata oluştu: $e');
    }
  }
}
