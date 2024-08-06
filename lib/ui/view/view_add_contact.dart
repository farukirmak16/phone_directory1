import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:t_yeni_tasarim/ui/view/view_contact_list.dart';
import 'package:t_yeni_tasarim/ui/widgets/widgets_custom_text_field.dart';
import 'package:t_yeni_tasarim/ui/widgets/widgets_rounded_button.dart';

import '../controller/controller.addcontactview.dart';

class AddContactView extends StatelessWidget {
  const AddContactView({super.key});

  @override
  Widget build(BuildContext context) {
    final AddContactViewController controller = Get.put(AddContactViewController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Kişi Ekle'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                controller.pickImage();
              },
              child: Obx(() {
                return CircleAvatar(
                  radius: 40,
                  backgroundImage: controller.imageFile.value != null
                      ? FileImage(File(controller.imageFile.value!.path))
                      : const AssetImage('assets/resim_ekle.png') as ImageProvider,
                  backgroundColor: Colors.grey[200],
                );
              }),
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
              hintText: 'Cep Telefonu',
              onChanged: (value) {
                controller.phone.value = value;
              },
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                controller.addPhoneField();
              },
              child: Obx(() {
                return controller.additionalPhones.isEmpty
                    ? const Row(
                        children: [
                          Icon(Icons.add, color: Colors.grey),
                          SizedBox(width: 8),
                          Text('Bir Numara Daha Ekle'),
                        ],
                      )
                    : Container(); // Numara eklendiğinde buton gizlenir
              }),
            ),
            const SizedBox(height: 16),
            Obx(() {
              return Column(
                children: List.generate(controller.additionalPhones.length, (index) {
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
                Get.to(const ContactListView());
              },
              textColor: Colors.white,
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
