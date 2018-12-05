import 'package:flutter/material.dart';
import 'package:flutter_course/models/ders.dart';
import 'package:flutter_course/widgets/helpers/sqflite_helper.dart';

class UbysObs extends StatefulWidget {
  @override
  _UbysObsState createState() => _UbysObsState();
}

class _UbysObsState extends State<UbysObs> {
  VtYardimcisi vtYardimcisi = VtYardimcisi();
  List<Ders> dersler = List();

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      vtYardimcisi.dersleriGetir().then((gelen) {
        dersler = gelen;
      });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Öğrenci Bilgi Sistemi"),
      ),
      body: ListView.builder(
        itemCount: dersler.length,
        itemBuilder: (BuildContext baglam, int sira) {
          return Card(child: Column(
            children: <Widget>[
              ListTile(
                leading: Text("${dersler[sira].kodu}"),
                title: Text("${dersler[sira].adi}"),                
                subtitle: Text("${dersler[sira].yili}"),
              )
            ],
          ),);
        },
      ),
    );
  }
}