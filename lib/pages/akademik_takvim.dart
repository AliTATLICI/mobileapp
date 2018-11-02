import 'dart:convert';
import 'package:flutter/material.dart';
import '../widgets/ui_elements/drawer_custom.dart';

import 'package:scoped_model/scoped_model.dart';

import '../scoped-models/main.dart';


class AkademikTakvimSayfasi extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AkademikTakvimSayfasiState();
  }
}

class SuperHeros {}

List<Map<String, dynamic>> takvimGuz = [
  {
    'tarih': '01-29 Ağustos 2018',
    'detay':
        'Yeterlilik Sınavına Girmek İsteyen Öğrencilerin Şahşen veya Dilekçe ileYabancı Diller Yüksekokuluna Müracaatı'
  },
  {
    'tarih': '10-21 Eylül 2018',
    'detay': 'Güz Yarıyılı Öğrenci Katkı Payı ve Öğrenim Ücreti Yatırma '
  },
  {
    'tarih': '17-21 Eylül 2018',
    'detay':
        'Ders Kaydı ve İnternet Üzerinden Kayıt Yenileme\n(BİRİNCİ SINIF ÖĞRENCİLERİ DAHİL) '
  },
  {'tarih': '24 Eylül - 31 Aralık 2018', 'detay': 'GÜZ YARIYILI DERS DÖNEMİ'},
  {
    'tarih': '24-26 Eylül 2018',
    'detay':
        'Güz Yarıyılı Öğrencilerin Okullarına Dilekçe ile Mazeretli Kayıt Başvurusu'
  },
  {'tarih': '01-05 Ekim 2018', 'detay': 'Ders Ekleme-Bırakma '},
  {'tarih': '10-18 Kasım 2018', 'detay': 'Güz Yarıyılı Arasınavları '},
  {'tarih': '02-16 Ocak 2019', 'detay': 'Güz Yarıyıl Sonu Sınavları '},
  {'tarih': '24-28 Ocak 2019', 'detay': 'Güz Yarıyılı Bütünleme Sınavları'}
];

List<Map<String, dynamic>> takvimBahar = [
  {
    'tarih': '02-08 Şubat 2019',
    'detay': 'Bahar Yarıyılı Öğrenci Katkı Payı ve Öğrenim Ücreti Yatırma '
  },
  {
    'tarih': '04-08 Şubat 2019',
    'detay':
        'Ders Kaydı ve İnternet Üzerinden Kayıt Yenileme\n(BİRİNCİ SINIF ÖĞRENCİLERİ DAHİL) '
  },
  {'tarih': '11 Şubat - 21 Mayıs 2019', 'detay': 'BAHAR YARIYILI DERS DÖNEMİ'},
  {
    'tarih': '11-13 Şubat 2019',
    'detay':
        'Bahar Yarıyılı Öğrencilerin Okullarına Dilekçe ile Mazeretli Kayıt Başvurusu'
  },
  {'tarih': '15-20 Şubat 2019', 'detay': 'Ders Ekleme-Bırakma '},
  {
    'tarih': '30 Mart - 07 Nisan Kasım 2019',
    'detay': 'Bahar Yarıyılı Arasınavları '
  },
  {
    'tarih': '22 Mayıs - 16 Haziran 2019',
    'detay':
        'Bahar Yarıyıl Sonu Sınavları (1-9 Haziran tarihleri arasında sınav yapılmayacaktır.) '
  },
  {'tarih': '26-30 Haziran 2019', 'detay': 'Bahar Yarıyılı Bütünleme Sınavları'}
];

class AkademikTakvimSayfasiState extends State<AkademikTakvimSayfasi>
    with TickerProviderStateMixin {
  ScrollController _scrollController = new ScrollController();

  List takvim_guz;
  List takvim_bahar;
  Map takvim;

  @override
  Widget build(BuildContext context) {
    
    // TODO: implement build
    return DefaultTabController(
      length: 2,
          child: new Scaffold(
        drawer: DrawerCustom(),
        appBar: AppBar(
          title: Text('Akademik Takvim'),
          bottom: TabBar(
                tabs: [
                  Tab(text: "Güz Dönemi",),
                  Tab(text: "Bahar Dönemi"),
                ],
              ),
        ),
        body: TabBarView(
              children: [
                Container(
          padding: EdgeInsets.only(top: 15.0),
          child: FutureBuilder(
            future: DefaultAssetBundle.of(context).loadString("assets/load_json/akademik_takvim.json"),
            builder: (context, cevap) {
              takvim = jsonDecode(cevap.data.toString());
              //debugPrint(takvim.toString());
              return ListView.builder(
              itemCount: takvim['guz'].length,
              itemBuilder: (BuildContext context, int index) {
                return MyTimeLine(
                    takvim['guz'][index]['tarih'], takvim['guz'][index]['detay']);
              },
            );
            },
          ),
        ),
                Container(
          padding: EdgeInsets.only(top: 15.0),
          child: ListView.builder(
            itemCount: takvimBahar.length,
            itemBuilder: (context, index) {
              return MyTimeLine(
                  takvimBahar[index]['tarih'], takvimBahar[index]['detay']);
            },
          ),
        )
              ],
            ),
      ),
    );



  }
}



class VerticalSeparator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: new EdgeInsets.symmetric(vertical: 4.0),
        height: 70.0,
        width: 1.0,
        color: Colors.deepOrange);
  }
}

class MyTimeLine extends StatefulWidget {
  String tarih;
  String detay;

  MyTimeLine(this.tarih, this.detay);
  @override
  _TimeLineState createState() => _TimeLineState();
}

class _TimeLineState extends State<MyTimeLine> {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.symmetric(horizontal: 10.0),
      child: new Column(
        children: <Widget>[
          new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                width: 30.0,
                child: new Center(
                  child: new Stack(
                    children: <Widget>[
                      new Padding(
                        padding: new EdgeInsets.only(left: 12.0),
                        child: new VerticalSeparator(),
                      ),
                      new Container(
                        padding: new EdgeInsets.only(),
                        child: new Icon(Icons.timer, color: Colors.white),
                        decoration: new BoxDecoration(
                            color: new Color(0xff00c6ff),
                            shape: BoxShape.circle),
                      )
                    ],
                  ),
                ),
              ),
              new Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Padding(
                      padding: new EdgeInsets.only(left: 20.0, top: 0.0),
                      child: new Text(
                        widget.tarih,
                        style: new TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.deepOrange,
                            fontSize: 16.0),
                      ),
                    ),
                    new Padding(
                      padding: new EdgeInsets.only(left: 20.0, top: 5.0),
                      child: new Text(widget.detay),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
