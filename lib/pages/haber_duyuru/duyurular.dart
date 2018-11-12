import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../../widgets/haberler_duyurular/haberler_duyurular.dart';
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

  

  Widget _buildHaberlerList() {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      Widget content = Center(child: Text('Duyuru bulunamadı!'+ model.displayedDuyurular.length.toString()));
      if (model.displayedDuyurular.length > 0 ) {
        content = HaberlerDuyurular("Duyuru");
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
      drawer: DrawerCustom(widget.model),
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

