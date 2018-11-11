import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import './cep_tag.dart';
import './okunma_tag.dart';
import './bolum_tag.dart';
import '../ui_elements/haber_basligi.dart';
import '../../models/haber_duyuru.dart';
import '../../scoped-models/main.dart';

class HaberDuyuruCard extends StatelessWidget {
  final HaberDuyuru haberDuyuru;
  final int haberDuyuruIndex;
  final String gelenHaberMiDuyuruMu;

  HaberDuyuruCard(this.haberDuyuru, this.haberDuyuruIndex, this.gelenHaberMiDuyuruMu);

  Widget _buildAdiSoyadiSicilRow() {
    return Container(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          HaberBasligi(haberDuyuru.baslik),
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
            return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ButtonTheme(
          minWidth: MediaQuery.of(context).size.width * 2.8 / 12.0,
                  child: FlatButton(
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
            child: Text("Detay"),
            onPressed: () => gelenHaberMiDuyuruMu == "Haber" ? Navigator.pushNamed<bool>(
                context, '/haber/' + model.allHaberler[haberDuyuruIndex].id) : Navigator.pushNamed<bool>(
                context, '/duyuru/' + model.allDuyurular[haberDuyuruIndex].id),
          ),
        ),
        SizedBox(
          width: 5.0,
        ),
        OkunmaTag(haberDuyuru.okunma),
        SizedBox(
          width: 5.0,
        ),
        CepTag(haberDuyuru.createdDate),
       
      ]);},
    );
  }

  Widget _haberResmiVarYok() {
    String ilkresim = haberDuyuru.icerik.firstWhere((o) => o.startsWith('/SDU_Files/'), orElse: () => null);
    FadeInImage fadeInImage;
    if (ilkresim != null) {
     fadeInImage = FadeInImage(
              image: NetworkImage(
                  "http://isparta.edu.tr" + ilkresim),
              height: 120.0,
              fit: BoxFit.cover,
              placeholder: AssetImage('assets/logo_108.png'),
            );
      return Hero(
        tag: haberDuyuru.id,
        child: fadeInImage);
    }
    else {
      return Image.asset('assets/logo_108.png');
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 6.0, bottom: 6.0),
          child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 7.0,
              width: MediaQuery.of(context).size.width * 1.1/ 4.0,  
                          child: _haberResmiVarYok(),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 2.2/21.0,
              width: MediaQuery.of(context).size.width * 2.8 / 4.0,
                          child: _buildAdiSoyadiSicilRow(),
            ),    
            SizedBox(
              height: MediaQuery.of(context).size.height * 1.0/ 21.0,
              width: MediaQuery.of(context).size.width * 2.8/ 4.0,
                          child: _buildActionButtons(context),
            )
              ],
            )
           
          ],
        ),
      ),
    );
  }
}
