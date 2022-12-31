import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_and_node/pages/addNote.dart';
import 'package:flutter_and_node/providers/notes_provider.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';

class AllNotes extends StatefulWidget {
  const AllNotes({super.key});

  @override
  State<AllNotes> createState() => _AllNotesState();
}

class _AllNotesState extends State<AllNotes> {
  String searchString = "";
  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);
    return notesProvider.isLoading
        ? const Center(
            child: CircularProgressIndicator(color: Colors.orange),
          )
        : SafeArea(
            child: Scaffold(
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            fullscreenDialog: true,
                            builder: (context) {
                              return const AddNotes(
                                isUpdate: false,
                              );
                            }));
                  },
                  child: const Icon(Icons.add),
                ),
                appBar: AppBar(
                  title: const Text('Notes'),
                  centerTitle: true,
                ),
                body: notesProvider.notes.isEmpty
                    ? const Center(
                        child: Text('Write a note'
                            // ,style: TextStyle( fontSize: 48, fontWeight: FontWeight.bold)
                            ),
                      )
                    : ListView(
                        children: [
                          TextField(
                            onChanged: (value) {
                              setState(() {
                                searchString = value;
                              });
                            },
                            decoration: const InputDecoration(
                                hintText: "Search",
                                contentPadding: EdgeInsets.all(5)),
                          ),
                          notesProvider
                                      .filteredNotes(searchString)
                                      .isEmpty
                                  ? const Center(child:Padding(padding: EdgeInsets.all(10),child:  Text('No note found.', ) ), )
                                  : 
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemCount: notesProvider
                                .filteredNotes(searchString)
                                .length,
                            itemBuilder: ((context, index) {
                              Note currentNote = notesProvider
                                  .filteredNotes(searchString)[index];
                              return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) {
                                                return AddNotes(
                                                  isUpdate: true,
                                                  n: currentNote,
                                                );
                                              },
                                              fullscreenDialog: true),
                                        );
                                      },
                                      onLongPress: () {
                                        //delete note
                                        //TODO  show dialog

                                        //show a dialog and if clicked yes, delete note
                                        notesProvider.deleteNote(currentNote);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            border: Border.all(
                                                color: Colors.redAccent,
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                              currentNote.title!,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              currentNote.desc!,
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                            }),
                          ),
                        ],
                      )),
          );
  }
}
