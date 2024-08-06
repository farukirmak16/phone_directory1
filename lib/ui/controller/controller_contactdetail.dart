import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:t_yeni_tasarim/core/model/contact.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import '../view/view_edit_contact.dart';

class ContactDetailViewController extends GetxController {
  final _contact = Rx<Contact>(
      Contact(id: 0, name: '', phoneNumber: '', imageUrl: '', email: ''));

  String get name => _contact.value.name;
  String get phoneNumber => _contact.value.phoneNumber;
  String get imageUrl => _contact.value.imageUrl;
  String get email => _contact.value.email; // Eklenen email getter'ı
  int get id => _contact.value.id;

  set name(String newName) => _contact.update((val) => val?.name = newName);
  set phoneNumber(String newPhoneNumber) =>
      _contact.update((val) => val?.phoneNumber = newPhoneNumber);
  set imageUrl(String newImageUrl) =>
      _contact.update((val) => val?.imageUrl = newImageUrl);
  set email(String newEmail) =>
      _contact.update((val) => val?.email = newEmail); // Eklenen email setter'ı

  @override
  void onInit() {
    super.onInit();
    // Eğer bir id parametresi varsa, init metodunu çağır
    if (Get.parameters.containsKey('id')) {
      int id = int.parse(Get.parameters['id']!);
      init(id);
    }
  }

  Future<void> init(int id) async {
    _contact.value = await fetchContactById(id);
  }

  Future<Contact> fetchContactById(int id) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? contactList = prefs.getStringList('contacts');

    if (contactList != null) {
      final contacts = contactList
          .map((contact) => Contact.fromJson(jsonDecode(contact)))
          .toList();
      return contacts.firstWhere((contact) => contact.id == id,
          orElse: () => Contact(
              id: id,
              name: 'Unknown',
              phoneNumber: 'Unknown',
              imageUrl: '',
              email: ''));
    }

    return Contact(
        id: id,
        name: 'Unknown',
        phoneNumber: 'Unknown',
        imageUrl: '',
        email: '');
  }

  Future<void> saveContactDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('contactName', name);
    await prefs.setString('contactPhoneNumber', phoneNumber);
    await prefs.setString('contactImageUrl', imageUrl);
    await prefs.setString('contactEmail', email); // Eklenen email kaydetme

    // Mevcut contacts listesini güncelle
    List<String>? contactList = prefs.getStringList('contacts');
    if (contactList != null) {
      int index = contactList.indexWhere((contact) {
        Contact c = Contact.fromJson(jsonDecode(contact));
        return c.id == id;
      });

      if (index != -1) {
        contactList[index] = jsonEncode(_contact.value.toJson());
        await prefs.setStringList('contacts', contactList);
      }
    }
  }

  Future<void> loadContactDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('contactName') ?? 'Unknown';
    phoneNumber = prefs.getString('contactPhoneNumber') ?? 'Unknown';
    imageUrl = prefs.getString('contactImageUrl') ?? '';
    email = prefs.getString('contactEmail') ?? ''; // Eklenen email yükleme
  }

  void updateContactDetail(String newName, String newPhoneNumber,
      String newImageUrl, String newEmail) {
    name = newName;
    phoneNumber = newPhoneNumber;
    imageUrl = newImageUrl;
    email = newEmail;
    saveContactDetail();
  }

  void sendMessage() {
    final Uri messageUri = Uri(scheme: 'sms', path: phoneNumber);
    launchUrl(messageUri);
  }

  void makeCall() {
    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);
    launchUrl(callUri);
  }

  void makeVideoCall() {
    const String phoneNumber = '055655844';

    Uri videoCallUri;
    if (Platform.isIOS) {
      // iOS cihazlarda FaceTime kullanın
      videoCallUri = Uri(scheme: 'facetime', path: phoneNumber);
    } else {
      // Android cihazlarda telefon araması yapın
      videoCallUri = Uri(scheme: 'tel', path: phoneNumber);
    }

    launchUrlWithFallback(videoCallUri);
  }

  Future<void> launchUrlWithFallback(Uri uri) async {
    try {
      // ignore: deprecated_member_use
      final bool canLaunchUrl = await canLaunch(uri.toString());
      if (canLaunchUrl) {
        // ignore: deprecated_member_use
        await launch(uri.toString());
      } else {
        // URL'i açmak mümkün değil, kullanıcıya bilgi verin veya alternatif bir işlem yapın
        print('URL başlatılamıyor: ${uri.toString()}');
      }
    } catch (e) {
      print('Hata: $e');
    }
  }

  void sendEmail() {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=&body=',
    );
    launchUrl(emailUri);
  }

  void addToFastCall() {
    Get.snackbar('Hızlı Arama', 'Hızlı aramalara eklendi',
        snackPosition: SnackPosition.BOTTOM);
  }

  void shareContact() {
    Get.snackbar('Kişi Paylaş', 'Kişi paylaşıldı',
        snackPosition: SnackPosition.BOTTOM);
  }

  void editContact() {
    Get.to(const EditContactView());
  }
}
