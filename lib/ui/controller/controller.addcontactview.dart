import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:t_yeni_tasarim/core/model/contact.dart';
import 'package:t_yeni_tasarim/core/service/auth_service.dart';
import 'package:t_yeni_tasarim/core/service/contact_service.dart';
import 'package:t_yeni_tasarim/ui/controller/controller_contactlist.dart';

class AddContactViewController extends GetxController {
  var name = RxString('');
  var phone = RxString('');
  var email = RxString('');
  Rxn<XFile> imageFile = Rxn<XFile>();
  RxList<String> additionalPhones = RxList<String>([]);
  final _canAddPhoneField = true.obs;
  final AuthService _authService = Get.find<AuthService>();
  final ImagePicker _picker = ImagePicker();
  final ContactService contactService = Get.find<ContactService>();

  bool get canAddPhoneField => _canAddPhoneField.value;

  get id => 0; // ID, yeni bir kişi oluşturulurken 0 olarak ayarlanabilir.

  Future<void> pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = pickedFile;
    }
  }

  void addPhoneField() {
    if (_canAddPhoneField.value) {
      additionalPhones.add('');
      _canAddPhoneField.value = false;
    }
  }

  void updateAdditionalPhone(int index, String phone) {
    if (index < additionalPhones.length) {
      additionalPhones[index] = phone;
    }
  }

  Future<void> saveContact() async {
    try {
      final userId = await _authService.getUserId();

      if (userId == null) {
        throw Exception('User ID not found');
      }

      final contact = Contact(
        id: id,
        name: name.value,
        phoneNumber: phone.value,
        imageUrl: imageFile.value?.path ?? '',
        email: email.value,
        userId: userId,
      );

      // addContact metodu void döndürdüğü için bir değişkene atamıyoruz
      await contactService.addContact(contact);

      // Kişi listesini güncellemek için kişi listesi controller'ı kullanılır
      final ContactListViewController listController =
          Get.find<ContactListViewController>();
      await listController.loadContacts();

      Get.back();
      Get.snackbar('Başarılı', 'Kişi başarıyla eklendi');
    } catch (e) {
      print('Failed to save contact: $e');
      if (e is DioException) {
        print('Dio Error: ${e.message}');
        if (e.response != null) {
          print('Response data: ${e.response?.data}');
          print('Response headers: ${e.response?.headers}');
          print('Response request: ${e.response?.requestOptions}');
        } else {
          print('Request data: ${e.requestOptions}');
        }
      } else {
        print('Unexpected error: $e');
      }
      Get.snackbar('Hata', 'Kişi eklenirken bir hata oluştu: ${e.toString()}');
    }
  }
}
