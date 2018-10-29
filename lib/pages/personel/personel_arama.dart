import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../scoped-models/main.dart';

import '../../widgets/ui_elements/drawer_custom.dart';
import '../../models/personel.dart';

class PersonelAramaSayfasi extends StatefulWidget {
  final MainModel model;

  PersonelAramaSayfasi(this.model);

  @override
  State<StatefulWidget> createState() => _PersonelAramaSayfasiState();
}

enum _RadioGroup { foo1, foo2 }

class _PersonelAramaSayfasiState extends State<PersonelAramaSayfasi> {
  _RadioGroup _itemType = _RadioGroup.foo1;
  int _selectedRadio = 0;
  String _secilenBirim = "Isparta Meslek Yüksekokulu Müdürlüğü";

  List<String> popMenu = ['Akademik', 'İdari'];
  List<DropdownMenuItem<String>> _dropDowmMenuItems = [];
  String _statusSel;

  List<DropdownMenuItem<String>> _getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();

    items.add(DropdownMenuItem(
      value: '01',
      child: Text("Aksu Mehmet Süreyya Demiraslan MYO"),
    ));

    items.add(new DropdownMenuItem(
      value: '02',
      child: Text("Atabey MYO"),
    ));

    items.add(DropdownMenuItem(
      value: '03',
      child: Text("Bilgi İşlem Daire Başkanlığı"),
    ));

    items.add(DropdownMenuItem(
      value: '04',
      child: Text("Eğirdir Meslek Yüksekokulu"),
    ));

    items.add(DropdownMenuItem(
      value: '05',
      child: Text("Eğirdir Su Ürünleri Fakültesi"),
    ));
    items.add(DropdownMenuItem(
      value: '06',
      child: Text("Eğirdir Turizm Ve Otelcilik Yüksekokulu"),
    ));
    items.add(DropdownMenuItem(
      value: '07',
      child: Text("Gelendost MYO"),
    ));
    items.add(DropdownMenuItem(
      value: '08',
      child: Text("Genel Sekreterlik"),
    ));
    items.add(DropdownMenuItem(
      value: '09',
      child: Text("Gönen MYO"),
    ));
    items.add(DropdownMenuItem(
      value: '10',
      child: Text("Isparta MYO"),
    ));
    items.add(DropdownMenuItem(
      value: '11',
      child: Text("Keçiborlu MYO"),
    ));
    items.add(DropdownMenuItem(
      value: '12',
      child: Text("Lisansüstü Eğitim Enstitüsü"),
    ));
    items.add(DropdownMenuItem(
      value: '13',
      child: Text("Orman Fakültesi"),
    ));
    items.add(DropdownMenuItem(
      value: '14',
      child: Text("Personel Daire Başkanlığı"),
    ));
    items.add(DropdownMenuItem(
      value: '15',
      child: Text("Senirkent MYO"),
    ));
    items.add(DropdownMenuItem(
      value: '16',
      child: Text("Sütçüler Prof. Dr. Hasan Gürbüz MYO"),
    ));
    items.add(DropdownMenuItem(
      value: '17',
      child: Text("Şarkikaraağaç MYO"),
    ));
    items.add(DropdownMenuItem(
      value: '18',
      child: Text("Şarkikaraağaç Turizm MYO"),
    ));
    items.add(DropdownMenuItem(
      value: '19',
      child: Text("Tarım Bilimleri Ve Teknolojileri Fakültesi"),
    ));
    items.add(DropdownMenuItem(
      value: '20',
      child: Text("Teknik Bilimler MYO"),
    ));
    items.add(DropdownMenuItem(
      value: '21',
      child: Text("Teknoloji Fakültesi"),
    ));
     items.add(DropdownMenuItem(
      value: '22',
      child: Text("Uluborlu Selahattin Karasoy MYO"),
    ));
     items.add(DropdownMenuItem(
      value: '23',
      child: Text("Uzaktan Eğitim MYO"),
    ));
     items.add(DropdownMenuItem(
      value: '24',
      child: Text("Yalvaç Büyükkutlu Uyg. Bil. Yüksekokulu"),
    ));
     items.add(DropdownMenuItem(
      value: '25',
      child: Text("Yalvaç MYO"),
    ));
     items.add(DropdownMenuItem(
      value: '26',
      child: Text("Yalvaç Teknik Bilimler MYO"),
    ));
     items.add(DropdownMenuItem(
      value: '27',
      child: Text("Yenişarbademli MYO"),
    ));

