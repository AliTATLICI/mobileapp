import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main.dart';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_course/models/ders.dart';
import 'package:flutter_course/widgets/helpers/sqflite_helper.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:intl/intl.dart';

import '../widgets/ui_elements/drawer_custom.dart';
import '../scoped-models/main.dart';
import '../models/auth.dart';

import '../models/kisayol.dart';

class UBYSSayfa extends StatefulWidget {
  final MainModel model;

  UBYSSayfa(this.model);
  @override
  _UBYSSayfaState createState() => _UBYSSayfaState();
}

class _UBYSSayfaState extends State<UBYSSayfa> {
  AuthMode _authMode = AuthMode.Login;

  final Map<String, dynamic> _formData = {
    'username': null,
    'password': null,
    'acceptTerms': false
  };
  final _formKey = GlobalKey<FormState>();
  List<KisaYol> kisayolMenusu = <KisaYol>[
    KisaYol(
        no: 1, baslik: 'Elektronik Posta', icon: Icons.email, page: 'kisayol'),
    KisaYol(
        no: 2,
        baslik: 'Öğrenci Bilgi Sistemi',
        icon: Icons.school,
        page: 'obs'),
    KisaYol(
        no: 3,
        baslik: 'Personel Bilgi Sistemi',
        icon: Icons.supervisor_account,
        page: 'pbs'),
    KisaYol(
        no: 4,
        baslik: 'Elektronik Belge Yön.',
        icon: Icons.picture_as_pdf,
        page: 'kisayol'),
    KisaYol(
        no: 5,
        baslik: 'Online Ödeme Sistemi',
        icon: Icons.payment,
        page: 'kisayol'),
    KisaYol(
        no: 6,
        baslik: 'SKS Yönetim Sistemi',
        icon: Icons.shutter_speed,
        page: 'kisayol'),
    KisaYol(
        no: 7,
        baslik: 'Servis Destek İşlemleri',
        icon: Icons.pan_tool,
        page: 'kisayol'),
    KisaYol(
        no: 8,
        baslik: 'Kalite Yönetim Sistemi',
        icon: Icons.star_half,
        page: 'kisayol'),
    KisaYol(
        no: 9,
        baslik: 'Mezun Takip Sistemi',
        icon: Icons.person_pin,
        page: 'kisayol'),
  ];

  final formKontrolcu = GlobalKey<FormState>();

  final ogrNoCtrl = TextEditingController();
  final sifreCtrl = TextEditingController();

  final dersKoduCtrl = TextEditingController();
  final dersAdiCtrl = TextEditingController();
  final dersYiliCtrl = TextEditingController();

  VtYardimcisi vtYardimcisi = VtYardimcisi();

  _kullaniciEkle() {
    vtYardimcisi.kullaniciKaydet(ogrNoCtrl.text, sifreCtrl.text).then((deger) {
      debugPrint(deger.toString());
      if (deger > 0) {
        Navigator.pushNamed(context, "/ubys-obs");
      }
    });
  }

