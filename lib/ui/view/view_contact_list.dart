import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_yeni_tasarim/ui/controller/controller_contactlist.dart';
import 'package:t_yeni_tasarim/ui/view/view_add_contact.dart';
import 'package:t_yeni_tasarim/ui/view/view_contact_detail.dart';
import 'package:t_yeni_tasarim/ui/view/view_login.dart';
import 'package:t_yeni_tasarim/ui/widgets/widgets_alphabet_Sidebar.dart';
import 'package:t_yeni_tasarim/ui/widgets/widgets_contact_list_item.dart';

class ContactListView extends StatelessWidget {
  const ContactListView({super.key});

  @override
  Widget build(BuildContext context) {
    final ContactListViewController controller =
        Get.put(ContactListViewController());
    final ScrollController scrollController = ScrollController();

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset(
                'assets/logo.png',
                height: 31,
                fit: BoxFit.contain,
              ),
              const Spacer(),
              IconButton(
                icon: Image.asset('assets/profillogo.png'),
                onPressed: () {
                  Get.to(() => const AddContactView());
                },
              ),
              IconButton(
                icon: const Icon(Icons.logout_rounded, color: Colors.black54),
                onPressed: () {
                  Get.offAll(() => const LoginView());
                },
              ),
            ],
          ),
        ),
        body: Row(
          children: [
            Expanded(
              flex: 7,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Ara',
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade400.withOpacity(0.1),
                            suffixIcon: const Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Obx(() {
                      return ListView.builder(
                        controller: scrollController,
                        itemCount: controller.contacts.length,
                        itemBuilder: (context, index) {
                          final contact = controller.contacts[index];
                          final contactLetter = contact.name[0].toUpperCase();
                          final showHeader = index == 0 ||
                              controller.contacts[index - 1].name[0]
                                      .toUpperCase() !=
                                  contactLetter;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (showHeader)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 25.0),
                                  color: Colors.white38,
                                  child: Text(
                                    contactLetter,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black26,
                                    ),
                                  ),
                                ),
                              ContactListItem(
                                id: contact.id,
                                name: contact.name,
                                imageUrl: contact.imageUrl,
                                onTap: () {
                                  Get.to(
                                      () => ContactDetailView(id: contact.id));
                                },
                              ),
                              Divider(
                                height: 1,
                                color: Colors.black26.withOpacity(0.1),
                              ),
                            ],
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
            AlphabetSidebar(
              onLetterTap: (letter) {
                controller.setCurrentLetter(letter);

                int index = controller.contacts.indexWhere(
                    (contact) => contact.name[0].toUpperCase() == letter);
                if (index != -1) {
                  scrollController.animateTo(
                    index * 56.0, // 56.0, tahmini yükseklik
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
              currentLetter: controller.currentLetter.value,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Hızlı Arama',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.access_time_rounded),
              label: 'Son Aramalar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Kişiler',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.keyboard_alt_outlined),
              label: 'Klavye',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.voicemail),
              label: 'Sesli Mesaj',
            ),
          ],
          currentIndex: 2,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: (index) {
            // Tab tıklama işlevi eklenebilir
          },
        ),
      ),
    );
  }
}
