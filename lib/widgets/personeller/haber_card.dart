import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import './cep_tag.dart';
import './bolum_tag.dart';
import '../ui_elements/haber_basligi.dart';
import '../../models/haber.dart';
import '../../scoped-models/main.dart';

class HaberCard extends StatelessWidget {
  final Haber haber;
  final int haberIndex;

  HaberCard(this.haber, this.haberIndex);

  Widget _buildAdiSoyadiSicilRow() {
    return Container(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          HaberBasligi(haber.baslik),
          SizedBox(
            width: 8.0,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return ScopedModelDescendant(
          builder: (BuildContext context, Widget child, MainModel model) { 
            return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.info),
          //iconSize: 20.0,
          color: Theme.of(context).accentColor,
          onPressed: () => Navigator.pushNamed<bool>(
              context, '/haber/' + model.allHaberler[haberIndex].id),
        ),
        CepTag(haber.createdDate),
       
      ]);},
    );
  }

  Widget _haberResmiVarYok() {
    String ilkresim = haber.icerik.firstWhere((o) => o.startsWith('/SDU_Files/'), orElse: () => null);
    FadeInImage fadeInImage;
    if (ilkresim != null) {
     fadeInImage = FadeInImage(
              image: NetworkImage(
                  "http://w3.sdu.edu.tr" + ilkresim),
              height: 240.0,
              fit: BoxFit.cover,
              placeholder: AssetImage('assets/staff-default.png'),
            );
      return fadeInImage;
    }
    else {
      return Text(haber.id);
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 6.0, bottom: 6.0),
          child: Card(
        child: Column(
          children: <Widget>[
            _haberResmiVarYok(),
            _buildAdiSoyadiSicilRow(),
            //BolumTag(haber.id),
            //Text(haber.numarasi),
            _buildActionButtons(context)
          ],
        ),
      ),
    );
  }
}
