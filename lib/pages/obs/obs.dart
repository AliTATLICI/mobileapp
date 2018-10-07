import 'package:flutter/material.dart';

import './obs_anasayfa.dart';
import './obs_donem_dersleri.dart';
import '../../widgets/ui_elements/cikisyap_list_tile.dart';
import '../../scoped-models/main.dart';

class OBSSayfa extends StatelessWidget {
  final MainModel model;

  OBSSayfa(this.model);

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the Drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text("Seçiniz"),
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Tüm Personeller'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          Divider(),
          CikisYapListTile()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: _buildSideDrawer(context),
        appBar: AppBar(
          title: Text("Öğrenci Bilgi Sistemi"),
          elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.home),
                text: 'Ana Sayfa',
              ),
              Tab(
                icon: Icon(Icons.create),
                text: 'Dönem Derslerim',
              ),
              Tab(
                icon: Icon(
                  Icons.school),
                text: 'Tüm Derslerim',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            OBSAnaSayfa(),
            PersonelListeleSayfasi(model),
            PersonelListeleSayfasi(model)
          ],
        ),
      ),
    );
  }
}
