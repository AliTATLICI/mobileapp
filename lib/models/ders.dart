import 'package:flutter/material.dart';

class Ders {
  String _kodu;  
  String _adi;
  String _yili;  
  

  Ders(
   this._kodu,    
    this._adi,
    this._yili  
  );

  Ders.map(dynamic nesne) {
    this._kodu = nesne["kodu"];
    this._adi = nesne["adi"];
    this._yili = nesne["sinif"];

  }

  String get kodu => _kodu;
  String get adi => _adi;
  String get yili => _yili;

  Map<String, dynamic> haritaYap() {
    var map = Map<String, dynamic>();
    map["kodu"] = _kodu;
    map["adi"] = _adi;
    map["yili"] = _yili;

    return map;
  }

  void dersKoduVer(String kod) {
    this._kodu = kod;
  }

}