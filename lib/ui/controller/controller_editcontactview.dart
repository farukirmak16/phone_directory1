import 'dart:convert';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:t_yeni_tasarim/core/model/contact.dart';
import 'package:t_yeni_tasarim/core/service/contact_service.dart';
import 'package:t_yeni_tasarim/core/service/auth_service.dart';
import 'package:t_yeni_tasarim/ui/controller/controller_contactdetail.dart';
import 'package:t_yeni_tasarim/ui/controller/controller_contactlist.dart';
import 'package:t_yeni_tasarim/ui/view/view_contact_list.dart';

class EditContactViewController extends GetxController {
  final ContactService contactService = Get.find<ContactService>();

  final ContactListViewController listController =
      Get.find<ContactListViewController>();
  final AuthService authService = Get.find<AuthService>();
  final ImagePicker _picker = ImagePicker();
  final RxInt id = 0.obs;
  final RxString name = ''.obs;
  final RxString phone = ''.obs;
  final RxString email = ''.obs;
  final RxString imageUrl = ''.obs;
  final Rx<XFile?> imageFile = Rx<XFile?>(null);
  final RxList<String> additionalPhones = <String>[].obs;
  final RxBool canAddPhoneField = true.obs;

  void initializeData({
    required int id,
    required String name,
    required String phone,
    required String email,
    required String imagePath,
  }) {
    this.id.value = id;
    this.name.value = name;
    this.phone.value = phone;
    this.email.value = email;
    imageUrl.value = imagePath;
    if (imagePath.isNotEmpty) {
      imageFile.value = XFile(imagePath);
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = pickedFile;
      final bytes = await imageFile.value?.readAsBytes();
      imageUrl.value = bytes != null ? base64Encode(bytes) : "";
      imageFile(pickedFile);
    }
  }

  // Future<void> uploadImage(XFile imageFile) async {
  //   try {
  //     final bytes = await imageFile.readAsBytes();
  //     final base64Image = base64Encode(bytes);

  //     final uploadedImageUrl =
  //         await contactService.uploadProfileImage(base64Image);
  //     if (uploadedImageUrl != null) {
  //       imageUrl.value = uploadedImageUrl;
  //       Get.snackbar('Başarılı', 'Fotoğraf başarıyla yüklendi');
  //     } else {
  //       Get.snackbar('Hata', 'Fotoğraf yüklenemedi');
  //     }
  //   } catch (e) {
  //     print('Fotoğraf yükleme hatası: $e');
  //     Get.snackbar('Hata', 'Fotoğraf yüklenirken bir hata oluştu');
  //   }
  // }

  void addPhoneField() {
    if (additionalPhones.length < 2) {
      additionalPhones.add('');
      canAddPhoneField.value = additionalPhones.length < 2;
    }
  }

  void updateAdditionalPhone(int index, String phone) {
    if (index < additionalPhones.length) {
      additionalPhones[index] = phone;
    }
  }

  Future<void> updateContact() async {
    try {
      final userId = await authService.getUserId();
      final updatedContact = Contact(
        id: id.value,
        userId: userId ?? '',
        name: name.value,
        phoneNumber: phone.value,
        email: email.value,
        imageUrl: imageUrl.value,
        // Eğer Contact modelinizde additionalPhones varsa, buraya ekleyin
        // additionalPhones: additionalPhones,
      );

      await contactService.updateContact(id.value, updatedContact);

      Get.snackbar('Başarılı', 'Kişi bilgileri güncellendi');
      await listController.loadContacts();

      Get.offAll(() => const ContactListView());
    } catch (e) {
      print('Kişi bilgileri güncellenirken hata oluştu: $e');
      Get.snackbar(
          'Hata', 'Kişi bilgileri güncellenemedi. Lütfen tekrar deneyin.');
    }
  }
}
