import 'dart:convert';

import 'package:flutter_and_node/models/note.dart';
import 'package:http/http.dart' as http;
class ApiService{
  static const String baseUrl="https://nodeserverflutter.onrender.com";

  static void  addNote(Note n)async{
    Uri uri= Uri.parse("$baseUrl/notes/add");
    var response=await http.post(uri,body: n.toMap());
    print(response.body.toString());
    
  }

  static void  deleteNote(Note n)async{
    Uri uri= Uri.parse("$baseUrl/notes/delete");
    var response=await http.post(uri,body: n.toMap());
    print(response.body.toString());
    
  }

  static void  updateNote(Note n)async{
    Uri uri= Uri.parse("$baseUrl/notes/add");
    var response=await http.post(uri,body: n.toMap());
    print(response.body.toString());
    
  }

  static Future<List<Note>> getAllNotes(String uid)async{
    Uri uri=Uri.parse("$baseUrl/notes/list");
    var response=await http.post(uri, 
      body: {"userid":uid}
    );
    var decoded=jsonDecode(response.body);
    List<Note> l=[];
    for(var noteMap in decoded){
      Note n=Note.fromMap(noteMap);
      l.add(n);
    }
    return l;
  }
}