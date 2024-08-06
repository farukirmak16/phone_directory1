import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_yeni_tasarim/ui/theme/app_theme.dart';
import 'package:t_yeni_tasarim/ui/view/view_contact_list.dart';
import 'package:t_yeni_tasarim/ui/view/view_login.dart';
import 'package:t_yeni_tasarim/ui/view/view_register.dart';
import 'package:t_yeni_tasarim/ui/view/view_add_contact.dart';
import 'package:t_yeni_tasarim/ui/view/view_edit_contact.dart';
import 'package:t_yeni_tasarim/ui/view/view_contact_detail.dart';
import 'package:t_yeni_tasarim/ui/controller/controller_contactlist.dart';
import 'package:t_yeni_tasarim/ui/controller/controller_login.dart';
import 'package:t_yeni_tasarim/ui/controller/controller_editcontactview.dart';
import 'ui/controller/controller.addcontactview.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: 'Rehber Uygulaması',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder(() {
        // GetX ile controller'ları başlat
        //heyhey
        Get.put(ContactListViewController());
        Get.put(LoginViewController());
        Get.put(EditContactViewController());
        Get.put(AddContactViewController());
      }),
      getPages: [
        GetPage(name: '/', page: () => const ContactListView()),
        GetPage(name: '/contactListView', page: () => const ContactListView()),
        GetPage(name: '/editContactView', page: () => const EditContactView()),
        GetPage(name: '/loginView', page: () => const LoginView()),
        GetPage(name: '/addContactView', page: () => const AddContactView()),
        // Parametreli sayfa tanımı
        GetPage(
          name: '/contactDetailView/:id',
          page: () {
            final id = int.parse(Get.parameters['id']!);
            return ContactDetailView(id: id);
          },
        ),
        GetPage(name: '/registerView', page: () => const RegisterView()),
      ],
    ),
  );
}
