//import 'dart:async';
//import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_course/widgets/personeller/kadro_basvurulari.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../scoped-models/main.dart';

import '../../widgets/ui_elements/drawer_custom.dart';
//import '../widgets/form_inputs/location.dart';

import '../../widgets/ui_elements/adaptive_progress_indicator.dart';
import '../../widgets/personeller/kadro_basvurulari_card.dart';

class KadroBasvuruSayfasi extends StatefulWidget {
  final MainModel model;

  KadroBasvuruSayfasi(this.model);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _KadroBasvuruSayfasiState();
  }
}

class _KadroBasvuruSayfasiState extends State<KadroBasvuruSayfasi> {
  @override
  initState() {
    widget.model.fetchKadroBasvurulari();
    super.initState();
  }

  Widget _buildKadroList() {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      Widget content = Center(
          child: Text('Başvurular bulunamadı!' +
              model.displayedKadroBasvurulari.length.toString()));
      if (model.displayedKadroBasvurulari.length > 0) {
        content = KadroBasvurulari();
      } else if (model.isYukleme) {
        content = Center(child: AdaptiveProgressIndicator());
      }
      return RefreshIndicator(
        onRefresh: model.fetchEczaneler,
        child: content,
      );
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(
          drawer: DrawerCustom(widget.model),
          appBar: AppBar(
            title: widget.model.displayedGosterArama
                ? TextField(
                  controller: model.controllerArama,
                    decoration: InputDecoration(hintText: "İsim giriniz"),
                    onChanged: model.onSearchTextChanged,
                  )
                : Text("Kadro Başvuruları"),
            actions: <Widget>[
              model.displayedGosterArama
                  ? IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        model.controllerArama.clear();
                        model.onSearchTextChanged("");
                        model.toogleArama();
                      },
                    )
                  : IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        model.toogleArama();
                      },
                    ),
            ],
          ),
          body: _buildKadroList(),
          bottomNavigationBar: BottomNavigationBar(
       currentIndex: 0, // this will be set when a new tab is tapped
       items: [
         BottomNavigationBarItem(
           icon: new Icon(Icons.person_add),
           title: new Text("Öğretim Üyesi"),
         ),
         BottomNavigationBarItem(
           icon: new Icon(Icons.person_outline),
           title: new Text('Öğretim Elemanı'),
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.person),
           title: Text('İdari Personel')
         )
       ],
     ),
        );
      },
    );
  }
}
