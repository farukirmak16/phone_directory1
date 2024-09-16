import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:t_yeni_tasarim/core/model/contact.dart';
import 'package:t_yeni_tasarim/core/service/contact_service.dart';
import 'package:t_yeni_tasarim/ui/controller/controller_editcontactview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import '../view/view_edit_contact.dart';
import 'package:dio/dio.dart';

class ContactDetailViewController extends GetxController {
  final ContactService contactService = Get.find<ContactService>();
  final Detailcontroller = Get.find<EditContactViewController>();
  final Dio dio = Dio();
  var imageFile =
      Rx<File?>(null); // Bu, yerel olarak saklanan resim için kullanılır

  final contact = Rx<Contact>(
    Contact(
      userId: '',
      name: '',
      phoneNumber: '',
      imageUrl: '',
      email: '',
      id: 0,
    ),
  );

  final id = 0.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.parameters.containsKey('contactId')) {
      id.value = int.parse(Get.parameters['contactId']!);
      init(id.value);
    }
  }

  Future<void> init(int contactId) async {
    try {
      contact.value = await fetchContactById(contactId);
    } catch (e) {
      Get.snackbar('Hata', 'Kişi detayları alınamadı');
    }
  }

  Future<Contact> fetchContactById(int contactId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        throw Exception("Token eksik!");
      }

      final response = await contactService.getContactById(contactId);

      return Contact.fromJson(response.toJson());
    } catch (e) {
      print('Kişi alınırken hata oluştu: $e');
      return Contact(
        id: 0,
        userId: '',
        name: 'Bilinmiyor',
        phoneNumber: 'Bilinmiyor',
        imageUrl: '',
        email: '',
      );
    }
  }

  // SMS gönderme işlemi
  void sendMessage() async {
    final Uri messageUri = Uri(scheme: 'sms', path: contact.value.phoneNumber);
    if (await canLaunchUrl(messageUri)) {
      await launchUrl(messageUri);
    } else {
      print('SMS başlatılamıyor: ${messageUri.toString()}');
    }
  }

  // Arama yapma işlemi
  void makeCall() async {
    final Uri callUri = Uri(scheme: 'tel', path: contact.value.phoneNumber);
    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      print('Telefon araması başlatılamıyor: ${callUri.toString()}');
    }
  }

  // Video araması yapma işlemi
  void makeVideoCall() async {
    final Uri videoCallUri = Platform.isIOS
        ? Uri(scheme: 'facetime', path: contact.value.phoneNumber)
        : Uri(scheme: 'tel', path: contact.value.phoneNumber);

    if (await canLaunchUrl(videoCallUri)) {
      await launchUrl(videoCallUri);
    } else {
      print('Video araması başlatılamıyor: ${videoCallUri.toString()}');
    }
  }

  // E-posta gönderme işlemi
  void sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: contact.value.email,
      query: 'subject=&body=',
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      print('E-posta başlatılamıyor: ${emailUri.toString()}');
    }
  }

  // Hızlı aramalara ekleme işlemi
  void addToFastCall() {
    Get.snackbar('Hızlı Arama', 'Hızlı aramalara eklendi',
        snackPosition: SnackPosition.BOTTOM);
  }

  // Kişi paylaşma işlemi
  void shareContact() {
    Get.snackbar('Kişi Paylaş', 'Kişi paylaşıldı',
        snackPosition: SnackPosition.BOTTOM);
  }

// Kişi düzenleme işlemi
  Future<void> editContact() async {
    Get.to(() => EditContactView(), arguments: {
      'id': contact.value.id,
      'name': contact.value.name,
      'phone': contact.value.phoneNumber,
      'email': contact.value.email,
      'imagePath': contact.value.imageUrl
    });
  }

  // Getterlar

  String get name => contact.value.name;
  String get phoneNumber => contact.value.phoneNumber;
  String get email => contact.value.email;
  String get imageUrl => contact.value.imageUrl;
}
