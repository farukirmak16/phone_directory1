import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:t_yeni_tasarim/ui/controller/controller_editcontactview.dart';
import 'package:t_yeni_tasarim/ui/view/view_contact_list.dart';
import 'package:t_yeni_tasarim/ui/widgets/widgets_custom_text_field.dart';
import 'package:t_yeni_tasarim/ui/widgets/widgets_rounded_button.dart';

class EditContactView extends StatelessWidget {
  const EditContactView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>?;

    final name = arguments?['name'] as String? ?? '';
    final phone = arguments?['phone'] as String? ?? '';
    final email = arguments?['email'] as String? ?? '';
    final imageUrl = arguments?['imagePath'] as String? ?? '';
    final id = arguments?['id'] as int? ?? 0;

    final controller = Get.find<EditContactViewController>();

    // Initialize controller data
    controller.initializeData(
      id: id,
      name: name,
      phone: phone,
      email: email,
      imagePath: imageUrl,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Kişiyi Düzenle'),
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
            Obx(() => GestureDetector(
                  onTap: () => controller.pickImage(),
                  child: Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: controller.imageUrl.value.isEmpty
                            ? const AssetImage(
                                'assets/user-profile-default.png') // Eğer imageUrl boşsa, varsayılan resmi kullan
                            : MemoryImage(getBackgroundImage(
                                controller)), // Base64 resmi göster
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )),
            const SizedBox(height: 16),
            Obx(() => CustomTextField(
                  hintText: 'Ad Soyad',
                  initialValue: controller.name.value,
                  onChanged: (value) => controller.name.value = value,
                )),
            const SizedBox(height: 16),
            Obx(() => CustomTextField(
                  hintText: '0555 555 5555',
                  initialValue: controller.phone.value,
                  onChanged: (value) => controller.phone.value = value,
                )),
            const SizedBox(height: 16),
            Obx(() => CustomTextField(
                  hintText: 'E-posta Adresi',
                  initialValue: controller.email.value,
                  onChanged: (value) => controller.email.value = value,
                )),
            const Spacer(),
            RoundedButton(
              text: 'Kaydet',
              onPressed: () {
                controller.updateContact();
                Get.offAll(() => const ContactListView());
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
        ),
      ),
    );
  }

  Uint8List getBackgroundImage(EditContactViewController controller) {
    Uint8List imageBytes = base64Decode(controller.imageUrl.value);
    return imageBytes;
  }
}
