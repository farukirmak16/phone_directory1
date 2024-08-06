import 'package:flutter/material.dart';

class ContactListItem extends StatelessWidget {
  final int id;
  final String name;
  final String imageUrl;
  final VoidCallback onTap;

  const ContactListItem({
    super.key,
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(imageUrl),
      ),
      title: Text(name),
      onTap: onTap, // Tıklama olayını iletin
    );
  }
}
