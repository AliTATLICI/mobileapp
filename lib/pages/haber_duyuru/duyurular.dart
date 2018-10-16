import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../../widgets/personeller/duyurular.dart';
import '../../widgets/ui_elements/cikisyap_list_tile.dart';
import '../../widgets/ui_elements/drawer_custom.dart';

import '../../scoped-models/main.dart';

class DuyurularSayfa extends StatefulWidget {
  final MainModel model;

  DuyurularSayfa(this.model);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DuyurularSayfaState();
  }
}

class _DuyurularSayfaState extends State<DuyurularSayfa> {
  @override
  initState() {
    widget.model.fetchDuyurularDjango();
    super.initState();
  }

  Widget _buildSideDrawer(BuildContext context) {
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
                accountEmail: Text(model.kullanici.email),
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
            leading: Icon(Icons.report),
            title: Text('Haberler'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/haberler');
            },
          ),
          ListTile(
            leading: Icon(Icons.report),
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
            leading: Icon(Icons.school),
            title: Text('Öğrenciler'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/ogrenciler');
            },
          ),
          Divider(),
          CikisYapListTile()
        ],
      ),
    );
  }

  Widget _buildHaberlerList() {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      Widget content = Center(child: Text('Duyuru bulunamadı!'+ model.displayedHaberler.length.toString()));
      if (model.displayedHaberler.length > 0 ) {
        content = Duyurular();
      } else if (model.isYukleme) {
        content = Center(child: CircularProgressIndicator());
      }
      return RefreshIndicator(
        onRefresh: model.fetchHaberlerDjango,
        child: content,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: DrawerCustom(),
      appBar: AppBar(
        title: Text("Duyurular"),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
        actions: <Widget>[
        ],
      ),
      body: _buildHaberlerList(),
    );
  }
}

