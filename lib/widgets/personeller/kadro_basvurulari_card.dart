import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:scoped_model/scoped_model.dart';

import './cep_tag.dart';
import './bolum_tag.dart';
import '../ui_elements/haber_basligi.dart';
import '../../models/kadro_basvurulari.dart';
import '../../scoped-models/main.dart';

class KadroBasvuruCard extends StatelessWidget {
  final KadroBasvuru kadro;
  final int kadroIndex;

  KadroBasvuruCard(this.kadro, this.kadroIndex);

  

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
          backgroundImage: NetworkImage("https://isparta.edu.tr/resim.aspx?sicil_no=${kadro.sicilNo}"),
        ),
        title: Text(kadro.basvuran + " / " + kadro.basvuruSayisi, style: TextStyle(fontWeight: FontWeight.bold),),
        subtitle: Text(kadro.birim + "\n" + kadro.bolum + "\n" + kadro.abdProgram),

      ),
      ButtonTheme.bar( // make buttons use the appropriate styles for cards
        child: ButtonBar(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FlatButton(
              child: Row(children: <Widget>[
                Icon(Icons.assignment_ind),
                Padding(padding: EdgeInsets.all(2.0),),
                Text(kadro.kadroTuru == "P" ? "Profesörlük Jürileri" : "Doçentlik Jürileri"),
                SizedBox(width: 20.0,),
                CircleAvatar(
          radius: 10.0,
          backgroundColor: Colors.green,
          child: Text("1"),
        ),
        SizedBox(width: 10.0,),
        CircleAvatar(
          radius: 10.0,
          backgroundColor: Colors.green,
          child: Text("2"),
        ),
        SizedBox(width: 10.0,),
        CircleAvatar(
          radius: 10.0,
          backgroundColor: Colors.red,
          child: Text("3"),
        )
              ],),
              onPressed: () {
                showDialog(
            context: context,
            builder: (BuildContext context) {
              return new SimpleDialog(
                children: <Widget>[
                  new Container(
                    height: 60.0 * 3,
                    width: 150.0,
                    child: ListView.builder(
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Text((index+1).toString()),
                          title: Text(kadro.juriler[index]["adi"]),
                          subtitle: Text(kadro.juriler[index]["giden"]),
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
              
            )
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
