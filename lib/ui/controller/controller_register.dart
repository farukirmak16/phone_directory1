import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:t_yeni_tasarim/ui/view/view_contact_list.dart'; // JSON için

class RegisterViewController extends GetxController {
  final _name = ''.obs;
  final _email = ''.obs;
  final _password = ''.obs;
  final _passwordConfirmation = ''.obs;

  String get name => _name.value;
  String get email => _email.value;
  String get password => _password.value;
  String get passwordConfirmation => _passwordConfirmation.value;

  void setName(String value) => _name.value = value;
  void setEmail(String value) => _email.value = value;
  void setPassword(String value) => _password.value = value;
  void setPasswordConfirmation(String value) =>
      _passwordConfirmation.value = value;

  Future<void> register() async {
    if (_password.value != _passwordConfirmation.value) {
      // Şifreler eşleşmiyor
      print('Şifreler eşleşmiyor!');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('https://192.168.12.164/api/Auth/register'), // API kayıt URL
        body: jsonEncode({
          'name': _name.value,
          'email': _email.value,
          'password': _password.value,
          'password_confirmation': _passwordConfirmation.value,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Yanıtın içeriğini kontrol edin
        final responseData = jsonDecode(response.body);

        if (responseData != null) {
          print('Kayıt başarılı');
          await saveRegisterInfo(); // Bilgileri local storage'a kaydedelim
          Get.to(() => const ContactListView());
        } else {
          print('Kayıt başarısız: ${responseData['message']}');
        }
      } else {
        print('Kayıt başarısız: ${response.body}');
      }
    } catch (e) {
      print('Kayıt sırasında hata: $e');
    }
  }

  Future<void> saveRegisterInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', _email.value);
    await prefs.setString('password', _password.value);
  }
}
