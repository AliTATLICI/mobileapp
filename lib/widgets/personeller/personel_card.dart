import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import './cep_tag.dart';
import './bolum_tag.dart';
import '../ui_elements/adi_soyadi_default.dart';
import '../../models/personel.dart';
import '../../scoped-models/main.dart';

class PersonelCard extends StatelessWidget {
  final Personel personel;
  final int personelIndex;

  PersonelCard(this.personel, this.personelIndex);

  Widget _buildAdiSoyadiSicilRow() {
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AdiSoyadiDefault(personel.adSoyad),
          SizedBox(
            width: 8.0,
          ),
          CepTag(personel.cep),
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
              context, '/personel/' + model.allPersoneller[personelIndex].id),
        ),
        IconButton(
                icon: Icon(model.allPersoneller[personelIndex].isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border),
                color: Colors.red,
                onPressed: () {
                  model.selectPersonel(model.allPersoneller[personelIndex].id);
                  model.togglePersonelFavoriteStatus();
                }
              )
            ,
       
      ]);},
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Column(
        children: <Widget>[
          FadeInImage(
            image: NetworkImage(
                "http://isparta.edu.tr/foto.aspx?sicil_no=" + personel.sicil),
            height: 300.0,
            fit: BoxFit.cover,
            placeholder: AssetImage('assets/staff-default.png'),
          ),
          _buildAdiSoyadiSicilRow(),
          BolumTag(personel.bolum),
          Text(personel.userEmail),
          _buildActionButtons(context)
        ],
      ),
    );
  }
}
