import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterViewController extends GetxController {
  var _name = ''.obs;
  var _email = ''.obs;
  var _password = ''.obs;
  var _passwordConfirmation = ''.obs;

  String get name => _name.value;
  String get email => _email.value;
  String get password => _password.value;
  String get passwordConfirmation => _passwordConfirmation.value;

  @override
  void onInit() {
    super.onInit();
    loadRegisterInfo();
  }

  void setName(String value) => _name.value = value;
  void setEmail(String value) => _email.value = value;
  void setPassword(String value) => _password.value = value;
  void setPasswordConfirmation(String value) => _passwordConfirmation.value = value;

  Future<void> saveRegisterInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _name.value);
    await prefs.setString('email', _email.value);
    await prefs.setString('password', _password.value);
    await prefs.setString('passwordConfirmation', _passwordConfirmation.value);
  }

  Future<void> loadRegisterInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _name.value = prefs.getString('name') ?? '';
    _email.value = prefs.getString('email') ?? '';
    _password.value = prefs.getString('password') ?? '';
    _passwordConfirmation.value = prefs.getString('passwordConfirmation') ?? '';
  }

  Future<void> register() async {
    if (_password.value != _passwordConfirmation.value) {
      // Şifreler eşleşmiyor
      print('Şifreler eşleşmiyor!');
      return;
    }
    await saveRegisterInfo();
    // Kayıt işlemi
    print('Kayıt: ${_name.value}, ${_email.value}, ${_password.value}, ${_passwordConfirmation.value}');
  }

  Future<void> registerWithGoogle() async {
    // Google ile kayıt işlemi
    print('Google ile kayıt');
    // Google kaydı tamamlandığında, bilgileri kaydet
    await saveRegisterInfo();
  }

  Future<void> registerWithFacebook() async {
    // Facebook ile kayıt işlemi
    print('Facebook ile kayıt');
    // Facebook kaydı tamamlandığında, bilgileri kaydet
    await saveRegisterInfo();
  }
}
