import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import './personel_card.dart';
import '../../models/personel.dart';
import '../../scoped-models/main.dart';

class Personeller extends StatelessWidget {
  Widget _buildPersonelList(List<Personel> personeller) {
    Widget personelCard;
    if (personeller.length > 0) {
      personelCard = ListView.builder(
        itemBuilder: (BuildContext context, int index) => PersonelCard(personeller[index], index),
        itemCount: personeller.length,
      );
    } else {
      personelCard = Center(
        child: Text("Personel bulunamadı, lütfen ekleyin!"),
      );
    }
    return personelCard;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model) {
      return _buildPersonelList(model.displayedPersoneller);
    },);
  }
}
