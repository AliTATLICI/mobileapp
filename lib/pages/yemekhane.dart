import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main.dart';

import '../widgets/ui_elements/drawer_custom.dart';
import '../models/personel.dart';

class YemekhaneSayfasi extends StatefulWidget {

@override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _YemekhaneSayfasiState();
  }
}

class _YemekhaneSayfasiState extends State<YemekhaneSayfasi> {
  String _selectedText = "Öğle Yemeği";
  Map<String dynamic> const yemek_listesi = {' 1.10.2018' : {'gun' : 'Pazartesi', 'menu' : ['Tarhana Çorbası', 'Kıymalı Ispanak', 'Peynirli Makarna', 'Kase Yoğurt', 'Kavun '], 'kalori' : '(950 Kcal)'}}

  @override
    void initState() {
      _selectedText = "Öğle Yemeği";
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
                                  
                                },
                                child: Icon(Icons.arrow_back_ios)),
                          ),
                              FlatButton(
                              onPressed: () {
                                //tarih yazan kısma tıklandığında tarih widget i çıkması lazım.
                                
                              },
                              child: Text("17.10.2018")),
                              SizedBox(
                                width: 50.0,
                                                            child: RaisedButton(
                          
                            color: Colors.yellow,
                                onPressed: () {
                                      //Sol tarafa geri tuşuna basıldığında bir önceki gündeki yemek listelenmesi lazım
                                  
                                },
                                child: Icon(Icons.arrow_forward_ios)),
                              )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                    width: 140.0,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
