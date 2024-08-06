// ignore: file_names
import 'package:flutter/material.dart';

class AlphabetSidebar extends StatelessWidget {
  final Function(String) onLetterTap;
  final String currentLetter;

  const AlphabetSidebar({
    super.key,
    required this.onLetterTap,
    required this.currentLetter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          //  mainAxisAlignment: MainAxisAlignment.start, // Başlangıçtan hizala
          children: List.generate(26, (index) {
            final letter = String.fromCharCode(index + 65);
            return GestureDetector(
              onTap: () => onLetterTap(letter),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 0.5), // Daha dar aralık
                child: Text(
                  letter,
                  style: TextStyle(
                      fontSize: 8, // Daha küçük boyut
                      fontWeight: FontWeight.bold,
                      color: letter == currentLetter
                          ? Colors.blue
                          : Colors.black45),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
