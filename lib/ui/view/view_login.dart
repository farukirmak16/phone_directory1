import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_yeni_tasarim/ui/controller/controller_login.dart';
import 'package:t_yeni_tasarim/ui/widgets/widgets_custom_button.dart';
import 'package:t_yeni_tasarim/ui/widgets/widgets_custom_text_field.dart';
import 'package:t_yeni_tasarim/ui/view/view_register.dart'; // RegisterView'ı import et

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginViewController controller = Get.put(LoginViewController());

    return Scaffold(
      body: SafeArea(
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
              CustomTextField(
                hintText: 'E-mail',
                hintStyle: TextStyle(color: Colors.black.withOpacity(0.20)),
                onChanged: controller.setEmail,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hintText: 'Şifre',
                hintStyle: TextStyle(color: Colors.black.withOpacity(0.20)),
                obscureText: true,
                onChanged: controller.setPassword,
              ),
              const SizedBox(height: 12),
              CustomButton(
                text: 'Giriş Yap',
                onPressed: controller.login, // Doğru türde işlev
              ),
              const SizedBox(height: 24),
              const Text('Veya', textAlign: TextAlign.center),
              const SizedBox(height: 16),
              CustomButton(
                text: 'Google ile Giriş Yap',
                icon: 'assets/google_.png',
                onPressed: () {
                  // Google ile giriş işlevi devre dışı
                },
                isSocialButton: true,
              ),
              const SizedBox(height: 16),
              CustomButton(
                text: 'Facebook ile Giriş Yap',
                icon: 'assets/facebook_.png',
                onPressed: () {
                  // Facebook ile giriş işlevi devre dışı
                },
                isSocialButton: true,
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  // RegisterView'e yönlendir
                  Get.to(() => const RegisterView());
                },
                child: const Center(
                  child: Text(
                    'Hesabın yoksa Hesap oluştur',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
