//import 'dart:async';
//import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped-models/main.dart';

import '../widgets/ui_elements/drawer_custom.dart';
//import '../widgets/form_inputs/location.dart';

import '../widgets/ui_elements/adaptive_progress_indicator.dart';
import '../widgets/personeller/yemekler.dart';

class YemekListesiAylikSayfasi extends StatefulWidget {
  final MainModel model;

  YemekListesiAylikSayfasi(this.model);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _YemekListesiAylikSayfasiState();
  }
}

class _YemekListesiAylikSayfasiState extends State<YemekListesiAylikSayfasi> {
  List<String> popMenu = ['Günlük', 'Haftalık', 'Aylık'];
  int _selectedRadio = 0;
  
  @override
  initState() {
    widget.model.fetchYemekler();
    super.initState();
  }

  Widget _buildYemeklerList() {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      Widget content = Center(child: Text('Yemek bulunamadı!'+ model.allYemekler.length.toString()));
      if (model.allYemekler.length > 0 ) {
        content = Yemekler("aylik");
      } else if (model.isYukleme) {
        content = Center(child: AdaptiveProgressIndicator());
      }
      return RefreshIndicator(
        onRefresh: model.fetchYemekler,
        child: content,
      );
    });
  }

  void _select(String choice) {
    if (choice == popMenu[0]) {
      //debugPrint('Haftalık secildi');
      setState(() {
        _selectedRadio = 0;
      });
      Navigator.pushNamed(context, "/yemekhane");
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
      setState(() {
        _selectedRadio = 2;
      });

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
    return Scaffold(
      drawer: DrawerCustom(widget.model),
      appBar: AppBar(
        title: Text("Aylık Yemek Listesi"),
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
      body:  _buildYemeklerList(),
    );
  }
}
