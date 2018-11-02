import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:map_view/map_view.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

import '../scoped-models/main.dart';

import '../widgets/ui_elements/drawer_custom.dart';
//import '../widgets/form_inputs/location.dart';

import '../models/eczane.dart';
import '../shared/global_config.dart';
import '../widgets/ui_elements/adaptive_progress_indicator.dart';
import '../widgets/personeller/yemekler.dart';

class YemekListesiSayfasi extends StatefulWidget {
  final MainModel model;

  YemekListesiSayfasi(this.model);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _YemekListesiSayfasiState();
  }
}

class _YemekListesiSayfasiState extends State<YemekListesiSayfasi> {
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
        content = Yemekler();
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
    return Scaffold(
      drawer: DrawerCustom(),
      appBar: AppBar(
        title: Text("Haftalık Yemek Listesi"),
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
