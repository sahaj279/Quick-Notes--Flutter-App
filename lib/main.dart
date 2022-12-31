import 'package:flutter/material.dart';
import 'package:flutter_and_node/pages/allnotes.dart';
import 'package:flutter_and_node/providers/notes_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NotesProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'list ig',
        home: AllNotes(), //  RandomWords(),
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
        ),
        darkTheme: ThemeData.dark().copyWith(
          appBarTheme: AppBarTheme(backgroundColor: Colors.purple),
          scaffoldBackgroundColor: Colors.purple[900],
          floatingActionButtonTheme:
              FloatingActionButtonThemeData(backgroundColor: Colors.yellow),
        ),
      ),
    );
  }
}
