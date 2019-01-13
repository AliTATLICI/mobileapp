import 'package:flutter/material.dart';

class KadroBasvuru { 
  String id;
  String kadroTuru;
  String basvuran;
  String sicilNo;
  String birim;
  String bolum;
  String abdProgram;
  String basvuruTarihi;
  String basvuruSayisi;
  List juriler;
  String aciklama;
  bool sonDurum;

  KadroBasvuru(
      {@required this.id,
      @required this.kadroTuru,
      @required this.basvuran,
      @required this.sicilNo,
      @required this.birim,
      @required this.bolum,
      @required this.abdProgram,
      @required this.basvuruTarihi,
      @required this.basvuruSayisi,
      @required this.juriler,
      @required this.aciklama,
      @required this.sonDurum});

}

class Juriler {
  int sayisi;
  String adi;

  Juriler({this.sayisi, this.adi});

  Juriler.fromJson(Map<String, dynamic> json) {
    sayisi = json['key'];
    adi = json['adi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sayisi'] = this.sayisi;
    data['adi']=this.adi;
    return data;
  }
}
