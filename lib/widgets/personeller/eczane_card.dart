import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import './cep_tag.dart';
import './bolum_tag.dart';
import '../ui_elements/haber_basligi.dart';
import '../../models/eczane.dart';
import '../../scoped-models/main.dart';

class EczaneCard extends StatelessWidget {
  final Eczane eczane;
  final int eczaneIndex;

  EczaneCard(this.eczane, this.eczaneIndex);

  

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    print('CARD A GELEN ECZANE DATASI');
    print(eczane.telefon.toString());
    return GestureDetector(
      child: Card(
          color: Colors.white,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
        //leading: CircleAvatar(child: Text(eczane.semt)),
        title: Text(eczane.adi + " / " + eczane.semt),
        subtitle: Text("""${eczane.adres}
${eczane.telefon}"""),

      ),
      ButtonTheme.bar( // make buttons use the appropriate styles for cards
        child: ButtonBar(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FlatButton(
              child: Row(children: <Widget>[
                Icon(Icons.phone),
                Padding(padding: EdgeInsets.all(5.0),),
                Text('Eczaneyi Ara')
              ],),
              onPressed: () { /* ... */ },
            ),
            FlatButton(
              child: Row(
                children: <Widget>[
                  Icon(Icons.room),
                  Text('Harita ile Yol Tarifi')
                ],
              ),
              onPressed: () { /* ... */ },
            ),
          ],
        ),
      ),
                
              ])),
      onTap: () {
        debugPrint(eczane.telefon);
        // MapView ile nöbetçi eczanenin yerini tespit etmek için widget oluşturulacak zaman kullanılacack
        //Navigator.pushNamed(context, "/eczane2");
        
      },
    );
  }
}
