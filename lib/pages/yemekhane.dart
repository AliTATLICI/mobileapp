import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main.dart';

import '../widgets/ui_elements/drawer_custom.dart';
import '../models/yemek.dart';

class YemekhaneSayfasi extends StatefulWidget {

  final MainModel model;
  String _seciliGun;

  YemekhaneSayfasi(this._seciliGun, this.model);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _YemekhaneSayfasiState();
  }
}

class _YemekhaneSayfasiState extends State<YemekhaneSayfasi> {
  String _selectedText = "Öğle Yemeği";
  int _menuIndex;
  var date = new DateTime(2018, 10, 18);
  var ayin_gunu = DateTime.parse(DateTime.now().toString());
  var gunun_sayi_degeri;

  String bugun_ne = DateFormat("dd.MM.yyyy").format(DateTime.now());
  List<String> gunler;
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  List<Yemek> yemek_listesi;

  List<String> popMenu = ['Günlük', 'Haftalık', 'Aylık'];
  int _selectedRadio = 0;

  @override
  void initState() {
    _selectedText = "Öğle Yemeği";
    widget._seciliGun = bugun_ne;
    gunun_sayi_degeri = ayin_gunu.day.toInt();
    widget.model.fetchYemekler();
    yemek_listesi = widget.model.allYemekler;
    _menuIndex = widget.model.allYemekler.indexWhere((Yemek yemek) => yemek.tarih.startsWith(widget._seciliGun));
    super.initState();
  }

  
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime(2019));
    if (picked != null) {
      print('Date selected : ${_date.toString()}');
      setState(() {
              _date = picked;
              widget._seciliGun = DateFormat("dd.MM.yyyy").format(_date);
              _menuIndex = widget.model.allYemekler.indexWhere((Yemek yemek) => yemek.tarih.startsWith(widget._seciliGun));
            });
    }
  }
  void _select(String choice) {
    if (choice == popMenu[0]) {
      //debugPrint('Haftalık secildi');
      setState(() {
        _selectedRadio = 0;
      });
    } else if (choice == popMenu[1]) {
      //debugPrint('Günlük seçildi');
      setState(() {
        _selectedRadio = 1;
      });
      Navigator.pushNamed(context, "/yemek");
      /*showDialog(context: context, builder: (context) => Center(
                              child: Card(
                                child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: makeRadios(),
                      ),
                ),
              ));
              */

    } else if (choice == popMenu[2]) {
      //debugPrint('Aylık secildi');
      /*
      showDialog(context: context, builder: (context) => Center(
                              child: Card(
                                child: DropdownButton(
            value: _statusSel,
            items: _dropDowmMenuItems,
            onChanged: changedDropDownItem,
          ),
                ),
              ));
              */
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
          return Scaffold(
        drawer: DrawerCustom(),
        appBar: AppBar(
          title: Text("Yemek Listesi (Günlük)"),
          actions: <Widget>[
            PopupMenuButton(
            onSelected: _select,
            itemBuilder: (BuildContext context) {
              return popMenu.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
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
                                    //print(model.allYemekler.forEach((Yemek yemek) {print(yemek.tarih.toString());} ));
                                    setState(() {
                                      gunun_sayi_degeri--;
                                      _menuIndex--;
                                      widget._seciliGun =
                                          (gunun_sayi_degeri).toString() +
                                              '.10.2018';
                                    });
                                  },
                                  child: Icon(Icons.arrow_back_ios)),
                            ),
                            FlatButton(
                                onPressed: () {
                                  _selectDate(context);
                                }, child: Text(widget._seciliGun)),
                            SizedBox(
                              width: 50.0,
                              child: RaisedButton(
                                  color: Colors.yellow,
                                  onPressed: () {
                                    //Sağ tuşuna basıldığında bir sonraki gündeki yemek listelenmesi lazım
                                    setState(() {
                                      gunun_sayi_degeri++;
                                      _menuIndex++;
                                      widget._seciliGun =
                                          (gunun_sayi_degeri).toString() +
                                              '.10.2018';
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
                  height: 350.0,
                  child: Container(
                    //color: Colors.green,
                    child: Center(
                      child: ListView.builder(
                        itemCount:widget.model.allYemekler[_menuIndex].menu.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: <Widget>[
                              ListTile(
                                  title: Text(widget.model.allYemekler[_menuIndex].menu[index])),
                              Divider()
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text("Toplam Kalori : "),
                ),
                SizedBox(
                  height: 50.0,
                  child: Container(
                      color: Colors.deepOrange,
                      child: Center(
                        child: Text(widget._seciliGun + " - " + widget.model.allYemekler[_menuIndex].gun.toString()),
                      )),
                )
              ],
            ),
          ),
        ),
      ); },
    );
  }
}
