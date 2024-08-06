import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:t_yeni_tasarim/core/model/contact.dart';

class ContactListViewController extends GetxController {
  var contacts = <Contact>[].obs;
  var currentLetter = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadContacts();
  }

  void setCurrentLetter(String letter) {
    currentLetter.value = letter;
  }

  Future<void> saveContacts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> contactList = contacts.map((contact) => jsonEncode(contact.toJson())).toList();
    await prefs.setStringList('contacts', contactList);
  }

  Future<void> loadContacts() async {
    try {
      contacts.assignAll([
        Contact(id: 0, name: 'Amcam', imageUrl: 'assets/amcam.png', phoneNumber: '055655800', email: ''),
        Contact(
            id: 1, name: 'Ali Akli Komsu', imageUrl: 'assets/ali_abi_komsu.png', phoneNumber: '055655811', email: ''),
        Contact(id: 2, name: 'Ablam', imageUrl: 'assets/ablam.png', phoneNumber: '055655822', email: ''),
        Contact(id: 3, name: 'Akın Abi iş', imageUrl: 'assets/akin_abi_is.png', phoneNumber: '055655833', email: ''),
        Contact(
            id: 4,
            name: 'Ayşegül Arkadaş',
            imageUrl: 'assets/aysegul_arkadas.png',
            phoneNumber: '055655844',
            email: ''),
        Contact(id: 5, name: 'Adem Okul', imageUrl: 'assets/adem_okul.png', phoneNumber: '055655855', email: ''),
        Contact(id: 6, name: 'Asli Abla İş', imageUrl: 'assets/asli_abla_is.png', phoneNumber: '055655866', email: ''),
        Contact(id: 7, name: 'Aziz Kuzen', imageUrl: 'assets/aziz_kuzen.png', phoneNumber: '055655877', email: ''),
        Contact(
            id: 8, name: 'Aycan Arkadaş', imageUrl: 'assets/aycan_arkadas.png', phoneNumber: '055655888', email: ''),
        Contact(id: 9, name: 'Babam', imageUrl: 'assets/babam.png', phoneNumber: '055655899', email: ''),
      ]);
      await saveContacts();
    } catch (e) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? contactList = prefs.getStringList('contacts');

      if (contactList != null) {
        contacts.assignAll(contactList.map((contact) => Contact.fromJson(jsonDecode(contact))).toList());
      } else {
        await saveContacts();
      }

      await saveContacts();
    }
  }

  int getNextId() {
    if (contacts.isEmpty) {
      return 0;
    } else {
      return contacts.map((contact) => contact.id).reduce((a, b) => a > b ? a : b) + 1;
    }
  }

  void addContact(Contact contact) {
    int newId = getNextId();
    contacts.add(Contact(
        id: newId, name: contact.name, imageUrl: contact.imageUrl, phoneNumber: contact.phoneNumber, email: ''));
    saveContacts();
  }

  void removeContact(Contact contact) {
    contacts.remove(contact);
    saveContacts();
  }
}
