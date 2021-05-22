import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'custom_search_data.dart';

class CustomDataHelper {
  static CustomDataHelper _customDataHelper;
  static Database _db;
  CustomDataHelper._createInstance();
  factory CustomDataHelper() {
    if (_customDataHelper == null) {
      _customDataHelper = CustomDataHelper._createInstance();
    }
    return _customDataHelper;
  }

  CustomDataHelper._privateConstructure();
  static final CustomDataHelper instance =
      CustomDataHelper._privateConstructure();
  Future<Database> get database async {
    if (_db == null) {
      _db = await initDb();
    }
    return _db;
  }

  Future<Database> initDb() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "Database/CustomSearchData.db");
    var exists = await databaseExists(path);
    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data =
          await rootBundle.load(join("assets", "Database/CustomSearchData.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    } else {}
    var db = await openDatabase(path, version: 5 /*, onCreate: _onCreate*/);
    return db;
  }

  Future<List> getPersonalQuotes(String lan) async {
    var dbClient = await database;
    String qry = "SELECT id,title,webSite, FROM CustomData ORDER BY title ASC";
    var result = await dbClient.rawQuery(qry);
    return result.toList();
  }

  /*Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;
    var result = await db.query("History", orderBy: "isFavourite DESC");
    return result;
  }*/

  Future insertNote(CustomSearchData customSearchData) async {
    Database db = await this.database;
    var result = await db.rawQuery(
        'INSERT INTO CustomData(title,webSite) VALUES("${customSearchData.title}", "${customSearchData.webSite}");');
    return result;
  }

  Future updateNote(
    CustomSearchData customSearchData,
  ) async {
    var db = await this.database;
    var result;
    result = await db.update("CustomData", customSearchData.toMap(),
        where: 'id = ?', whereArgs: [customSearchData.id]);
    return result;
  }

  Future<int> deleteNote(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM CustomData WHERE id = $id');
    return result;
  }

/*  Future<int> getCount() async {
    var db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) FROM "History"');
    int result = Sqflite.firstIntValue(x);
    return result;
  }*/

  Future<List<CustomSearchData>> data() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query("CustomData");
    return List.generate(maps.length, (i) {
      return CustomSearchData(
          id: maps[i]['id'],
          title: maps[i]['title'],
          webSite: maps[i]['webSite']);
    });
  }
}
