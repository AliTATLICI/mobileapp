import 'dart:async';

import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../../widgets/ui_elements/adi_soyadi_default.dart';
import '../../models/haber_duyuru.dart';
import '../../scoped-models/main.dart';
import '../../widgets/personeller/personel_dersler.dart';
import '../../widgets/haberler_duyurular/haber_fab.dart';

class HaberDuyuruSayfasi extends StatelessWidget {
  final HaberDuyuru haber;
  final String gelenHaberMiDuyuruMu;

  HaberDuyuruSayfasi(this.haber, this.gelenHaberMiDuyuruMu);
  

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
        orElse: () => '/assets/images/isubu-logo@2x.png');
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
                  "$gelenHaberMiDuyuruMu Detayı",
                  softWrap: true,
                  style: TextStyle(fontSize: cihazGenisligi > 700 ? 20 : 16.0,),
                  textAlign: TextAlign.start,
                ),
                background: Hero(
                  tag: haber.id,
                  child: FadeInImage(
                    image: NetworkImage("http://isparta.edu.tr/" + ilkresim),
                    height: 200.0,
                    fit: BoxFit.cover,
                    placeholder: AssetImage('assets/isubu_logo_opacity2.png'),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return index == 0 ? Container(padding: EdgeInsets.only(top: 15.0), child: Text(haber.baslik, style: TextStyle(color: Colors.red, fontSize: 16.0), textAlign: TextAlign.center,),) :  haber.icerik[index-1].startsWith(ilkresim) != true ? Container(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
                  alignment: Alignment.center,
                  color: Colors.teal[100 * (index-1 % 9)],
                  child: haber.icerik[index-1].startsWith("/SDU_Files/")
                      ? FadeInImage(
                          image: NetworkImage(
                              "http://isparta.edu.tr/" + haber.icerik[index-1]),
                          height: 200.0,
                          fit: BoxFit.cover,
                          placeholder: AssetImage('assets/isubu_logo_opacity2.png'),
                        )
                      : Text(haber.icerik[index-1]),
                ) : Container();
              }, childCount: haber.icerik.length+1),
            )
          ],
        ),
        floatingActionButton: HaberFAB(),
      ),
    );
  }
}
