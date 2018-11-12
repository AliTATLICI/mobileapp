import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:scoped_model/scoped_model.dart';

import '../../widgets/haberler_duyurular/haberler_duyurular.dart';
import '../../widgets/ui_elements/drawer_custom.dart';
import '../../widgets/ui_elements/adaptive_progress_indicator.dart';
import '../../scoped-models/main.dart';

class HaberlerSayfa extends StatefulWidget {
  final MainModel model;

  HaberlerSayfa(this.model);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HaberlerSayfaState();
  }
}

class _HaberlerSayfaState extends State<HaberlerSayfa> {
  @override
  initState() {
    widget.model.fetchHaberlerDjango();
    super.initState();
  }

  Widget _buildHaberlerList() {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      Widget content = Center(child: Text('Haber bulunamadı!'+ model.displayedHaberler.length.toString()));
      if (model.displayedHaberler.length > 0 ) {
        content = HaberlerDuyurular("Haber");
      } else if (model.isYukleme) {
        content = Center(child: AdaptiveProgressIndicator());
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
        title: Text("Haberler"),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
        actions: <Widget>[
        ],
      ),
      body: _buildHaberlerList(),
    );
  }
}

