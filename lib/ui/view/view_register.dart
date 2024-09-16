import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_yeni_tasarim/ui/controller/controller_register.dart';
import 'package:t_yeni_tasarim/ui/view/view_login.dart';
import 'package:t_yeni_tasarim/ui/widgets/widgets_custom_button.dart';
import 'package:t_yeni_tasarim/ui/widgets/widgets_custom_text_field.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: GetBuilder<RegisterViewController>(
            init: RegisterViewController(),
            builder: (controller) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Image.asset(
                    'assets/logo.png',
                    height: 40,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Kayıt Ol',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  hintText: 'Ad Soyad',
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.20)),
                  onChanged: controller.setName,
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  hintText: 'E-mail',
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.20)),
                  onChanged: controller.setEmail,
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  hintText: 'Şifre',
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.20)),
                  obscureText: true,
                  onChanged: controller.setPassword,
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  hintText: 'Şifre Tekrarı',
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.20)),
                  obscureText: true,
                  onChanged: controller.setPasswordConfirmation,
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Kayıt Ol',
                  onPressed: controller.register,
                ),
                const SizedBox(height: 16),
                const Text('Veya', textAlign: TextAlign.center),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Google ile Kayıt Ol',
                  icon: 'assets/google_.png',
                  onPressed: () {}, // Şimdilik işlevsizlik için boş bırakın
                  isSocialButton: true,
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Facebook ile Kayıt Ol',
                  icon: 'assets/facebook_.png',
                  onPressed: () {}, // Şimdilik işlevsizlik için boş bırakın
                  isSocialButton: true,
                ),
                const SizedBox(height: 16),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Eğer hesabınız var ise ',
                      ),
                      TextSpan(
                        text: 'Oturum Aç',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(() => const LoginView());
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
