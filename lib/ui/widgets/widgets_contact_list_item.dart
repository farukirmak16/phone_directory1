import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContactListItem extends StatelessWidget {
  final int id;
  final String userId;
  final String name;
  final String imageUrl; // Base64 veya URL olabilir
  final VoidCallback onTap;

  const ContactListItem({
    required this.id,
    required this.userId,
    required this.name,
    required this.imageUrl,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: _getProfileImage(imageUrl),
        radius: 30,
      ),
      title: Text(name),
      onTap: onTap,
    );
  }

  /// Resmi base64'ten dönüştür ya da URL'den al, yoksa varsayılan resmi kullan
  ImageProvider _getProfileImage(String imageUrl) {
    try {
      if (imageUrl.isNotEmpty) {
        if (imageUrl.startsWith('data:image')) {
          final base64String = imageUrl.split(',').last;
          Uint8List imageBytes = base64Decode(base64String);
          return MemoryImage(imageBytes);
        } else if (imageUrl.startsWith('file://')) {
          return FileImage(File(imageUrl.replaceFirst('file://', '')));
        } else {
          return NetworkImage(imageUrl);
        }
      }
    } catch (e) {
      print('Resim yüklenirken hata oluştu: $e');
    }
    return const AssetImage('assets/user-profile-default.png');
  }
}
