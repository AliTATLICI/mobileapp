import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import './cep_tag.dart';
import './bolum_tag.dart';
import '../ui_elements/haber_basligi.dart';
import '../../models/yemek.dart';
import '../../scoped-models/main.dart';

class YemekCard extends StatelessWidget {
  final Yemek yemek;
  final int yemekIndex;

  YemekCard(this.yemek, this.yemekIndex);

  

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return GestureDetector(
      child: Card(
          color: yemek.gun == "Cuma" ? Colors.yellow : Colors.white,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
        //leading: CircleAvatar(child: Text(eczane.semt)),
        title: Text(yemek.tarih + " / " + yemek.gun),
        subtitle: Text("""${yemek.menu.map((item) => item)}
${yemek.kalori}"""),

      ),
                
              ])),
      onTap: () {
        debugPrint(yemek.gun);
        // Card a tıklandıgında tek günün yemek sayfası çıkabilir page > yemekhane.dart
        
      },
    );
  }
}
