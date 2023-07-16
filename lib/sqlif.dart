// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'abdu.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 2, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) async {
    print("onUpgrade =====================================");

    // await db.execute('ALTER TABLE notes ADD COLUMN color TEXT');
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE notes (
    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "note" TEXT NOT NULL
  )
 ''');
    print(" onCreate =====================================");
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }
}

// class SqlDb {
//   static Database? _db;

//   Future<Database?> get db async {
//     if (_db == null) {
//       _db = await initialDb();

//       return _db;
//     } else {
//       return _db;
//     }
//   }

//   _onUpgrade(Database db, int oldversion, int newservsion) async {
//     print("onupgrade===================================");
//     await db.execute('ALTER TABLE notes ADD COLUMN color TEXT');
//   }

//   initialDb() async {
//     String databasepath = await getDatabasesPath();
//     String path = join(databasepath, "abdu.db");
//     Database mydb = await openDatabase(
//       path,
//       version: 1,
//       onCreate: _onCreate,
//       onUpgrade: _onUpgrade,
//     );

//     return mydb;
//   }

//   _onCreate(Database db, int version) async {
//     await db.execute('''
// CREATE TABLE notes(id INTEGER     NOT NULL  PRIMARY KEY AUTOINCREMENT,
// title TEXT NOT NULL
//  , note TEXT NOT NULL,)''');

//     print("oncreate ================================");
//   }

//   reaData(String sql) async {
//     Database? mydb = await db;
//     List<Map> respons = await mydb!.rawQuery(sql);
//     return respons;
//   }

//   deleteData(String sql) async {
//     Database? mydb = await db;

//     int respons = await mydb!.rawDelete(sql);
//     return respons;
//   }

//   insertData(String sql) async {
//     Database? mydb = await db;

//     int respons = await mydb!.rawInsert(sql);
//     return respons;
//   }

//   updatatData(String sql) async {
//     Database? mydb = await db;

//     int respons = await mydb!.rawUpdate(sql);
//     return respons;
//   }

mydeleteDatabase() async {
  String databasepath = await getDatabasesPath();
  String path = join(databasepath, "abdu.db");
  return deleteDatabase(path);
}
//}
