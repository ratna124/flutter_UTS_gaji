import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'model/item.dart';
import 'model/kategori.dart';

class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;
  DbHelper._createObject();
  Future<Database> initDb() async {
    //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'item.db';
    //create, read databases
    var itemDatabase = openDatabase(path, version: 5, onCreate: _createDb,);
    //mengembalikan nilai object sebagai hasil dari fungsinya
    return itemDatabase;
  }
  //buat tabel baru dengan nama item
  void _createDb(Database db, int version) async {
    await db.execute(''
        'CREATE TABLE item (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,alamat TEXT,nomorhp INTEGER)'
        '');

    await db.execute(''
        'CREATE TABLE kategori (id INTEGER PRIMARY KEY AUTOINCREMENT,golongan TEXT,gaji INTEGER)'
        '');
  }

  //tabel item
  //select databases
  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.initDb();
    var mapList = await db.query('item', orderBy: 'name');
    return mapList;
  }

  //create databases
  Future<int> insert(Item object) async {
    Database db = await this.initDb();
    int count = await db.insert('item', object.toMap());
    return count;
  }

  //update databases
  Future<int> update(Item object) async {
    Database db = await this.initDb();
    int count = await db
        .update('item', object.toMap(), where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  //delete databases
  Future<int> delete(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('item', where: 'id=?', whereArgs: [id]);
    return count;
  }

  Future<List<Item>> getItemList() async {
    var itemMapList = await select();
    int count = itemMapList.length;
    List<Item> itemList = List<Item>();
    for (int i = 0; i < count; i++) {
      itemList.add(Item.fromMap(itemMapList[i]));
    }
    return itemList;
  }


  //tabel kategori
  //select databases
  Future<List<Map<String, dynamic>>> selectK() async {
    Database db = await this.initDb();
    var mapList = await db.query('kategori', orderBy: 'golongan');
    return mapList;
  }

  //create databases
  Future<int> insertK(Kategori object) async {
    Database db = await this.initDb();
    int count = await db.insert('kategori', object.toMap());
    return count;
  }

  //update databases
  Future<int> updateK(Kategori object) async {
    Database db = await this.initDb();
    int count = await db
        .update('kategori', object.toMap(), where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  //delete databases
  Future<int> deleteK(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('kategori', where: 'id=?', whereArgs: [id]);
    return count;
  }

  Future<List<Kategori>> getItemListK() async {
    var itemMapList = await selectK();
    int count = itemMapList.length;
    List<Kategori> itemList = List<Kategori>();
    for (int i = 0; i < count; i++) {
      itemList.add(Kategori.fromMap(itemMapList[i]));
    }
    return itemList;
  }


  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }
}