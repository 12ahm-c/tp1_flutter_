import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/note_service.dart';
import '../models/note.dart';
import 'create_page.dart';
import 'detail_page.dart';
import '../widgets/search_widget.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/note_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String query = "";

  Color parseColor(String hex) {
    return Color(int.parse(hex.replaceFirst('#', '0xff')));
  }

  Future<void> goToCreate() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CreatePage()),
    );

    if (result != null && result is Note) {
      context.read<NoteService>().addNote(result);
    }
  }

  Future<void> openDetail(Note note) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailPage(note: note),
      ),
    );

    if (result != null) {
      if (result['action'] == 'deleted') {
        context.read<NoteService>().deleteNote(note.id);
      }

      if (result['action'] == 'modified') {
        context.read<NoteService>().updateNote(result['note']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final service = context.watch<NoteService>();

    final notes = query.isEmpty
        ? service.notes
        : service.search(query);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text(
          "Mes Notes",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),

        actions: [
          PopupMenuButton<SortOption>(
            icon: const Icon(Icons.sort, color: Colors.black),
            onSelected: (value) {
              context.read<NoteService>().setSort(value);
            },
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: SortOption.dateDesc,
                child: Text("Date ↓"),
              ),
              PopupMenuItem(
                value: SortOption.dateAsc,
                child: Text("Date ↑"),
              ),
              PopupMenuItem(
                value: SortOption.titleAsc,
                child: Text("Titre A-Z"),
              ),
              PopupMenuItem(
                value: SortOption.titleDesc,
                child: Text("Titre Z-A"),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "${service.count}",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          SearchWidget(
            onChanged: (value) {
              setState(() {
                query = value;
              });
            },
          ),

          Expanded(
            child: notes.isEmpty
                ? EmptyStateWidget(
                    message: query.isEmpty
                        ? "Aucune note"
                        : "Aucun résultat",
                  )
                : ListView.builder(
                    itemCount: notes.length,
                    itemBuilder: (_, index) {
                      final note = notes[index];

                      return NoteCardWidget(
                        note: note,
                        color: parseColor(note.couleur),
                        onTap: () => openDetail(note),
                      );
                    },
                  ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: goToCreate,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}