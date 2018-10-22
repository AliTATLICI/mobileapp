import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import './eczane_card.dart';
import '../../models/eczane.dart';
import '../../scoped-models/main.dart';

class Eczaneler extends StatelessWidget {
  Widget _buildEczaneList(List<Eczane> eczaneler) {
    Widget eczaneCard;
    print('ECZANELER DEN CARD A GONDERILENLER');
    print(eczaneler);
    if (eczaneler.length > 0) {
      eczaneCard = ListView.builder(
        itemBuilder: (BuildContext context, int index) => EczaneCard(eczaneler[index], index),
        itemCount: eczaneler.length,
      );
    } else {
      eczaneCard = Center(
        child: Text("Eczane bulunamadı, tekrar deneyin!"),
      );
    }
    return eczaneCard;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model) {
      print("************ DISPLAYEDEZCANELER*********");
      print(model.displayedEczaneler);
      return _buildEczaneList(model.displayedEczaneler);
    },);
  }
}
