import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:t_yeni_tasarim/core/api/api_client.dart';
import 'package:t_yeni_tasarim/core/service/contact_service.dart';
import 'package:t_yeni_tasarim/core/service/auth_service.dart';
import 'package:t_yeni_tasarim/core/service/hive.dart';
import 'package:t_yeni_tasarim/ui/controller/controller.addcontactview.dart';
import 'package:t_yeni_tasarim/ui/controller/controller_contactlist.dart';
import 'package:t_yeni_tasarim/ui/controller/controller_login.dart';
import 'package:t_yeni_tasarim/ui/controller/controller_editcontactview.dart';
import 'package:t_yeni_tasarim/ui/theme/app_theme.dart';
import 'package:t_yeni_tasarim/ui/view/view_contact_list.dart';
import 'package:t_yeni_tasarim/ui/view/view_edit_contact.dart';
import 'package:t_yeni_tasarim/ui/view/view_login.dart';
import 'package:t_yeni_tasarim/ui/view/view_register.dart';
import 'package:t_yeni_tasarim/ui/view/view_add_contact.dart';
import 'package:t_yeni_tasarim/ui/view/view_contact_detail.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); // Hive başlatma
  var tokenBox = await Hive.openBox<String>('tokens');

  final dio = Dio(BaseOptions(
    baseUrl: 'https://192.168.12.164',
    headers: {
      "User-Agent": "PostmanRuntime/7.39.0",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
      "Connection": "keep-alive"
    },
    connectTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 20),
  ));

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        print('Dio Error: ${e.message}');
        return handler.next(e);
      },
    ),
  );

  // ApiClient ve diğer bağımlılıkları oluşturuyoruz
  final apiClient = ApiClient(dio);
  final tokenStorage = TokenStorage(tokenBox);
  final authService = AuthService(
      apiClient, tokenStorage); // İsimlendirilmiş argümanları kullanıyoruz
  final contactService = ContactService(
      apiClient: apiClient,
      authService: authService); // İsimlendirilmiş argümanlar

  // Bağımlılıkları GetX'e kaydediyoruz
  Get.put<ApiClient>(apiClient);
  Get.put<TokenStorage>(tokenStorage);
  Get.put<AuthService>(authService);
  Get.put<ContactService>(contactService);

  HttpOverrides.global = MyHttpOverrides();

  runApp(
    GetMaterialApp(
      title: 'Rehber Uygulaması',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder(() {
        // Controller'ları doğrudan tanımlıyoruz
        Get.put<ContactListViewController>(ContactListViewController());
        Get.put<LoginViewController>(LoginViewController());
        Get.put<EditContactViewController>(EditContactViewController());
        Get.put<AddContactViewController>(AddContactViewController());
      }),
      getPages: [
        GetPage(name: '/', page: () => const LoginView()),
        GetPage(name: '/contactListView', page: () => const ContactListView()),
        GetPage(name: '/editContactView', page: () => EditContactView()),
        GetPage(name: '/login', page: () => const LoginView()),
        GetPage(name: '/addContactView', page: () => const AddContactView()),
        GetPage(
          name: '/contactDetailView/:id',
          page: () {
            final contactId =
                int.parse(Get.parameters['id']!); // ID'yi int'e çevirdim
            return ContactDetailView(contactId: contactId);
          },
        ),
        GetPage(name: '/registerView', page: () => const RegisterView()),
      ],
    ),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
