// @dart=2.9
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import '../model/Not.dart';

class DBHelper {
  String tabloAdi = "notlar";
  int id = -1;
  String baslik = "";
  String icerik = "";
  String resim = "";

  static Database _db;

  void _createDb(Database db, int newVersion) async {
    await db.execute("Create table notlar (id INTEGER primary key,"+
        " baslik TEXT,icerik TEXT, resim TEXT)");
  }

  Future<Database> InitializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "notlar.db";
    var dbNotlar = await openDatabase(path,version: 1,onCreate: _createDb);
    return dbNotlar;
  }

  Future<Database> get db async {
    if (_db == null) {
      _db = await InitializeDb();
    }
    return _db;
  }

  Future<int> NotEkle(Not not) async {
    Database db = await this.db;
    var result = await db.insert(tabloAdi, not.toMap());
    return result;
  }

  Future<List> notlariListele() async {
    List<Not> notListesi = List<Not>();
    Database db = await this.db;
    var result =
    await db.rawQuery("SELECT * FROM $tabloAdi ORDER BY id ASC");
    result.forEach((element) {
      notListesi.add(Not.fromObject(element));
    });
    return notListesi;
  }

  Future<int> kayitSayisi() async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM $tabloAdi"));
    return result;
  }
  Future<int> NotGuncelle(Not not) async {
    Database db = await this.db;
    var result = await db.update(tabloAdi, not.toMap(),
        where: "id = ?", whereArgs: [not.id]);
    return result;
  }

  Future<int> NotSil(int id) async {
    Database db = await this.db;
    var result = await db.delete(tabloAdi,  where: "id = ?", whereArgs: [id]);
    return result;
  }

}
