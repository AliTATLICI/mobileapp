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

  List buildTextViews(int count) {
    List<Widget> strings = List();
    for (int i = 0; i < count; i++) {
      strings.add(new Padding(
          padding: new EdgeInsets.all(16.0),
          child: new Text("" + haber.icerik[i].toString(),
              style: new TextStyle(fontSize: 16.0))));
    }
    return strings;
  }

  @override
  Widget build(BuildContext context) {
    final cihazGenisligi = MediaQuery.of(context).size.width;
    List haber_icerikleri = haber.icerik;
    String ilkresim = haber.icerik.firstWhere(
        (o) => o.startsWith('/SDU_Files/'),
        orElse: () => '/SDU_Files/Images/IMG_9529.JPG');
    return WillPopScope(
      onWillPop: () {
        print("< Geri Butonuna Basıldı");
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text(haber.numarasi),
        // ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                title: Text(
                  haber.baslik,
                  softWrap: true,
                  style: TextStyle(fontSize: cihazGenisligi > 700 ? 20 : 12.0,),
                  textAlign: TextAlign.start,
                ),
                background: Hero(
                  tag: haber.id,
                  child: FadeInImage(
                    image: NetworkImage("http://w3.sdu.edu.tr/" + ilkresim),
                    height: 300.0,
                    fit: BoxFit.cover,
                    placeholder: AssetImage('assets/staff-default.png'),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.teal[100 * (index % 9)],
                  child: haber.icerik[index].startsWith("/SDU_Files/")
                      ? FadeInImage(
                          image: NetworkImage(
                              "http://w3.sdu.edu.tr/" + haber.icerik[index]),
                          height: 200.0,
                          fit: BoxFit.cover,
                          placeholder: AssetImage('assets/staff-default.png'),
                        )
                      : Text(haber.icerik[index]),
                );
              }, childCount: haber.icerik.length),
            )
          ],
        ),
        floatingActionButton: HaberFAB(),
      ),
    );
  }
}
