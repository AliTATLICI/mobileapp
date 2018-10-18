import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../scoped-models/main.dart';

import './cikisyap_list_tile.dart';

class DrawerCustom extends StatefulWidget {

  //final MainModel model;

  //DrawerCustom(this.model);
  @override
  _DrawerCustomState createState() => _DrawerCustomState();
}

class _DrawerCustomState extends State<DrawerCustom> {
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
              return UserAccountsDrawerHeader(
                accountName: Text("Ali TATLICI"),
                accountEmail: Text("eposta yazacak"),//model.kullanici.email
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Theme.of(context).platform == TargetPlatform.iOS ? Colors.purple : Colors.white,
                  backgroundImage: NetworkImage(
                    "http://isparta.edu.tr/resim.aspx?sicil_no=01582",
                  ),
                ),
                otherAccountsPictures: <Widget>[
                  CircleAvatar(
                  backgroundImage: NetworkImage(
                    "http://isparta.edu.tr/foto.aspx?sicil_no=01582",
                  ),
                )
                ],
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Anasayfa'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
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
            leading: Icon(Icons.history),
            title: Text('Duyurular'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/duyurular');
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Personel Yönetimi'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/admin');
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Öğrenci Bilgi Sistemi'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/obs');
            },
          ),
          ListTile(
            leading: Icon(Icons.school),
            title: Text('Öğrenci Arama'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/ogrenciler');
            },
          ),
          ListTile(
            leading: Icon(Icons.person_pin_circle),
            title: Text('Personel Arama'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/personel-arama');
            },
          ),
          Divider(),
          CikisYapListTile()
        ],
      ),
    );
  }
}