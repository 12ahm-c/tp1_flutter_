import 'package:flutter/material.dart';
import '../models/note.dart';

class NoteCardWidget extends StatelessWidget {
  final Note note;
  final Color color;
  final VoidCallback onTap;

  const NoteCardWidget({
    super.key,
    required this.note,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),

        leading: Container(
          width: 12,
          height: 45,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        title: Text(
          note.titre,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),

        subtitle: Text(
          note.contenu.length > 30
              ? "${note.contenu.substring(0, 30)}..."
              : note.contenu,
          style: TextStyle(
            color: Colors.grey.shade600,
          ),
        ),

        trailing: const Icon(Icons.arrow_forward_ios, size: 16),

        onTap: onTap,
      ),
    );
  }
}