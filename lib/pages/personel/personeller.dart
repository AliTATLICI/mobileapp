import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../../widgets/personeller/personeller.dart';
import '../../widgets/ui_elements/cikisyap_list_tile.dart';
import '../../scoped-models/main.dart';

class PersonellerSayfa extends StatefulWidget {
  final MainModel model;

  PersonellerSayfa(this.model);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PersonellerSayfaState();
  }
}

class _PersonellerSayfaState extends State<PersonellerSayfa> {
  @override
  initState() {
    widget.model.fetchPersonellerDjango();
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

  Widget _buildPersonellerList() {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      Widget content = Center(child: Text('Personel bulunamadı!'));
      if (model.displayedPersoneller.length > 0 && !model.isYukleme) {
        content = Personeller();
      } else if (model.isYukleme) {
        content = Center(child: CircularProgressIndicator());
      }
      return RefreshIndicator(
        onRefresh: model.fetchPersonellerDjango,
        child: content,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: _buildSideDrawer(context),
      appBar: AppBar(
        title: Text("Personel Listesi"),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          ),
          ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
              return IconButton(
                icon: Icon(model.displayedFavoriteOnly
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () {
                  model.toogleGoruntuMode();
                },
              );
            },
          )
        ],
      ),
      body: _buildPersonellerList(),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final cities = ['Isparta', 'Antalya', 'Burdur', 'İStanbul'];

  final recentCities = ['Isparta', 'Burdur'];

  @override
  List<Widget> buildActions(BuildContext context) {
    //actions for app bar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of the app bar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // shom some result based on the selection
    return Center(
          child: Container(
        height: 100.0,
        width: 100.0,
        child: Card(
          color: Colors.red,
          child: Center(
            child: Text(query),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something
    final suggestionList = query.isEmpty
        ? recentCities
        : cities.where((p) => p.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
            onTap: () {
              showResults(context);
            },
            leading: Icon(Icons.location_city),
            title: RichText(
              text: TextSpan(
                  text: suggestionList[index].substring(0, query.length),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                        text: suggestionList[index].substring(query.length),
                        style: TextStyle(color: Colors.grey))
                  ]),
            ),
          ),
      itemCount: suggestionList.length,
    );
  }
}
