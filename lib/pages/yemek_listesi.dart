import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:map_view/map_view.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

import '../scoped-models/main.dart';

import '../widgets/ui_elements/drawer_custom.dart';
//import '../widgets/form_inputs/location.dart';

import '../models/eczane.dart';
import '../shared/global_config.dart';
import '../widgets/ui_elements/adaptive_progress_indicator.dart';
import '../widgets/personeller/yemekler.dart';

class YemekListesiSayfasi extends StatefulWidget {
  final MainModel model;

  YemekListesiSayfasi(this.model);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _YemekListesiSayfasiState();
  }
}

class _YemekListesiSayfasiState extends State<YemekListesiSayfasi> {
  
  @override
  initState() {
    widget.model.fetchYemekler();
    super.initState();
  }

  Widget _buildYemeklerList() {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      Widget content = Center(child: Text('Yemek bulunamadı!'+ model.allYemekler.length.toString()));
      if (model.allYemekler.length > 0 ) {
        content = Yemekler();
      } else if (model.isYukleme) {
        content = Center(child: AdaptiveProgressIndicator());
      }
      return RefreshIndicator(
        onRefresh: model.fetchYemekler,
        child: content,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerCustom(),
      appBar: AppBar(
        title: Text("Haftalık Yemek Listesi"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body:  _buildYemeklerList(),
    );
  }
}
