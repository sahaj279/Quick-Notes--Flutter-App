// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_and_node/models/note.dart';
import 'package:flutter_and_node/providers/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddNotes extends StatefulWidget {
  final bool isUpdate;
  final Note? n;
  const AddNotes({super.key,required this.isUpdate,this.n});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  TextEditingController titleController=TextEditingController();
  TextEditingController descController=TextEditingController();
  FocusNode nodeFocus=FocusNode();


@override
  void initState() {
    super.initState();

    if(widget.isUpdate){
      titleController.text=widget.n!.title!;
      descController.text=widget.n!.desc!;
    }
  }
  void addNote(){
    Note n=Note(
      id:const Uuid().v1(),
      userid:"Sahaj",
      title: titleController.text,
      desc: descController.text, 
      dateadded: DateTime.now()
    );
    Provider.of<NotesProvider>(context,listen: false).addNote(n);
    Navigator.pop(context);
  }

  void updateNode(){
    Note n=Note(
      id: widget.n!.id,
      userid: widget.n!.userid,
      title: titleController.text,
      desc: descController.text, 
      dateadded: DateTime.now()
    );
    Provider.of<NotesProvider>(context,listen: false).updateNote(n);
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: [
          IconButton(onPressed: (){
            widget.isUpdate?updateNode():addNote();
            }, icon:const Icon(Icons.check))
        ],),
        body: Padding(
          padding:const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: ListView(
            children: [
              TextField(
                
                controller: titleController,
                onSubmitted: (value) {
                  if(value.isNotEmpty){
                    nodeFocus.requestFocus();//now when we press enter, we directly move to next textfield which has the focus node

                  }
                },
                autofocus: true,
                cursorColor: Colors.white,
                style: const TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
                decoration:const InputDecoration(
                    hintText: 'Title', border: InputBorder.none),
              ),
              Expanded(
                child: TextField(
                  scrollPhysics:const NeverScrollableScrollPhysics(),
                  controller: descController,
                  focusNode:nodeFocus,
                  maxLines: null,
                  cursorColor: Colors.white,
                  style:const  TextStyle(
                    fontSize: 20,
                  ),
                  decoration:const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Content',
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
