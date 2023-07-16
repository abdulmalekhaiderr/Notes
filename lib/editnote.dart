import 'package:flutter/material.dart';
import 'package:notes/home.dart';
import 'package:notes/sqlif.dart';

class EditNotes extends StatefulWidget {
  final note;
  final title;
  final id;

  const EditNotes({super.key, this.note, this.title, this.id});

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  SqlDb sqlDbs = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController titlee = TextEditingController();
  TextEditingController color = TextEditingController();
  @override
  void initState() {
    note.text = widget.note;
    titlee.text = widget.title;
    // note.text = widget.note;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editnotes'),
      ),
      body: Container(
        child: ListView(children: [
          Form(
              key: formstate,
              child: Column(
                children: [
                  TextFormField(
                    controller: note,
                    decoration: InputDecoration(hintText: "note"),
                  ),
                  TextFormField(
                    controller: titlee,
                    decoration: InputDecoration(hintText: "title"),
                  ),
                ],
              )),
          Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              color: Colors.blue,
              child: MaterialButton(
                textColor: Colors.white,
                onPressed: () async {
                  int respon = await sqlDbs.updateData('''
                      UPDATE  notes SET
                       note="${note.text}",
                      title="${titlee.text}" 
                      WHERE id="${widget.id}"
                    ''');
                  print("respons================");
                  if (respon > 0) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => Home()),
                        (route) => false);
                  }
                },
                child: Text("EditNotes note"),
              ))
        ]),
      ),
    );
  }
}
