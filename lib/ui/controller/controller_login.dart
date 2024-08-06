import 'package:get/get.dart';

class LoginViewController extends GetxController {
  // RxBool ile tanımlama
  var rememberMe = false.obs;
  var email = ''.obs;
  var password = ''.obs;

  void setEmail(String newEmail) {
    email.value = newEmail;
  }

  void setPassword(String newPassword) {
    password.value = newPassword;
  }

  void setRememberMe(bool value) {
    rememberMe.value = value;
  }

  void login() {
    // Login işlevi
  }

  void loginWithFacebook() {
    // Facebook ile giriş işlevi
  }
}
