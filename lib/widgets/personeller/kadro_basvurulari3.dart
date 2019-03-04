import 'package:flutter/material.dart';
import 'package:flutter_course/widgets/personeller/kadro_basvurulari_card3.dart';

import 'package:scoped_model/scoped_model.dart';

import '../../models/kadro_basvurulari.dart';
import '../../scoped-models/main.dart';

class KadroBasvurulari3 extends StatelessWidget {
  Widget _buildKadroBasvuruList(List<KadroBasvuru> kadrolar) {
    Widget eczaneCard;
    if (kadrolar.length > 0) {
      eczaneCard = ListView.builder(
        itemBuilder: (BuildContext context, int index) => KadroBasvuruCard3(kadrolar[index], index),
        itemCount: kadrolar.length,
      );
    } else {
      eczaneCard = Center(
        child: Text("Başvuru bulunamadı, tekrar deneyin!"),
      );
    }
    return eczaneCard;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model) {
      return _buildKadroBasvuruList(model.displayedKadroAramalari.length !=0 || model.controllerArama.text.isNotEmpty ? model.displayedKadroAramalari :model.displayedKadroBasvurulari3);
    },);
  }
}
