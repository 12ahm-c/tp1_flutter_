import 'package:flutter/material.dart';
import '../models/note.dart';

enum SortOption {
  dateDesc,
  dateAsc,
  titleAsc,
  titleDesc,
}

class NoteService extends ChangeNotifier {
  final List<Note> _notes = [];
  SortOption _currentSort = SortOption.dateDesc;

  List<Note> get notes {
    final sorted = [..._notes];

    switch (_currentSort) {
      case SortOption.dateDesc:
        sorted.sort((a, b) => b.dateCreation.compareTo(a.dateCreation));
        break;
      case SortOption.dateAsc:
        sorted.sort((a, b) => a.dateCreation.compareTo(b.dateCreation));
        break;
      case SortOption.titleAsc:
        sorted.sort((a, b) => a.titre.compareTo(b.titre));
        break;
      case SortOption.titleDesc:
        sorted.sort((a, b) => b.titre.compareTo(a.titre));
        break;
    }

    return List.unmodifiable(sorted);
  }

  int get count => _notes.length;

  void setSort(SortOption option) {
    _currentSort = option;
    notifyListeners();
  }

  void addNote(Note note) {
    _notes.insert(0, note);
    notifyListeners();
  }

  void updateNote(Note updatedNote) {
    final index =
        _notes.indexWhere((n) => n.id == updatedNote.id);

    if (index != -1) {
      _notes[index] = updatedNote;
      notifyListeners();
    }
  }

  void deleteNote(String id) {
    _notes.removeWhere((n) => n.id == id);
    notifyListeners();
  }

  Note? getNoteById(String id) {
    try {
      return _notes.firstWhere((n) => n.id == id);
    } catch (_) {
      return null;
    }
  }

  List<Note> search(String query) {
    return notes.where((n) {
      return n.titre.toLowerCase().contains(query.toLowerCase()) ||
             n.contenu.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}