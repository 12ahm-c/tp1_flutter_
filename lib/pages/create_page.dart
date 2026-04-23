import 'package:flutter/material.dart';
import '../models/note.dart';

class CreatePage extends StatefulWidget {
  final Note? note;

  const CreatePage({super.key, this.note});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  late TextEditingController titleController;
  late TextEditingController contentController;

  String selectedColor = "#FFE082";

  final List<String> colors = [
    "#FFE082",
    "#FFAB91",
    "#80DEEA",
    "#C5E1A5",
    "#F48FB1",
    "#B39DDB",
  ];

  @override
  void initState() {
    super.initState();

    titleController =
        TextEditingController(text: widget.note?.titre ?? "");

    contentController =
        TextEditingController(text: widget.note?.contenu ?? "");

    if (widget.note != null) {
      selectedColor = widget.note!.couleur;
    }
  }

  void save() {
    if (titleController.text.isEmpty) return;

    final note = Note(
      id: widget.note?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      titre: titleController.text,
      contenu: contentController.text,
      couleur: selectedColor,
      dateCreation: widget.note?.dateCreation ?? DateTime.now(),
      dateModification: DateTime.now(),
    );

    Navigator.pop(context, note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Créer / Modifier"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              maxLength: 60,
              decoration: const InputDecoration(labelText: "Titre"),
            ),

            TextField(
              controller: contentController,
              minLines: 4,
              maxLines: 8,
              decoration: const InputDecoration(labelText: "Contenu"),
            ),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: colors.map((c) {
                return GestureDetector(
                  onTap: () => setState(() => selectedColor = c),
                  child: CircleAvatar(
                    backgroundColor:
                        Color(int.parse(c.replaceFirst('#', '0xff'))),
                    child: selectedColor == c
                        ? const Icon(Icons.check, color: Colors.white)
                        : null,
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: save,
              child: const Text("Sauvegarder"),
            )
          ],
        ),
      ),
    );
  }
}