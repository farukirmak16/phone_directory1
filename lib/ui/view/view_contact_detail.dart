import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/controller_contactdetail.dart';

class ContactDetailView extends StatelessWidget {
  final int id;

  const ContactDetailView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final ContactDetailViewController controller =
        Get.put(ContactDetailViewController());

    controller.init(id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kişi Detay'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Get.back();
          },
        ),
        actions: <Widget>[
          Container(width: 48),
        ],
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(controller.imageUrl),
              ),
              const SizedBox(height: 8),
              Text(
                controller.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                controller.phoneNumber,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _Mesaj(onPressed: controller.sendMessage),
                  _Cagri(onPressed: controller.makeCall),
                  _Goruntulu(onPressed: controller.makeVideoCall),
                  _Eposta(onPressed: controller.sendEmail),
                ],
              ),
              const SizedBox(height: 16),
              _PersonEdit(onPressed: controller.editContact),
              _PersonShare(onPressed: controller.shareContact),
              _FastCall(onPressed: controller.addToFastCall),
            ],
          ),
        );
      }),
    );
  }
}

class _FastCall extends StatelessWidget {
  final VoidCallback onPressed;

  const _FastCall({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 390,
      height: 58,
      child: Card(
        elevation: 0.5,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.star_border_rounded),
                onPressed: onPressed,
              ),
              const SizedBox(width: 2),
              const Flexible(
                child: Text(
                  'Hızlı Aramalara Ekle',
                  style: TextStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PersonShare extends StatelessWidget {
  final VoidCallback onPressed;

  const _PersonShare({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 390,
      height: 58,
      child: Card(
        elevation: 0.5,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.share_outlined),
                onPressed: onPressed,
              ),
              const SizedBox(width: 2),
              const Flexible(
                child: Text(
                  'Kişiyi Paylaş',
                  style: TextStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PersonEdit extends StatelessWidget {
  final VoidCallback onPressed;

  const _PersonEdit({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 390,
      height: 58,
      child: Card(
        elevation: 0.5,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: onPressed,
              ),
              const SizedBox(width: 2),
              const Flexible(
                child: Text(
                  'Kişiyi Düzenle',
                  style: TextStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Eposta extends StatelessWidget {
  final VoidCallback onPressed;

  const _Eposta({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 88.5,
      height: 72,
      child: Card(
        elevation: 0.5,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: IconButton(
                icon: const Icon(Icons.email_outlined),
                onPressed: onPressed,
              ),
            ),
            const Flexible(
              child: Text(
                'E-posta',
                style: TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Goruntulu extends StatelessWidget {
  final VoidCallback onPressed;

  const _Goruntulu({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 88.5,
      height: 72,
      child: Card(
        elevation: 0.5,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: IconButton(
                icon: const Icon(Icons.video_camera_front_outlined),
                onPressed: onPressed,
              ),
            ),
            const Flexible(
              child: Text(
                'Görüntülü',
                style: TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Cagri extends StatelessWidget {
  final VoidCallback onPressed;

  const _Cagri({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 88.5,
      height: 72,
      child: Card(
        elevation: 0.5,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: IconButton(
                icon: const Icon(Icons.call_outlined),
                onPressed: onPressed,
              ),
            ),
            const Flexible(
              child: Text(
                'Çağrı',
                style: TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Mesaj extends StatelessWidget {
  final VoidCallback onPressed;

  const _Mesaj({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 88.5,
      height: 72,
      child: Card(
        elevation: 0.5,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: IconButton(
                icon: const Icon(Icons.message_outlined),
                onPressed: onPressed,
              ),
            ),
            const Flexible(
              child: Text(
                'Mesaj',
                style: TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