    return items;
  }

  void changedDropDownItem(String selectedItem) {
    setState(() {
      _statusSel = selectedItem;
      print("SELECTED ITEM  :$selectedItem");
      switch (_statusSel) {
        case '01':
          _secilenBirim = 'Aksu Mehmet Süreyya Demiraslan Meslek Yüksekokulu Müdürlüğü';
          break;
        case '02':
          _secilenBirim = 'Atabey Meslek Yüksekokulu Müdürlüğü';
          break;
        case '03':
          _secilenBirim = 'Bilgi İşlem Daire Başkanlığı';
          break;
        case '04':
          _secilenBirim = 'Eğirdir Meslek Yüksekokulu Müdürlüğü';
          break;
        case '05':
          _secilenBirim = 'Eğirdir Su Ürünleri Fakültesi Dekanlığı';
          break;
        case '06':
          _secilenBirim = 'Eğirdir Turizm Ve Otelcilik Yüksekokulu Müdürlüğü';
          break;
        case '07':
          _secilenBirim = 'Gelendost Meslek Yüksekokulu Müdürlüğü';
          break;
        case '08':
          _secilenBirim = 'Genel Sekreterlik';
          break;
        case '09':
          _secilenBirim = 'Gönen Meslek Yüksekokulu Müdürlüğü';
          break;
        case '10':
          _secilenBirim = 'Isparta Meslek Yüksekokulu Müdürlüğü';
          break;
        case '11':
          _secilenBirim = 'Keçiborlu Meslek Yüksekokulu Müdürlüğü';
          break;
        case '12':
          _secilenBirim = 'Lisansüstü Eğitim Enstitüsü Müdürlüğü';
          break;
        case '13':
          _secilenBirim = 'Orman Fakültesi Dekanlığı';
          break;
        case '14':
          _secilenBirim = 'Personel Daire Başkanlığı';
          break;
        case '15':
          _secilenBirim = 'Senirkent Meslek Yüksekokulu Müdürlüğü';
          break;
        case '16':
          _secilenBirim = 'Sütçüler Prof. Dr. Hasan Gürbüz Meslek Yüksekokulu Müdürlüğü';
          break;
        case '17':
          _secilenBirim = 'Şarkikaraağaç Meslek Yüksekokulu Müdürlüğü';
          break;
        case '18':
          _secilenBirim = 'Şarkikaraağaç Turizm Meslek Yüksekokulu Müdürlüğü';
          break;
        case '19':
          _secilenBirim = 'Tarım Bilimleri Ve Teknolojileri Fakültesi Dekanlığı';
          break;
        case '20':
          _secilenBirim = 'Teknik Bilimler Meslek Yüksekokulu Müdürlüğü';
          break;
        case '21':
          _secilenBirim = 'Teknoloji Fakültesi Dekanlığı';
          break;
        case '22':
          _secilenBirim = 'Uluborlu Selahattin Karasoy Meslek Yüksekokulu Müdürlüğü';
          break;
        case '23':
          _secilenBirim = 'Uzaktan Eğitim Meslek Yüksekokulu Müdürlüğü';
          break;
        case '24':
          _secilenBirim = 'Yalvaç Büyükkutlu Uygulamalı Bilimler Yüksekokulu Müdürlüğü';
          break;
        case '25':
          _secilenBirim = 'Yalvaç Meslek Yüksekokulu Müdürlüğü';
          break;
        case '26':
          _secilenBirim = 'Yalvaç Teknik Bilimler Meslek Yüksekokulu Müdürlüğü';
          break;
        case '27':
          _secilenBirim = 'Yenişarbademli Meslek Yüksekokulu Müdürlüğü';
          break;
        default:
          _secilenBirim = 'Isparta Meslek Yüksekokulu Müdürlüğü';
      }
    });
  }

  @override
  initState() {
    widget.model.fetchPersonellerDjango();
    _dropDowmMenuItems = _getDropDownMenuItems();
    _statusSel = _dropDowmMenuItems[0].value;
    super.initState();
  }

  Widget myBody() {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      final List<Personel> filtrePersonelList = model.allPersoneller.where((p) {
        if (_selectedRadio == 1) {
          return p.birim == _secilenBirim && p.bolum == null;
        } else {
          return p.birim == _secilenBirim && p.bolum != null;
        }
      }).toList();
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1.0),
        itemCount: filtrePersonelList.length,
        itemBuilder: (context, index) => InkWell(
              onTap: () => Navigator.pushNamed<bool>(
                  context, '/personel/' + filtrePersonelList[index].id),
              child: Card(
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.network(
                      "http://isparta.edu.tr/foto.aspx?sicil_no=${filtrePersonelList[index].sicil}",
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            filtrePersonelList[index].adSoyad,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      left: 0.0,
                      top: 0.0,
                      child: Container(
                        color: Colors.red,
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            filtrePersonelList[index].sicil,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
      );
    });
  }

  void changeItemType(
    _RadioGroup type,
  ) {
    setState(() {
      widget.model.toogleAkademikIdari();
      print(widget.model.displayedAkamikIdari.toString());
      _itemType = widget.model.displayedAkamikIdari == false
          ? _RadioGroup.foo1
          : _RadioGroup.foo2;
    });
  }

  void showDemoDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      child: child,
    );
  }

  void onChangedRadio(int value) {
    setState(() {
      _selectedRadio = value;
      print("RADIO DEGISTIRILDI: $value");
    });
  }

  List<Widget> makeRadios() {
    List<Widget> list = new List<Widget>();

    list.add(Row(
      children: <Widget>[
        Radio(
            value: 0,
            groupValue: _selectedRadio,
            onChanged: (int value) => onChangedRadio(value)),
        Text('Akademik')
      ],
    ));
    list.add(Row(
      children: <Widget>[
        Radio(
            value: 1,
            groupValue: _selectedRadio,
            onChanged: (int value) => onChangedRadio(value)),
        Text('İdari')
      ],
    ));

    return list;
  }

  void _select(String choice) {
    if (choice == popMenu[0]) {
      debugPrint('Akademik secildi');
      setState(() {
        _selectedRadio = 0;
      });
    } else if (choice == popMenu[1]) {
      debugPrint('İdari seçildi');
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
      debugPrint('3. eleman secildi');
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
        title: Text("Personel Arama"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          ),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            color: Colors.tealAccent,
            child: SizedBox(
              height: 40.0,
              child: Wrap(
                textDirection: TextDirection.rtl,
                direction: Axis.horizontal,
                children: <Widget>[
                  DropdownButton<String>(
                    hint: Text('Birim Seçiniz'),
                    value: _statusSel,
                    items: _dropDowmMenuItems,
                    onChanged: changedDropDownItem,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: myBody(),
          ),
        ],
      ),
    );
  }
}

