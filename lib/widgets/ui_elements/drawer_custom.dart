import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../scoped-models/main.dart';

import './cikisyap_list_tile.dart';

class DrawerCustom extends StatefulWidget {

  final MainModel model;

  DrawerCustom(this.model);
  @override
  _DrawerCustomState createState() => _DrawerCustomState();
}

class _DrawerCustomState extends State<DrawerCustom> {
  bool _isAuthenticated = false;

  @override
    void initState() {
      widget.model.otomatikAuthenticate();
      widget.model.kullaniciSubject.listen((bool isAuthenticated) {
      setState(() {
        _isAuthenticated = isAuthenticated;
      });
    });
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the Drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          // AppBar(
          //   automaticallyImplyLeading: false,
          //   //title: Text("Seçiniz"),
          // ),
          ScopedModelDescendant(
            builder: (BuildContext context, Widget child, MainModel model) {
              return !_isAuthenticated ? Padding(
                padding: EdgeInsets.only(top: 10.0),
                              child: ListTile(
            leading: Icon(Icons.home),
            title: Text('Giriş'),
            onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
            },
          ),
              ) : UserAccountsDrawerHeader(
                accountName: Text(model.kullanici.firstName.toString() + " " + model.kullanici.lastName.toString()),
                accountEmail: Text(model.kullanici.email),//model.kullanici.email
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Theme.of(context).platform == TargetPlatform.iOS ? Colors.purple : Colors.white,
                  backgroundImage: NetworkImage(
                    "http://isparta.edu.tr/resim.aspx?sicil_no="+model.kullanici.username,
                  ),
                ),
                otherAccountsPictures: <Widget>[
                  CircleAvatar(
                  backgroundImage: NetworkImage(
                    "http://isparta.edu.tr/foto.aspx?sicil_no="+model.kullanici.username,
                  ),
                )
                ],
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Anasayfa'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/anasayfa');
            },
          ),
         ListTile(
            leading: Icon(Icons.announcement),
            title: Text('Duyurular'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/duyurular');
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Haberler'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/haberler');
            },
          ),
          ListTile(
            leading: Icon(Icons.restaurant_menu),
            title: Text('Yemekhane'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/yemek');
            },
          ),
          ListTile(
            leading: Icon(Icons.person_pin_circle),
            title: Text('Personel Arama'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/personel-arama');
            },
          ),
          ListTile(
            leading: Icon(Icons.school),
            title: Text('Öğrenci Arama'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/ogrenci-arama');
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Akademik Takvim'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/akademik-takvim');
            },
          ),
          ListTile(
            leading: Icon(Icons.explicit),
            title: Text('Norm Kadro'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/norm-kadro');
            },
          ),
          ListTile(
            leading: Icon(Icons.explicit),
            title: Text('Kadro Başvuruları'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/kadro-basvurulari');
            },
          ),
          ListTile(
            leading: Icon(Icons.explicit),
            title: Text('Nöbetçi Eczane'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/eczane');
            },
          ),
          ListTile(
            leading: Icon(Icons.vpn_key),
            title: Text('Üniversite Bilgi Yönetim Sistemi (UBYS)'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/ubys');
            },
          ),
          Divider(),
          CikisYapListTile()
        ],
      ),
    );
  }
}