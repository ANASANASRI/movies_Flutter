import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

class SQLdb{

  static Database? _db;
  Future<Database?> get db async{
    if(_db == null){
      _db = await initialisation();
      return _db;
    }else{
      return _db;
    }
  }

  //********************************************
  initialisation() async{
    String db_path = await getDatabasesPath();
    String path = join(db_path,"Cinema");
    Database mmydb = await openDatabase(path,onCreate: _createDB,version: 1);
    return mmydb;
  }
  //*********************************************
  _createDB(Database db ,int version) async{
  await db.execute('''
  CREATE TABLE "movies" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "titre" INT NOT NULL,
  "duree" INT NOT NULL
  )
  ''');
  print("=======================Database created!=======================");

  }
  //***********************CRUD**********************

  Future<int> insertData(String sql) async {
    Database? mydb= await db;
    int req = await mydb!.rawInsert(sql);
    return req;
  }

  //*************************LECTIURE*******************************

  Future<List<Map>> getData(String sql) async {
    Database? mydb= await db;
    List<Map> req = await mydb!.rawQuery(sql);
    return req;
  }

  //********************UPDATE********************************
  Future<int> updateData(String sql) async {
    Database? mydb= await db;
    int res = await mydb!.rawUpdate(sql);
    return res;
  }
  //**********************DELETE****************************
  Future<int> deleteData(String sql) async {
    Database? mydb= await db;
    int res = await mydb!.rawDelete(sql);
    return res;
  }

}