class DataSearch extends SearchDelegate<MainModel> {
  final cities = ['Isparta', 'Antalya', 'Burdur', 'İStanbul'];

  List<Personel> recentCities;

  @override
  List<Widget> buildActions(BuildContext context) {
    //actions for app bar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of the app bar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // shom some result based on the selection
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        child: Card(
          color: Colors.red,
          child: Center(
            child: Text(query),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something

    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final List<Personel> suggestionList = query.isEmpty
            ? recentCities
            : model.allPersoneller
                .where((p) =>
                    p.adSoyad.toLowerCase().contains(query.toLowerCase()))
                .toList();

        //print(suggestionList[0].sicil);
        return ListView.builder(
          itemBuilder: (context, index) => ListTile(
              onTap: () {
                showResults(context);
              },
              leading: query.isNotEmpty
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(
                        "http://isparta.edu.tr/resim.aspx?sicil_no=" +
                            suggestionList[index].sicil,
                      ),
                    )
                  : Icon(Icons.person_pin),
              title: RichText(
                text: TextSpan(
                    text: query.isNotEmpty
                        ? suggestionList[index].adSoyad.substring(
                            0,
                            suggestionList[index]
                                .adSoyad
                                .toLowerCase()
                                .indexOf(query.toLowerCase()))
                        : null,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                          text: query.isNotEmpty
                              ? suggestionList[index].adSoyad.substring(
                                  suggestionList[index]
                                      .adSoyad
                                      .toLowerCase()
                                      .indexOf(query.toLowerCase()),
                                  suggestionList[index]
                                          .adSoyad
                                          .toLowerCase()
                                          .indexOf(query.toLowerCase()) +
                                      query.length)
                              : null,
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
                          text: query.isNotEmpty
                              ? suggestionList[index].adSoyad.substring(
                                  query.length +
                                      suggestionList[index]
                                          .adSoyad
                                          .toLowerCase()
                                          .indexOf(query.toLowerCase()))
                              : null,
                          style: TextStyle(color: Colors.grey))
                    ]),
              ),
              //subtitle: Text(query.isNotEmpty ? suggestionList[index].adSoyad: null),
              trailing: _buildDuzenleButonu(context, index, suggestionList)),
          itemCount: suggestionList?.length ?? 0,
        );
      },
    );
  }

  _buildDuzenleButonu(BuildContext context, int index, suggestionList) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () => Navigator.pushNamed<bool>(
          context, '/personel/' + suggestionList[index].id),
    );
  }
}
