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

class AnaSayfa extends StatefulWidget {
  final MainModel model;

  AnaSayfa(this.model);
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  List<String> anasayfaKisayol = ["0", "1", "9"];
  List<String> anasayfaKalanKisayol = ["2", "3", "4", "5", "6", "7", "8"];
  List<KisaYol> kisayolMenusu = <KisaYol>[
    KisaYol(no: 1, baslik: 'Profil', icon: Icons.perm_identity, page: 'profil'),
    KisaYol(no: 2, baslik: 'ISUBÜ', icon: Icons.home, page: 'web_anasayfa'),
    KisaYol(
        no: 9,
        baslik: 'Kısayol ekle',
        icon: Icons.add_circle_outline,
        page: 'kisayol'),
  ];

  Widget buildGrid(BuildContext context) {
    var myGridView = new GridView.builder(
      itemCount: kisayolMenusu.length,
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        return new GestureDetector(
          child: new Card(
            elevation: 5.0,
            child: new Container(
              //padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 20.0),
              alignment: Alignment.centerLeft,
              margin: new EdgeInsets.only(top: 20.0, bottom: 20.0, left: 20.0),
              child: new Text("kisayolMenusu[index]"),
            ),
          ),
          onTap: () {
            showDialog(
                barrierDismissible: false,
                context: context,
                child: new CupertinoAlertDialog(
                  title: new Column(
                    children: <Widget>[
                      new Text("GridView"),
                      new Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    ],
                  ),
                  content: new Text("kisayolMenusu[index]"),
                  actions: <Widget>[
                    new FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: new Text("OK"))
                  ],
                ));
          },
        );
      },
    );
    return myGridView;
  }

  @override
  void initState() {
    widget.model.kisayolIdCek();
    kayitGoster();
    kalankayitGoster();
    super.initState();
  }

  void kayitGoster() async {
    final kayitAraci = await SharedPreferences.getInstance();
    List<String> kmenu = kayitAraci.getStringList('kisayollar');
    print("ANASAYFA BASLAMADAN ONCE SHARED BU" + kmenu.toString());
    setState(() {
      anasayfaKisayol = kmenu != null ? kmenu : anasayfaKisayol;
      anasayfaKisayol.sort();
    });
  }

  void kalankayitGoster() async {
    final kayitAraci = await SharedPreferences.getInstance();
    List<String> kmenu = kayitAraci.getStringList('kalanKisayollar');
    print("ANASAYFA BASLAMADAN ONCE SHARED BU" + kmenu.toString());
    setState(() {
      anasayfaKalanKisayol = kmenu != null ? kmenu : anasayfaKalanKisayol;
      anasayfaKalanKisayol.sort();
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
                          : Colors.lightBlue),
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
                    height: 60.0 * anasayfaKalanKisayol.length,
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
        title: Text("ISUBÜ Mobil"),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: IconButton(
              tooltip: "Bildirimleriniz",
              icon: Icon(Icons.notifications),
              onPressed: () {
                showOverlay(context);
              },
            ),
          )
        ],
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
                    images: [
                      ExactAssetImage("assets/menu_genel_tanitim.png"),
                      ExactAssetImage("assets/anasayfa2.jpg"),
                      ExactAssetImage("assets/anasayfa3.jpg")
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
                      anasayfaKisayol == null
                          ? kisayolMenusu.length
                          : anasayfaKisayol.length, (index) {
                    return Center(
                      child: buildCard(anasayfaKisayol == null
                          ? kisayolMenusu[index]
                          : widget.model.allKisayollar[
                              int.parse(anasayfaKisayol[index])]),
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

class Choice {
  const Choice({this.title, this.icon, this.page});

  final String title;
  final IconData icon;
  final String page;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Profil', icon: Icons.perm_identity, page: 'profil'),
  const Choice(title: 'ISUBÜ', icon: Icons.home, page: 'anasayfa'),
  const Choice(
      title: 'Yemekhane', icon: Icons.restaurant_menu, page: 'yemekhane'),
  const Choice(title: 'Eczane', icon: Icons.explicit, page: 'eczane'),
  const Choice(
      title: 'Kısayol ekle', icon: Icons.add_circle_outline, page: 'kısayol'),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);
  final KisaYol choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
  }
}
