import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:scoped_model/scoped_model.dart';

import './cep_tag.dart';
import './bolum_tag.dart';
import '../ui_elements/haber_basligi.dart';
import '../../models/kadro_basvurulari.dart';
import '../../scoped-models/main.dart';

class KadroBasvuruCard2 extends StatelessWidget {
  final KadroBasvuru kadro;
  final int kadroIndex;

  KadroBasvuruCard2(this.kadro, this.kadroIndex);

  Widget getJuriWidgets(kadro, juri)
  {
    List<Widget> list = new List<Widget>();
    for(var i = 0; i < kadro; i++){
        list.add(new CircleAvatar(
          radius: 10.0,
          backgroundColor: juri[i]["durum"]==true? Colors.green:Colors.red,
          child: Text("${i+1}"),
        ),);
        list.add(SizedBox(width: 8,));
    }
    return new Row(children: list);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return GestureDetector(
      child: Card(
          color: Colors.white,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
        leading: CircleAvatar(
          maxRadius: 35.0,
          backgroundImage: kadro.sicilNo == "00000" ? NetworkImage("https://pbs.isparta.edu.tr/api/api/Personel/ResimGetir?id=${kadro.aciklama}"): NetworkImage("https://isparta.edu.tr/resim.aspx?sicil_no=${kadro.sicilNo}"),
        ),
        title: Text(kadro.basvuran, style: TextStyle(fontWeight: FontWeight.bold),),
        subtitle: Text(kadro.birim + "\n" + kadro.bolum + "\n" + kadro.abdProgram),

      ),
      ButtonTheme.bar( // make buttons use the appropriate styles for cards
        child: ButtonBar(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FlatButton(
              child: Row(children: <Widget>[
                Icon(kadro.kadroTuru == "M" ? Icons.swap_vert : Icons.fingerprint),
                Padding(padding: EdgeInsets.all(2.0),),
                Text(kadro.kadroTuru == "M" ? "Muvafakat " : "Güv. Soruş."),
                SizedBox(width: 8,),
                getJuriWidgets(kadro.kadroTuru == "M" ? 4 : 4 , kadro.juriler),
                SizedBox(width: 13.0,)       
        
              ],),
              onPressed: () {
                showDialog(
            context: context,
            builder: (BuildContext context) {
              return new SimpleDialog(
                children: <Widget>[
                  Text(kadro.basvuran + "  Yazışmaları", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 10.0,),
                  new Container(
                    height: 60.0 * 5,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemCount: kadro.juriler.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Text((index+1).toString()),
                          title: Text(kadro.juriler[index]["adi"]),
                          subtitle: Text(kadro.juriler[index]["tarih"] + " / " +kadro.juriler[index]["evrak"]),
                          onTap: () {
                            
                            //Navigator.pop(context, true);

                            //kayitGoster();
                            Navigator.pushNamed(context, "/");
                          },
                        );
                      },
                    ),
                  )
                ],
              );
            },
          );
              }
              
            ),
            FlatButton(
              child: Row(children: <Widget>[
                kadro.sonDurum == false ? Icon(Icons.indeterminate_check_box, color: Colors.redAccent,) : Icon(Icons.check_box, color: Colors.greenAccent,),   
                Text("Detay")
              ],),
              onPressed: () {
                showDialog(
            context: context,
            builder: (BuildContext context) {
              return new SimpleDialog(
                children: <Widget>[
                  Text(kadro.basvuran + "\n  Atama Bilgileri", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 10.0,),
                  new Container(
                    height: 60.0 * 5,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      children: <Widget>[
                           ListTile(
                          title: Text(kadro.aciklama),
                          onTap: () {
                            
                            //Navigator.pop(context, true);

                            //kayitGoster();
                            Navigator.pushNamed(context, "/");
                          },
                        )
                      
                      ],
                       
                     
                    ),
                  )
                ],
              );
            },
          );
              }
              
            )
            //kadro.sonDurum == false ? Icon(Icons.indeterminate_check_box, color: Colors.redAccent,) : Icon(Icons.check_box, color: Colors.greenAccent,)
          ],
        ),
      ),
                
              ])),
      onTap: () {
        debugPrint(kadro.aciklama);
        // MapView ile nöbetçi eczanenin yerini tespit etmek için widget oluşturulacak zaman kullanılacack
        //Navigator.pushNamed(context, "/eczane2");
        
      },
    );
  }

  

}
