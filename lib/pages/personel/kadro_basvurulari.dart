//import 'dart:async';
//import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_course/widgets/personeller/kadro_basvurulari.dart';
import 'package:flutter_course/widgets/personeller/kadro_basvurulari2.dart';
import 'package:flutter_course/widgets/personeller/kadro_basvurulari3.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../scoped-models/main.dart';

import '../../widgets/ui_elements/drawer_custom.dart';
//import '../widgets/form_inputs/location.dart';

import '../../widgets/ui_elements/adaptive_progress_indicator.dart';
import '../../widgets/personeller/kadro_basvurulari_card.dart';

class KadroBasvuruSayfasi extends StatefulWidget {
  final MainModel model;

  KadroBasvuruSayfasi(this.model);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _KadroBasvuruSayfasiState();
  }
}

class _KadroBasvuruSayfasiState extends State<KadroBasvuruSayfasi> {

  List<String> popMenu = ['Tümü', 'Görevde Yükselme', 'Unvan Değişikliği'];
  @override
  initState() {
    widget.model.fetchKadroBasvurulari();
    widget.model.fetchKadroBasvurulari2();
    widget.model.fetchKadroBasvurulari3();
    super.initState();
    
  }

  gecerliSayfa(int aktif) {
    switch (aktif) {
      case 0:
        return _buildKadroList();
        debugPrint("****************---------0000000000--basildi");
        break;
      case 1:
        return _ogretimGorevlisiSayfasi();
        debugPrint("****************---------11111111111--basildi");
        break;
      case 2:
        return _idariKadroSayfasi();
        debugPrint("****************---------22222222--basildi");

        break;
      default:
    }
  }

  Widget _buildKadroList() {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      Widget content = Center(
          child: Text('Başvurular bulunamadı!' +
              model.displayedKadroBasvurulari.length.toString()));
      if (model.displayedKadroBasvurulari.length > 0) {
        content = KadroBasvurulari();
      } else if (model.isYukleme) {
        content = Center(child: AdaptiveProgressIndicator());
      }
      return RefreshIndicator(
        onRefresh: model.fetchKadroBasvurulari,
        child: content,
      );
    });
  }

  Widget _ogretimGorevlisiSayfasi() {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      Widget content = Center(
          child: Text('Başvurular bulunamadı!' +
              model.displayedKadroBasvurulari.length.toString()));
      if (model.displayedKadroBasvurulari.length > 0) {
        content = KadroBasvurulari2();
      } else if (model.isYukleme) {
        content = Center(child: AdaptiveProgressIndicator());
      }
      return RefreshIndicator(
        onRefresh: model.fetchKadroBasvurulari2,
        child: content,
      );
    });
  }

  Widget _idariKadroSayfasi() {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      Widget content = Center(
          child: Text('Başvurular bulunamadı!' +
              model.displayedKadroBasvurulari3.length.toString()));
      if (model.displayedKadroBasvurulari3.length > 0) {
        content = KadroBasvurulari3();
      } else if (model.isYukleme) {
        content = Center(child: AdaptiveProgressIndicator());
      }
      return RefreshIndicator(
        onRefresh: model.fetchKadroBasvurulari3,
        child: content,
      );
    });
  }

  void _select(String choice) {
    if (choice == popMenu[0]) {
      debugPrint('Görevde yükselme secildi');
      
        widget.model.setSecilenRadioKadroBasvuru(0);
        
             
    } else if (choice == popMenu[1]) {
      debugPrint('Unvan değişikiği  seçildi');
      
        widget.model.setSecilenRadioKadroBasvuru(1);
             
      

    } else if (choice == popMenu[2]) {
      widget.model.setSecilenRadioKadroBasvuru(2);
      
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(
          drawer: DrawerCustom(widget.model),
          appBar: AppBar(
            title: widget.model.displayedGosterArama
                ? TextField(
                  controller: model.controllerArama,
                    decoration: InputDecoration(hintText: "İsim giriniz"),
                    onChanged: model.onSearchTextChanged,
                  )
                : Text("Kadro Başvuruları"),
            actions: <Widget>[
              model.displayedGosterArama
                  ? IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        model.controllerArama.clear();
                        model.onSearchTextChanged("");
                        model.toogleArama();
                      },
                    )
                  : IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        model.toogleArama();
                      },
                    ),
                    model.getKadroBasvurulariAftifOge ==2 ? PopupMenuButton(
            onSelected: _select,
            itemBuilder: (BuildContext context) {
              return popMenu.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ):Container()
            ],
          ),
          body: gecerliSayfa(model.getKadroBasvurulariAftifOge),
          bottomNavigationBar: BottomNavigationBar(
       currentIndex: model.getKadroBasvurulariAftifOge, // this will be set when a new tab is tapped
       items: [
         BottomNavigationBarItem(
           icon: new Icon(Icons.person_add),
           title: new Text("Öğretim Üyesi"),
         ),
         BottomNavigationBarItem(
           icon: new Icon(Icons.person_outline),
           title: new Text('Öğretim Elemanı'),
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.person),
           title: Text('İdari Personel')
         )
       ],
       onTap: (int i) {
         model.setKadroBasvurulariAktifOge(i);
       },
     ),
        );
      },
    );
  }
}
