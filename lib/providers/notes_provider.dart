import 'package:flutter/widgets.dart';
import 'package:flutter_and_node/services/api_services.dart';

import '../models/note.dart';

class NotesProvider with ChangeNotifier {
  bool isLoading=true;
  List<Note> notes = [];
  NotesProvider(){
    fetchNotes();
  }
  void sortNotes(){
    notes.sort(((a, b) => b.dateadded!.compareTo(a.dateadded!)));
  }
  void addNote(Note n) {
    notes.add(n);
    sortNotes();
    notifyListeners();
    ApiService.addNote(n);
  }

  void deleteNote(Note n) {
    notes.removeWhere((element) => element.id == n.id);
    notifyListeners();
    ApiService.deleteNote(n);
  }

  void updateNote(Note n) {
    int i = notes.indexOf(notes.firstWhere((element) => element.id == n.id));
    notes[i] = n;
    sortNotes();
    notifyListeners();
    ApiService.updateNote(n);
  }

  void fetchNotes()async{
    notes=await ApiService.getAllNotes('Sahaj');
    sortNotes();
    isLoading=false;
    notifyListeners();
  }

  List<Note> filteredNotes(String search){
    List<Note>l=search.isNotEmpty?notes.where((element) => element.title!.contains(search)).toList():notes;
    notifyListeners();
    return l;
  }
}
