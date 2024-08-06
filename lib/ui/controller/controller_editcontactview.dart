import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/view_edit_contact.dart';

class EditContactViewController extends GetxController {
  var name = ''.obs;
  var phone = ''.obs;
  var email = ''.obs;
  var imageFile = Rxn<XFile>();
  var additionalPhones = <String>[].obs;
  var canAddPhoneField = true.obs;

  final ImagePicker _picker = ImagePicker();

  get contacts => null;

  @override
  void onInit() {
    super.onInit();
    loadContact();
  }

  Future<void> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = pickedFile;
    }
  }

  void addPhoneField() {
    if (canAddPhoneField.value) {
      additionalPhones.add('');
      canAddPhoneField.value = false;
    }
  }

  void updateAdditionalPhone(int index, String phone) {
    if (index < additionalPhones.length) {
      additionalPhones[index] = phone;
    }
  }

  Future<void> saveContact() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name.value);
    await prefs.setString('phone', phone.value);
    await prefs.setString('email', email.value);
    await prefs.setString('imageFile', imageFile.value?.path ?? '');
    await prefs.setStringList('additionalPhones', additionalPhones);
  }

  Future<void> loadContact() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name.value = prefs.getString('name') ?? '';
    phone.value = prefs.getString('phone') ?? '';
    email.value = prefs.getString('email') ?? '';
    String? imagePath = prefs.getString('imageFile');
    if (imagePath != null && imagePath.isNotEmpty) {
      imageFile.value = XFile(imagePath);
    }
    additionalPhones.value = prefs.getStringList('additionalPhones') ?? [];
    canAddPhoneField.value = additionalPhones.isEmpty;
  }

  void editContact(name, phone, email, imagePath, param4) {
    Get.to(() => const EditContactView(), arguments: {'name': name.value, 'phone': phone.value, 'email': email.value});
  }
}
