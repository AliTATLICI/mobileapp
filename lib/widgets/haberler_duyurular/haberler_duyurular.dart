import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import './haber_duyuru_card.dart';
import '../../models/haber_duyuru.dart';
import '../../scoped-models/main.dart';

class HaberlerDuyurular extends StatelessWidget {
  final String gelen;

  HaberlerDuyurular(this.gelen);

  Widget _buildHaberList(List<HaberDuyuru> haberDuyuru) {
    Widget haberDuyuruCard;
    if (haberDuyuru.length > 0) {
      haberDuyuruCard = ListView.builder(
        itemBuilder: (BuildContext context, int index) => HaberDuyuruCard(haberDuyuru[index], index, gelen),
        itemCount: haberDuyuru.length,
      );
    } else {
      haberDuyuruCard = Center(
        child: Text("$gelen bulunamadı, tekrar deneyin!"),
      );
    }
    return haberDuyuruCard;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model) {
      return _buildHaberList(gelen == "Haber" ? model.displayedHaberler : model.displayedDuyurular);
    },);
  }
}
