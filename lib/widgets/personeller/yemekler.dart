import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import './yemek_card.dart';
import '../../models/yemek.dart';
import '../../scoped-models/main.dart';

class Yemekler extends StatelessWidget {
  Widget _buildEczaneList(List<Yemek> yemekler) {
    Widget yemekCard;
    if (yemekler.length > 0) {
      yemekCard = ListView.builder(
        itemBuilder: (BuildContext context, int index) => YemekCard(yemekler[index], index),
        itemCount: yemekler.length,
      );
    } else {
      yemekCard = Center(
        child: Text("Yemek Listesi bulunamadı, tekrar deneyin!"),
      );
    }
    return yemekCard;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model) {
      return _buildEczaneList(model.allYemekler);
    },);
  }
}
