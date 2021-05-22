import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'getdata.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _db;
  DatabaseHelper._createInstance();
  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  DatabaseHelper._privateConstructure();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructure();
  Future<Database> get database async {
    if (_db == null) {
      _db = await initDb();
    }
    return _db;
  }

  Future<Database> initDb() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "Database/scan.db");
    var exists = await databaseExists(path);
    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join("assets", "Database/scan.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    } else {}
    var db = await openDatabase(path, version: 5 /*, onCreate: _onCreate*/);
    return db;
  }

  Future<List> getPersonalQuotes(String lan) async {
    var dbClient = await database;
    String qry =
        "SELECT id,saveResult,date,isFavorite FROM History ORDER BY isFavourite DESC";
    var result = await dbClient.rawQuery(qry);
    return result.toList();
  }

  /* Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;
    var result = await db.query("History", orderBy: "isFavourite DESC");
    return result;
  }*/

  Future insertNote(Databasedata databasedata) async {
    Database db = await this.database;
    var result = await db.rawQuery(
        'INSERT INTO History(saveResult,date,isFavourite) VALUES("${databasedata.saveResult}", "${databasedata.date}", ${databasedata.isFavourite});');
    return result;
  }

  Future updateNote(
    Databasedata databasedata,
  ) async {
    var db = await this.database;
    var result;
    result = await db.update("History", databasedata.toMap(),
        where: 'id = ?', whereArgs: [databasedata.id]);
    return result;
  }

  Future<int> deleteNote(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM History WHERE id = $id');
    return result;
  }

/*  Future<int> getCount() async {
    var db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) FROM "History"');
    int result = Sqflite.firstIntValue(x);
    return result;
  }*/

  Future<List<Databasedata>> data() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query("History");
    return List.generate(maps.length, (i) {
      return Databasedata(
          id: maps[i]['id'],
          saveResult: maps[i]['saveResult'],
          date: maps[i]['date'],
          isFavourite: maps[i]['isFavourite']);
    });
  }
}
