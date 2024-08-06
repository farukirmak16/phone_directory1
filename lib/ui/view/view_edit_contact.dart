import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_yeni_tasarim/ui/controller/controller_editcontactview.dart';
import 'package:t_yeni_tasarim/ui/widgets/widgets_custom_text_field.dart';
import 'package:t_yeni_tasarim/ui/widgets/widgets_rounded_button.dart';
import 'package:t_yeni_tasarim/ui/view/view_contact_list.dart'; // ContactListView import edilmelidir

class EditContactView extends StatelessWidget {
  const EditContactView({super.key});

  @override
  Widget build(BuildContext context) {
    final EditContactViewController controller =
        Get.find<EditContactViewController>();

    // Get.arguments kullanarak gelen veriyi almak
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      controller.name.value = arguments['name'] ?? '';
      controller.phone.value = arguments['phone'] ?? '';
      controller.email.value = arguments['email'] ?? '';
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Kişi Düzenle'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back(); // Önceki sayfaya geri dön
          },
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  controller.pickImage();
                },
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: controller.imageFile.value != null
                      ? FileImage(File(controller.imageFile.value!.path))
                      : const AssetImage('assets/resim_ekle.png')
                          as ImageProvider,
                  backgroundColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hintText: 'Ad Soyad',
                onChanged: (value) {
                  controller.name.value = value;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hintText: '0555 555 5555', // Cep Telefonu
                onChanged: (value) {
                  controller.phone.value = value;
                },
              ),
              const SizedBox(height: 16),
              Obx(() {
                return controller.additionalPhones.isEmpty &&
                        controller.canAddPhoneField.value
                    ? GestureDetector(
                        onTap: () {
                          controller.addPhoneField();
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.add_circle_outline, color: Colors.grey),
                            SizedBox(width: 8),
                            Text('Bir Numara Daha Ekle'),
                          ],
                        ),
                      )
                    : Container(); // Numara eklendiğinde buton gizlenir
              }),
              const SizedBox(height: 16),
              Obx(() {
                return Column(
                  children: List.generate(controller.additionalPhones.length,
                      (index) {
                    return Column(
                      children: [
                        CustomTextField(
                          hintText: 'Cep Telefonu ${index + 2}',
                          onChanged: (value) {
                            controller.updateAdditionalPhone(index, value);
                          },
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  }),
                );
              }),
              CustomTextField(
                hintText: 'E-posta Adresi',
                onChanged: (value) {
                  controller.email.value = value;
                },
              ),
              const Spacer(),
              RoundedButton(
                text: 'Kaydet',
                onPressed: () {
                  controller.saveContact();
                  Get.to(() =>
                      const ContactListView()); // Yönlendirmeyi işlev olarak yapıyoruz.
                },
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
