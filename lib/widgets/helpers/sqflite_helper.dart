import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class VtYardimcisi {
  static final VtYardimcisi _yardimci = VtYardimcisi.icislem();

  factory VtYardimcisi() => _yardimci;

  VtYardimcisi.icislem();

  static Database _vt;

  Future<Database> get veritabani async {
    if(_vt != null) return _vt;
    _vt = await olusturVt();
    return _vt;
  }

  olusturVt() async {
    io.Directory dosyaKonumu = await getApplicationDocumentsDirectory();
    String yol = join(dosyaKonumu.path, "ogrenciler.db");
    var veriTabani = await openDatabase(yol, version: 1, onCreate: _ilkAcilis);
    return veriTabani;
  }

  _ilkAcilis(Database vt, int versiyon) async {
    await vt.execute("CREATE TABLE Ogrenci(no INTEGER PRIMARY KEY, isim TEXT, soyisim TEXT, sinif TEXT)");
  }
}