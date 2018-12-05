import 'dart:async';
import 'package:flutter_course/models/ders.dart';
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
    String yol = join(dosyaKonumu.path, "dersler.db");
    var veriTabani = await openDatabase(yol, version: 1, onCreate: _ilkAcilis);
    return veriTabani;
  }

  _ilkAcilis(Database vt, int versiyon) async {
    await vt.execute("CREATE TABLE Ders(kodu TEXT, adi TEXT, yili TEXT)");
    await vt.execute("CREATE TABLE Kullanici(ogrNo TEXT, sifre TEXT)");
  }

  Future<int> dersKaydet(Ders ders) async {
    var veritab = await veritabani;
    int cvp = await veritab.insert("Ders", ders.haritaYap());
    return cvp;
  }

  Future<int> kullaniciKaydet(String kullanici, String sifre) async {
    var veritab = await veritabani;
    int cvp = await veritab.insert("Kullanici", {"ogrNo":"$kullanici", "sifre":"$sifre"});
    return cvp;
  }

  Future<List<Ders>> dersleriGetir() async {
    var veritab = await veritabani;

    List<Map> liste = await veritab.rawQuery("SELECT * FROM Ders");
    List<Ders> dersler = new List();

    for (int i=0; i<liste.length; i++) {
      var ders = Ders(liste[i]["kodu"], liste[i]["adi"], liste[i]["yili"]);
      //ders.dersKoduVer(liste[i]["no"]);
      dersler.add(ders);
    }
    return dersler;
  }

  Future<int> dersSil(Ders ders) async {
    var veritab = await veritabani;
    int cvp = await veritab.rawDelete("DELETE FROM Ders WHERE no = ?", [ders.kodu]);
    return cvp;
  }

  Future<bool> dersGuncelle(Ders ders) async {
    var veritab = await veritabani;
    int cvp = await veritab.update("Ders", ders.haritaYap(), where: "kodu = ?", whereArgs: <String>[ders.kodu]);
    return cvp > 0 ? true : false;
  }


}