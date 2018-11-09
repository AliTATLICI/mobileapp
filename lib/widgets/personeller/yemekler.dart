import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:scoped_model/scoped_model.dart';

import './yemek_card.dart';
import '../../models/yemek.dart';
import '../../scoped-models/main.dart';

class Yemekler extends StatelessWidget {
  final String gelen;
  Yemekler(this.gelen);
  Widget _buildEczaneList(List<Yemek> yemekler) {
    Widget yemekCard;
    int tarihBul = yemekler.indexWhere((Yemek yemek) {
      return yemek.tarih == DateFormat("dd.MM.yyyy")
                                  .format(DateTime.now());
    } );
    debugPrint(tarihBul.toString());
    debugPrint(DateFormat.E()
                                  .format(DateTime.now()));

    switch (DateFormat.E().format(DateTime.now())){
      case 'Fri':
      tarihBul = tarihBul - 4;
      break;
      case 'Thu':
      tarihBul = tarihBul - 3;
      break;
      case 'Wed':
      tarihBul = tarihBul - 2;
      break;
      case 'Tue':
      tarihBul = tarihBul - 1;
      break;
      case 'Mon':
      tarihBul = tarihBul;
      break;
      default:
        print("Demekki günlerden Cumartesi ya da Pazar");
    }
    if (yemekler.length > 0) {
      yemekCard = ListView.builder(
        itemBuilder: (BuildContext context, int index) => YemekCard(yemekler[index+tarihBul], index),
        itemCount: gelen == "haftalik" ? 5: yemekler.length,
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
