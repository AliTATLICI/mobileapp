import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import './haber_card.dart';
import '../../models/haber.dart';
import '../../scoped-models/main.dart';

class Haberler extends StatelessWidget {
  Widget _buildHaberList(List<Haber> haberler) {
    Widget haberCard;
    if (haberler.length > 0) {
      haberCard = ListView.builder(
        itemBuilder: (BuildContext context, int index) => HaberCard(haberler[index], index),
        itemCount: haberler.length,
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
      return _buildHaberList(model.displayedHaberler);
    },);
  }
}
