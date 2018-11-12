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
import '../widgets/personeller/eczaneler.dart';

class EczaneSayfasi extends StatefulWidget {
  final MainModel model;

  EczaneSayfasi(this.model);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EczaneSayfasiState();
  }
}

class _EczaneSayfasiState extends State<EczaneSayfasi> {
  
  @override
  initState() {
    widget.model.fetchEczaneler();
    super.initState();
  }

  Widget _buildEczanelerList() {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      Widget content = Center(child: Text('Eczane bulunamadı!'+ model.displayedEczaneler.length.toString()));
      if (model.displayedEczaneler.length > 0 ) {
        content = Eczaneler();
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
    return Scaffold(
      drawer: DrawerCustom(widget.model),
      appBar: AppBar(
        title: Text("Nöbetçi Eczaneler"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body:  _buildEczanelerList(),
    );
  }
}