  _dersEkle() {
    vtYardimcisi
        .dersKaydet(
            Ders(dersKoduCtrl.text, dersAdiCtrl.text, dersYiliCtrl.text))
        .then((deger) {
      debugPrint(deger.toString());
      if (deger > 0) {
        dersKoduCtrl.clear();
        dersAdiCtrl.clear();
        dersYiliCtrl.clear();
        Navigator.pop(context);
      }
    });
  }

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
                  Text(
                    kisayol.baslik,
                    style: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.center,
                  ),
                ]),
          )),
      onTap: () {
        if (kisayol.page == 'obs') {
          Navigator.pushNamed(context, "/anasayfa");
          // showDialog(
          //   context: context,
          //   barrierDismissible: false,
          //   builder: (BuildContext context) {
          //     return AlertDialog(
          //       title: Text("Öğrenci Bilgi Sistemi Giriş"),
          //       content: SingleChildScrollView(
          //         child: Column(
          //           //crossAxisAlignment: CrossAxisAlignment.center,
          //           children: <Widget>[
          //             Form(
          //               key: _formKey,
          //               child: Column(
          //                 children: <Widget>[
          //                   TextFormField(
          //                     // validator: (val) {
          //                     //   if (val.length != 10) {
          //                     //     return "Lütfen 10 haneli öğrenci numranızı giriniz";
          //                     //   }
          //                     // },
          //                     keyboardType: TextInputType.number,
          //                     controller: ogrNoCtrl,
          //                     decoration: InputDecoration(
          //                         hintText: "Öğrenci Numaranızı Giriniz"),
          //                     onSaved: (String value) {
          //                       _formData['username'] = value;
          //                     },
          //                   ),
          //                   TextFormField(
          //                     // validator: (val) {
          //                     //   if (val.isEmpty) {
          //                     //     return "Şifrenizi boş geçmeyiniz!";
          //                     //   }
          //                     // },
          //                     obscureText: true,
          //                     controller: sifreCtrl,
          //                     decoration: InputDecoration(
          //                         hintText: "Şifrenizi Giriniz"),
          //                     onSaved: (String value) {
          //                       _formData['password'] = value;
          //                     },
          //                   ),
          //                 ],
          //               ),
          //             )
          //           ],
          //         ),
          //       ),
          //       actions: <Widget>[
          //         ScopedModelDescendant(
          //           builder:
          //               (BuildContext context, Widget child, MainModel model) {
          //             return model.isYukleme
          //                 ? CircularProgressIndicator()
          //                 : RaisedButton(
          //                     textColor: Colors.white,
          //                     child: Text('GİRİŞ'),
          //                     onPressed: () =>
          //                         _gonderForm(model.obsdogrulamaDjango),
          //                   );
          //           },
          //         ),
          //       ],
          //     );
          //   },
          // );
        } else if (kisayol.page == 'pbs') {
          Navigator.pushNamed(context, "/anasayfa");
          // showDialog(
          //   context: context,
          //   barrierDismissible: false,
          //   builder: (BuildContext context) {
          //     return AlertDialog(
          //       title: Text("Ders Ekleme"),
          //       content: SingleChildScrollView(
          //         child: Column(
          //           //crossAxisAlignment: CrossAxisAlignment.center,
          //           children: <Widget>[
          //             Form(
          //               key: formKontrolcu,
          //               child: Column(
          //                 children: <Widget>[
          //                   TextFormField(
          //                     validator: (val) {
          //                       if (val.isEmpty) {
          //                         return "Lütfen ders kodu giriniz";
          //                       }
          //                     },
          //                     controller: dersKoduCtrl,
          //                     decoration: InputDecoration(
          //                         hintText: "Ders Kodu Giriniz"),
          //                   ),
          //                   TextFormField(
          //                     validator: (val) {
          //                       if (val.isEmpty) {
          //                         return "Ders adını boş geçmeyiniz!";
          //                       }
          //                     },
          //                     controller: dersAdiCtrl,
          //                     decoration:
          //                         InputDecoration(hintText: "Ders Adı Giriniz"),
          //                   ),
          //                   TextFormField(
          //                     validator: (val) {
          //                       if (val.isEmpty) {
          //                         return "Ders yılını boş geçmeyiniz!";
          //                       }
          //                     },
          //                     keyboardType: TextInputType.number,
          //                     controller: dersYiliCtrl,
          //                     decoration: InputDecoration(
          //                         hintText: "Ders Yılı Giriniz"),
          //                   )
          //                 ],
          //               ),
          //             )
          //           ],
          //         ),
          //       ),
          //       actions: <Widget>[
          //         FlatButton(
          //           color: Colors.green,
          //           child: Text("Kaydet"),
          //           onPressed: _dersEkle,
          //         ),
          //         FlatButton(
          //           color: Colors.red,
          //           child: Text("İptal"),
          //           onPressed: () {},
          //         )
          //       ],
          //     );
          //   },
          // );
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
              top: MediaQuery.of(context).size.height / 20.0,
              right: MediaQuery.of(context).size.width / 30.0,
              child: CircleAvatar(
                radius: 10.0,
                backgroundColor: Colors.red,
                child: Text("1"),
              ),
            ));

    overlayState.insert(overlayEntry);
    await Future.delayed(Duration(seconds: 2));
    overlayEntry.remove();
  }

  void _gonderForm(Function authenticate) async {
    // if (!_formKey.currentState.validate() || !_formData['acceptTerms']) {
    //   return;
    // }
    _formKey.currentState.save();
    Map<String, dynamic> successInformation;
    successInformation = await authenticate(
        _formData['username'], _formData['password'], _authMode);
    if (successInformation['success']) {
      Navigator.pushReplacementNamed(context, '/personeller');
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Bir Hata Oluştu!'),
            content: Text(successInformation['message']),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Üniversite Bilgi Yönetim Sistemi",
          style: TextStyle(fontSize: 18.0),
        ),
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
                  children: List.generate(kisayolMenusu.length, (index) {
                    return Center(
                      child: buildCard(kisayolMenusu[index]),
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
