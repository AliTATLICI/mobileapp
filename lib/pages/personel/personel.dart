import 'dart:async';

import 'package:flutter/material.dart';


import '../../widgets/ui_elements/adi_soyadi_default.dart';
import '../../models/personel.dart';
import '../../widgets/personeller/personel_dersler.dart';

class PersonelSayfa extends StatelessWidget {
  final Personel personel;

  PersonelSayfa(this.personel);
  _showWarnigDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Emin misiniz?"),
            content: Text("Bu işlem geri alınamaz!"),
            actions: <Widget>[
              FlatButton(
                child: Text("İPTAL"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text("DEVAM"),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context, true);
                },
              ),
            ],
          );
        });
  }

  Widget _buildBolumCepRow(String eposta, String cep) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
            eposta,
            style: TextStyle(fontFamily: 'Oswald', color: Colors.grey),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            '|',
            style: TextStyle(fontFamily: 'Oswald', color: Colors.grey),
          ),
        ),
        Text(
          cep,
          style: TextStyle(fontFamily: 'Oswald', color: Colors.grey),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(onWillPop: () {
      print("< Geri Butonuna Basıldı");
      Navigator.pop(context, false);
      return Future.value(false);
    }, child: Scaffold(
          appBar: AppBar(
            title: Text('Personel Detayı (${personel.sicil})'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FadeInImage(
                image: NetworkImage("http://isparta.edu.tr/foto.aspx?sicil_no=" + personel.sicil),
                height: 300.0,
                fit: BoxFit.cover,
                placeholder: AssetImage('assets/staff-default.png'),
              ),
              Container(
                padding: EdgeInsets.all(5.0),
                child: AdiSoyadiDefault(personel.adSoyad),
              ),
              _buildBolumCepRow(personel.eposta, personel.cep != null ? personel.cep : ''),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  personel.birim != null ? personel.birim : '',
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  personel.bolum != null ? personel.bolum : '',
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  personel.abd != null ? personel.abd : '',
                  textAlign: TextAlign.center,
                ),
              ),
              personel.bolum == null ? Container() : Text('Haftalık Ders Programı', style: TextStyle(color: Colors.amber),),
              personel.bolum == null ? Container() : Expanded(child: ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              EntryItem(data[index]),
          itemCount: data.length,
        ),)
            ],
          ),
        ),);
    
  }
}
