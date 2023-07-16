import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/sqlif.dart';

import 'editnote.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isloading = true;
  List notee = [];
  SqlDb sqlf = SqlDb();
  Future readData1() async {
    List<Map> respones = await sqlf.readData("SELECT *FROM notes");
    isloading = false;
    notee.addAll(respones);
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readData1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addnotes");
        },
        child: Icon(Icons.add),
      ),
      body: isloading == true
          ? Center(child: Text("loading....."))
          : Container(
              child: ListView(children: [
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: notee.length,
                    itemBuilder: (context, i) {
                      return Card(
                        child: ListTile(
                            title: Text("${notee[i]['note']}"),
                            subtitle: Text("${notee[i]['title']}"),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    int respone = await sqlf.deleteData(
                                        "DELETE FROM notes WHERE id=${notee[i]['id']}");
                                    if (respone > 0) {
                                      notee.removeWhere((element) =>
                                          element['id'] == notee[i]['id']);
                                      setState(() {});
                                    }
                                  },
                                  icon: Icon(Icons.delete),
                                  color: Colors.red,
                                ),
                                IconButton(
                                  onPressed: () async {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => EditNotes(
                                                  note: notee[i]['note'],
                                                  title: notee[i]['title'],
                                                  id: notee[i]['id'],
                                                )));
                                  },
                                  icon: Icon(Icons.edit),
                                  color: Colors.blue,
                                )
                              ],
                            )),
                      );
                    })
              ]),
            ),
    );
  }
}
