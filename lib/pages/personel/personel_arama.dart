import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../scoped-models/main.dart';

import '../../widgets/ui_elements/drawer_custom.dart';
import '../../models/personel.dart';

class PersonelAramaSayfasi extends StatelessWidget {

  final MainModel model;

  PersonelAramaSayfasi(this.model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerCustom(model),
      appBar: AppBar(
        title: Text("Personel Arama"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          )
        ],
      ),
    );
  }
}

class DataSearch extends SearchDelegate<MainModel> {
  final cities = ['Isparta', 'Antalya', 'Burdur', 'İStanbul'];

  List<Personel> recentCities;

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
   
    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model) {
      final List<Personel> suggestionList = query.isEmpty
        ? recentCities
        : model.allPersoneller.where((p) => p.adSoyad.startsWith(query)).toList();
      print("SUGGESTIONLIST------------************************");
      //print(suggestionList[0].sicil);
     return ListView.builder(
      itemBuilder: (context, index) => ListTile(
            onTap: () {
              showResults(context);
            },
            leading: query.isNotEmpty ? CircleAvatar(
                  backgroundImage: NetworkImage(
                    "http://w3.sdu.edu.tr/foto.aspx?sicil_no=" +
                        suggestionList[index].sicil,
                  ),
                ) : Icon(Icons.person_pin),
            title: RichText(
              text: TextSpan(
                  text: query.isNotEmpty ? suggestionList[index].adSoyad.substring(0, query.length): null,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                        text: query.isNotEmpty ? suggestionList[index].adSoyad.substring(query.length) : null,
                        style: TextStyle(color: Colors.grey))
                  ]),
            ),
            //subtitle: Text(query.isNotEmpty ? suggestionList[index].adSoyad: null),
            trailing: _buildDuzenleButonu(context, index, suggestionList)
                      ),
                  itemCount: suggestionList?.length ?? 0,
                );
                },);
              }
            
              _buildDuzenleButonu(BuildContext context, int index, suggestionList) {
                return IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => Navigator.pushNamed<bool>(
              context, '/personel/' + suggestionList[index].id),
                );
              }
}
