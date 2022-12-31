class Note {
  String? id;
  String? userid;
  String? title;
  String? desc;
  DateTime? dateadded;

  Note({this.id, this.userid, this.title, this.desc, this.dateadded});

  factory Note.fromMap(Map<String, dynamic> map) {//taking in json and creating an object
    //factory constructor
    return Note(
        id: map['id'],
        userid: map['userid'],
        title: map['title'],
        desc: map['desc'],
        dateadded: DateTime.tryParse(map['dateadded']));
  }

  Map<String, dynamic> toMap() {//converting to json
    return {
      'id':id,
      'userid': userid,
        'title': title,
        'desc': desc,
        'dateadded': dateadded!.toIso8601String()
    };
  }
}
