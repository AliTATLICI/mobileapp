import 'dart:async';

import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../../widgets/ui_elements/adi_soyadi_default.dart';
import '../../models/haber.dart';
import '../../scoped-models/main.dart';
import '../../widgets/personeller/personel_dersler.dart';
import '../../widgets/personeller/haber_fab.dart';

class HaberSayfa extends StatelessWidget {
  final Haber haber;

  HaberSayfa(this.haber);
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
    String ilkresim = haber.icerik.firstWhere((o) => o.startsWith('/SDU_Files/'), orElse: () => '/SDU_Files/Images/IMG_9529.JPG');
    return WillPopScope(onWillPop: () {
      print("< Geri Butonuna Basıldı");
      Navigator.pop(context, false);
      return Future.value(false);
    }, child: Scaffold(
          appBar: AppBar(
            title: Text(haber.numarasi),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FadeInImage(
                image: NetworkImage("http://w3.sdu.edu.tr/" + ilkresim),
                height: 300.0,
                fit: BoxFit.cover,
                placeholder: AssetImage('assets/staff-default.png'),
              ),
              Container(
                padding: EdgeInsets.all(5.0),
                child: AdiSoyadiDefault(haber.numarasi),
              ),
              _buildBolumCepRow(haber.id, haber.createdDate),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  haber.id,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          
          ),
          floatingActionButton: HaberFAB(),
        ),);
    
  }
}
