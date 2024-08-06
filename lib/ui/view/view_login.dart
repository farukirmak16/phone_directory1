import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:t_yeni_tasarim/ui/controller/controller_login.dart';
import 'package:t_yeni_tasarim/ui/view/view_contact_list.dart';
import 'package:t_yeni_tasarim/ui/view/view_register.dart';
import 'package:t_yeni_tasarim/ui/widgets/widgets_custom_button.dart';
import 'package:t_yeni_tasarim/ui/widgets/widgets_custom_text_field.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginViewController controller = Get.put(LoginViewController());

    return Scaffold(
      body: Obx(
        () => SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Image.asset(
                    'assets/logo.png',
                    height: 40,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Giriş Yap',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 24),
                const SizedBox(height: 16),
                CustomTextField(
                  hintText: 'E-mail',
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.20)),
                  onChanged: (value) {
                    controller.setEmail(value);
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  hintText: 'Şifre',
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.20)),
                  obscureText: true,
                  onChanged: (value) {
                    controller.setPassword(value);
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: controller.rememberMe.value,
                          onChanged: (value) {
                            controller.setRememberMe(value ?? false);
                          },
                        ),
                        const Text('Beni Hatırla'),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        // Şifremi unuttum işlevi
                        print("Şifremi Unuttum clicked");
                      },
                      child: Text(
                        'Şifremi Unuttum',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                CustomButton(
                  text: 'Giriş Yap',
                  onPressed: () {
                    controller.login();
                    Get.to(const ContactListView());
                  },
                ),
                const SizedBox(height: 24),
                const Text('Veya', textAlign: TextAlign.center),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Google ile Giriş Yap',
                  icon: 'assets/google_.png',
                  onPressed: () {
                    // Google ile giriş yap butonuna basıldığında
                    Get.to(const ContactListView());
                  },
                  isSocialButton: true,
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Facebook ile Giriş Yap',
                  icon: 'assets/facebook_.png',
                  onPressed: () {
                    controller.loginWithFacebook();
                  },
                  isSocialButton: true,
                ),
                const SizedBox(height: 24),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Hesabınız yok mu? ',
                      ),
                      TextSpan(
                        text: 'Hesap Oluştur',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(const RegisterView());
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
