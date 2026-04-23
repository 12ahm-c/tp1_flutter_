import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final Function(String) onChanged;

  const SearchWidget({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
            )
          ],
        ),
        child: TextField(
          onChanged: onChanged,
          decoration: const InputDecoration(
            hintText: "Rechercher une note...",
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
          ),
        ),
      ),
    );
  }
}