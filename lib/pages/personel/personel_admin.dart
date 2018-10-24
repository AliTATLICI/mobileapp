import 'package:flutter/material.dart';

import './personel_duzenle.dart';
import './personel_listele.dart';
import '../../widgets/ui_elements/cikisyap_list_tile.dart';
import '../../scoped-models/main.dart';

class PersonelAdminSayfa extends StatelessWidget {
  final MainModel model;

  PersonelAdminSayfa(this.model);

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
              Navigator.pushReplacementNamed(context, '/personeller');
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
      length: 2,
      child: Scaffold(
        drawer: _buildSideDrawer(context),
        appBar: AppBar(
          title: Text("Personel Listesi"),
          elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.create),
                text: 'Personel Oluştur',
              ),
              Tab(
                icon: Icon(
                  Icons.person,
                ),
                text: 'Kayıtlı Personeller',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            PersonelDuzenleSayfasi(),
            PersonelListeleSayfasi(model)
          ],
        ),
      ),
    );
  }
}
