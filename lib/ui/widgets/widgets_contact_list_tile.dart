import 'package:flutter/material.dart';

class ContactListTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ContactListTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: onTap,
    );
  }
}
