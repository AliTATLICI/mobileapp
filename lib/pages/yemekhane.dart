import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main.dart';

import '../widgets/ui_elements/drawer_custom.dart';
import '../models/personel.dart';

class YemekhaneSayfasi extends StatefulWidget {
  String _seciliGun;

  YemekhaneSayfasi(this._seciliGun);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _YemekhaneSayfasiState();
  }
}

class _YemekhaneSayfasiState extends State<YemekhaneSayfasi> {
  String _selectedText = "Öğle Yemeği";
  int _menuId;

  String bugun_ne = DateFormat("dd.MM.yyyy").format(DateTime.now());
  Map<String, dynamic> yemek_listesi = {
    '01.10.2018': {
      'gun': 'Pazartesi',
      'menu': [
        'Tarhana Çorbası',
        'Kıymalı Ispanak',
        'Peynirli Makarna',
        'Kase Yoğurt',
        'Kavun '
      ],
      'kalori': '(950 Kcal)'
    },
    '18.10.2018': {
      'gun': 'Perşembe',
      'menu': [
        'Andülüz Çorba',
        'Kuru Fasülye',
        'Pilav',
        'Tatlı hemde kazandibi',
        'Kavun '
      ],
      'kalori': '(950 Kcal)'
    },
    '20.10.2018': {
      'gun': 'Pazartesi',
      'menu': [
        'Tarhana Çorbası',
        'Kıymalı Ispanak',
        'Peynirli Makarna',
        'Kase Yoğurt',
        'Kavun '
      ],
      'kalori': '(950 Kcal)'
    }
  };

  @override
  void initState() {
    _selectedText = "Öğle Yemeği";
    widget._seciliGun = bugun_ne;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerCustom(),
      appBar: AppBar(
        title: Text("Yemekhane"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                    width: 210.0,
                    child: Container(
                      color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            width: 50.0,
                            child: RaisedButton(
                                color: Colors.yellow,
                                onPressed: () {
                                  //Sol tarafa geri tuşuna basıldığında bir önceki gündeki yemek listelenmesi lazım
                                  setState(() {
                                    widget._seciliGun = '18.10.2018';
                                  });
                                },
                                child: Icon(Icons.arrow_back_ios)),
                          ),
                          FlatButton(
                              onPressed: () {
                                //tarih yazan kısma tıklandığında tarih widget i çıkması lazım.
                              },
                              child: Text(widget._seciliGun)),
                          SizedBox(
                            width: 50.0,
                            child: RaisedButton(
                                color: Colors.yellow,
                                onPressed: () {
                                  //Sol tarafa geri tuşuna basıldığında bir önceki gündeki yemek listelenmesi lazım
                                  setState(() {
                                    widget._seciliGun = '01.10.2018';
                                  });
                                },
                                child: Icon(Icons.arrow_forward_ios)),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                    width: 150.0,
                    child: Container(
                      color: Colors.blue,
                      child: DropdownButton<String>(
                        hint: Text("Status"),
                        value: _selectedText,
                        items: <String>['Öğle Yemeği', 'Akşam Yemeği']
                            .map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (String val) {
                          _selectedText = val;
                          setState(() {
                            _selectedText = val;
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 300.0,
                child: Container(
                  color: Colors.green,
                  child: Center(
                    child: ListView.builder(
                      itemCount:
                          yemek_listesi[widget._seciliGun]['menu'].length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            title: Text(yemek_listesi[widget._seciliGun]['menu'][index]));
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100.0,
                child: Container(
                    color: Colors.deepOrange,
                    child: Center(
                      child: Text(widget._seciliGun),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
