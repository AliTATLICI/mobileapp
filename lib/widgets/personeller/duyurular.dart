import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import './duyuru_card.dart';
import '../../models/duyuru.dart';
import '../../scoped-models/main.dart';

class Duyurular extends StatelessWidget {
  Widget _buildHaberList(List<Duyuru> duyurular) {
    Widget haberCard;
    if (duyurular.length > 0) {
      haberCard = ListView.builder(
        itemBuilder: (BuildContext context, int index) => DuyuruCard(duyurular[index], index),
        itemCount: duyurular.length,
      );
    } else {
      haberCard = Center(
        child: Text("Haber bulunamadı, tekrar deneyin!"),
      );
    }
    return haberCard;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model) {
      return _buildHaberList(model.displayedDuyurular);
    },);
  }
}
