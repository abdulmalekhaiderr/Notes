import 'package:flutter/material.dart';
import 'package:notes/home.dart';
import 'package:notes/sqlif.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  SqlDb sqlDbs = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController titlee = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Addnotes'),
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
                  int respon = await sqlDbs.insertData('''
                      INSERT INTO "notes"("note","title") VALUES("${note.text}","${titlee.text}" )
                    ''');
                  print("respons================");
                  if (respon > 0) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => Home()),
                        (route) => false);
                  }
                },
                child: Text("addnew note"),
              ))
        ]),
      ),
    );
  }
}
