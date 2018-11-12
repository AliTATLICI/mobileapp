import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import '../widgets/ui_elements/drawer_custom.dart';
import '../scoped-models/main.dart';
import './yemekhane.dart';
import './eczane.dart';
import '../models/kisayol.dart';

class UBYSSayfa extends StatefulWidget {
  final MainModel model;

  UBYSSayfa(this.model);
  @override
  _UBYSSayfaState createState() => _UBYSSayfaState();
}

class _UBYSSayfaState extends State<UBYSSayfa> {
  List<KisaYol> kisayolMenusu = <KisaYol>[
    KisaYol(no: 1, baslik: 'Elektronik Posta', icon: Icons.email, page: 'kisayol'),
    KisaYol(no: 2, baslik: 'Öğrenci Bilgi Sistemi', icon: Icons.school, page: 'profil'),
    KisaYol(no: 3, baslik: 'Personel Bilgi Sistemi', icon: Icons.supervisor_account, page: 'web_anasayfa'),
    KisaYol(no: 4, baslik: 'Elektronik Belge Yön.', icon: Icons.picture_as_pdf, page: 'kisayol'),
    KisaYol(no: 5, baslik: 'Online Ödeme Sistemi', icon: Icons.payment, page: 'kisayol'),
    KisaYol(no: 6, baslik: 'SKS Yönetim Sistemi', icon: Icons.shutter_speed, page: 'kisayol'),
    KisaYol(no: 7, baslik: 'Servis Destek İşlemleri', icon: Icons.pan_tool, page: 'kisayol'),
    KisaYol(no: 8, baslik: 'Kalite Yönetim Sistemi', icon: Icons.star_half, page: 'kisayol'),
    KisaYol(no: 9, baslik: 'Mezun Takip Sistemi', icon: Icons.person_pin, page: 'kisayol'),

  ];

  
  Widget buildCard(KisaYol kisayol) {
    return GestureDetector(
      child: Card(
          color: Colors.white,
          child: Center(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(kisayol.icon,
                      size: 60.0,
                      color: kisayol.icon == Icons.add_circle_outline
                          ? Colors.grey
                          : Color(0xFF75BDB5)),
                  Text(kisayol.baslik, style: TextStyle(fontSize: 16.0), textAlign: TextAlign.center,),
                ]),
          )),
      onTap: () {
        if (kisayol.baslik == 'Kısayol Ekle') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return new SimpleDialog(
                children: <Widget>[
                  new Container(
                    height: 60.0 * kisayolMenusu.length,
                    width: 150.0,
                    child: ListView.builder(
                      itemCount: widget.model.allKisayolId.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(widget
                              .model
                              .allKisayollar[
                                  int.parse(widget.model.allKisayolId[index])]
                              .icon),
                          title: Text(
                              '${widget.model.allKisayollar[int.parse(widget.model.allKisayolId[index])].baslik}'),
                          onTap: () {
                            widget.model.kisayolEkle(
                                int.parse(widget.model.allKisayolId[index]));
                            //Navigator.pop(context, true);

                            //kayitGoster();
                            Navigator.pushNamed(context, "/");
                          },
                        );
                      },
                    ),
                  )
                ],
              );
            },
          );
        } else {
          Navigator.pushNamed(context, "/${kisayol.page}");
        }
      },
      onLongPress: () {
        debugPrint("uzun basildi");
        if (kisayol.no != 9) {
          showDialog(
              barrierDismissible: false,
              context: context,
              child: new CupertinoAlertDialog(
                title: new Column(
                  children: <Widget>[
                    new Text("Uyarı"),
                    new Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ],
                ),
                content:
                    new Text("${kisayol.baslik} başlıklı kısayol silinecek!"),
                actions: <Widget>[
                  new FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: new Text("İptal")),
                  new FlatButton(
                      onPressed: () {
                        widget.model.kisayolSil(kisayol.no);
                        Navigator.pushNamed(context, "/");
                      },
                      child: new Text("Devam"))
                ],
              ));
        }
      },
    );
  }

  showOverlay(BuildContext context) async {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height/20.0,
        right: MediaQuery.of(context).size.width/30.0,
        child: CircleAvatar(
          radius: 10.0,
          backgroundColor: Colors.red,
          child: Text("1"),
        ),
      )
    );

    overlayState.insert(overlayEntry);
    await Future.delayed(Duration(seconds: 2));
    overlayEntry.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Üniversite Bilgi Yönetim Sistemi", style: TextStyle(fontSize: 18.0),),
      ),
      drawer: DrawerCustom(widget.model),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            Container(
              child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.9 / 3,
                  width: MediaQuery.of(context).size.width,
                  child: new Carousel(
                    autoplayDuration: Duration(seconds: 8),
                    images: [
                      ExactAssetImage("assets/ISUBU.jpg"),
                      ExactAssetImage("assets/ISUBU_1.jpg"),
                      ExactAssetImage("assets/ISUBU_2.jpg")
                    ],
                    dotSize: 4.0,
                    dotSpacing: 15.0,
                    dotColor: Colors.lightGreenAccent,
                    indicatorBgPadding: 5.0,
                    dotBgColor: Colors.lightBlue.withOpacity(0.5),
                    borderRadius: true,
                  )),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                height: MediaQuery.of(context).size.height * 2 / 3,
                color: Colors.grey[250],
                child: GridView.count(
                  crossAxisCount: 3,
                  children: List.generate(
                      kisayolMenusu.length, (index) {
                    return Center(
                      child: buildCard(kisayolMenusu[index]
                          ),
                    );
                  }),
                ),
              ),
            ),
            /* Text(anasayfaKalanKisayol.length == 0
                ? "Id BOŞ"
                : anasayfaKalanKisayol.toString()),
            Text(anasayfaKisayol == null
                ? "ANA SAYFA KISAYOL BOŞ"
                : anasayfaKisayol.toString())
            */
          ],
        ),
      ),
    );
  }
}
