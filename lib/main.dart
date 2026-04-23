import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 🔥 مهم
import 'services/note_service.dart';     // 🔥 مهم
import 'pages/home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => NoteService(),
      child: const BlocNotesApp(),
    ),
  );
}

class BlocNotesApp extends StatelessWidget {
  const BlocNotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bloc Notes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}