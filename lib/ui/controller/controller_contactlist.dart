import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:t_yeni_tasarim/core/model/contact.dart';
import 'package:t_yeni_tasarim/core/service/contact_service.dart';
import 'package:t_yeni_tasarim/core/service/auth_service.dart';
import 'package:t_yeni_tasarim/core/service/hive.dart';

import 'controller_contactdetail.dart';

class ContactListViewController extends GetxController {
  final ContactService contactService = Get.find<ContactService>();
  final AuthService authService = Get.find<AuthService>();

  final Dio dio = Dio();
  final String contactsUrl = 'https://192.168.12.164/api/Contact/';
  final TokenStorage tokenStorage = Get.find();
  var contacts = <Contact>[].obs;
  var currentLetter = ''.obs;

  Future<String?> getUserId() async {
    return await tokenStorage.getUserId();
  }

  @override
  void onInit() {
    super.onInit();
    loadContacts();
  }

  Future<void> loadContacts() async {
    try {
      final userId = await authService.getUserId();
      if (userId != null) {
        contacts.value = await contactService
            .getContacts(); // Ensure getContacts uses userId
      } else {
        print('User ID is null');
      }
    } catch (e) {
      print('Failed to load contacts: $e');
    }
  }

  void setCurrentLetter(String letter) {
    currentLetter.value = letter;
  }

  Future<void> logout() async {
    try {
      await authService.logout();
      Get.offAllNamed('/login');
    } catch (e) {
      print('Logout failed: $e');
    }
  }
}
