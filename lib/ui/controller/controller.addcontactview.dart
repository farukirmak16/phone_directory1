import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddContactViewController extends GetxController {
  var name = RxString('');
  var phone = RxString('');
  var email = RxString('');
  Rxn<XFile> imageFile = Rxn<XFile>();
  RxList<String> additionalPhones = RxList<String>([]);
  final _canAddPhoneField = true.obs;

  final ImagePicker _picker = ImagePicker();

  bool get canAddPhoneField => _canAddPhoneField.value;

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
      _canAddPhoneField.value =
          false; // Bir telefon numarası ekledikten sonra tekrar eklemeyi engeller
    }
  }

  void updateAdditionalPhone(int index, String phone) {
    if (index < additionalPhones.length) {
      additionalPhones[index] = phone;
    }
  }

  void saveContact() {
    // Kişi kaydetme işlemi
    print('Kişi kaydedildi: ${name.value}, ${phone.value}, ${email.value}');
    print('Ek telefonlar: ${additionalPhones.join(", ")}');
    print('Resim yolu: ${imageFile.value?.path}');
  }
}
