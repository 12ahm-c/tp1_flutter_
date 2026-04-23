import 'package:flutter/material.dart';
import '../models/note.dart';
import 'create_page.dart';

class DetailPage extends StatelessWidget {
  final Note note;

  const DetailPage({super.key, required this.note});

  Color parseColor(String hex) {
    return Color(int.parse(hex.replaceFirst('#', '0xff')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Détail"),
        backgroundColor: parseColor(note.couleur),

        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final updated = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CreatePage(note: note),
                ),
              );

              if (updated != null) {
                Navigator.pop(context, {
                  "action": "modified",
                  "note": updated,
                });
              }
            },
          ),

          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Supprimer ?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Annuler"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context, {
                          "action": "deleted",
                        });
                      },
                      child: const Text("Supprimer"),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.titre,
                style: const TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              Text(note.contenu),
            ],
          ),
        ),
      ),
    );
  }
}