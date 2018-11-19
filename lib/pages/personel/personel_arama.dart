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
  //int _selectedRadio = 0;
  String _secilenBirim = "Birim Seçiniz!";
  //String _secilenBolum = "Bölüm Seçiniz!";

  List<String> popMenu = ['Akademik', 'İdari'];
  List<DropdownMenuItem<String>> _dropDowmMenuItems = [];
  //List<DropdownMenuItem<String>> _dropDowmBolumMenuItems = [];
  String _statusSel;
  
  String _statusBolum;
  bool _birimDegisti = true;

  List<DropdownMenuItem<String>> _getDropDownBolumIlkMenuItems() {
    List<DropdownMenuItem<String>> items = new List();

    items.add(DropdownMenuItem(
      value: '00',
      child: Text("Bölümmmm Seçççç"),
    ));
    return items;
  }

  

  List<DropdownMenuItem<String>> _getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();

    items.add(DropdownMenuItem(
      value: '00',
      child: Text("Birim Seçiniz!"),
    ));

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
    
    
      _statusSel = selectedItem;
      _birimDegisti = true;
      
      print("SELECTED ITEM  :$selectedItem");
      switch (_statusSel) {
        case '00':
          widget.model.setBirimGotur("Birim Seçiniz!");
          break;
        case '01':
          //widget.model.getDropDownBolumMenuItemsBirimden(_secilenBirim, _selectedRadio); 
          widget.model.setBirimGotur("Aksu Mehmet Süreyya Demiraslan Meslek Yüksekokulu Müdürlüğü");
          break;
        case '02':
          //widget.model.getDropDownBolumMenuItemsBirimden(_secilenBirim, _selectedRadio);
          widget.model.setBirimGotur("Atabey Meslek Yüksekokulu Müdürlüğü");          
          break;
        case '03':
          widget.model.setBirimGotur("Bilgi İşlem Daire Başkanlığı");
          break;
        case '04':
          //widget.model.getDropDownBolumMenuItemsBirimden(_secilenBirim, _selectedRadio);
          widget.model.setBirimGotur("Eğirdir Meslek Yüksekokulu Müdürlüğü");
          
          break;
        case '05':
          widget.model.setBirimGotur("Eğirdir Su Ürünleri Fakültesi Dekanlığı");
          break;
        case '06':
          widget.model.setBirimGotur("Eğirdir Turizm Ve Otelcilik Yüksekokulu Müdürlüğü");
          break;
        case '07':
          //widget.model.getDropDownBolumMenuItemsBirimden(_secilenBirim, _selectedRadio);
          widget.model.setBirimGotur("Gelendost Meslek Yüksekokulu Müdürlüğü");
          
          break;
        case '08':
          widget.model.setBirimGotur("Genel Sekreterlik");
          break;
        case '09':
          widget.model.setBirimGotur("Gönen Meslek Yüksekokulu Müdürlüğü");
          break;
        case '10':
          widget.model.setBirimGotur("Isparta Meslek Yüksekokulu Müdürlüğü");
          break;
        case '11':
          widget.model.setBirimGotur("Keçiborlu Meslek Yüksekokulu Müdürlüğü");
          break;
        case '12':
          widget.model.setBirimGotur("Lisansüstü Eğitim Enstitüsü Müdürlüğü");
          break;
        case '13':
          widget.model.setBirimGotur("Orman Fakültesi Dekanlığı");
          break;
        case '14':
          widget.model.setBirimGotur("Personel Daire Başkanlığı");
          break;
        case '15':
          widget.model.setBirimGotur("Senirkent Meslek Yüksekokulu Müdürlüğü");
          break;
        case '16':
          widget.model.setBirimGotur("Sütçüler Prof. Dr. Hasan Gürbüz Meslek Yüksekokulu Müdürlüğü");
          break;
        case '17':
          widget.model.setBirimGotur("Şarkikaraağaç Meslek Yüksekokulu Müdürlüğü");
          break;
        case '18':
          widget.model.setBirimGotur("Şarkikaraağaç Turizm Meslek Yüksekokulu Müdürlüğü");
          break;
        case '19':
          widget.model.setBirimGotur("Tarım Bilimleri Ve Teknolojileri Fakültesi Dekanlığı");
          break;
        case '20':
          widget.model.setBirimGotur("Teknik Bilimler Meslek Yüksekokulu Müdürlüğü");
          break;
        case '21':
          widget.model.setBirimGotur("Teknoloji Fakültesi Dekanlığı");
          break;
        case '22':
          widget.model.setBirimGotur("Uluborlu Selahattin Karasoy Meslek Yüksekokulu Müdürlüğü");
          break;
        case '23':
          widget.model.setBirimGotur("Uzaktan Eğitim Meslek Yüksekokulu Müdürlüğü");
          break;
        case '24':
          widget.model.setBirimGotur("Yalvaç Büyükkutlu Uygulamalı Bilimler Yüksekokulu Müdürlüğü");
          break;
        case '25':
          widget.model.setBirimGotur("Yalvaç Meslek Yüksekokulu Müdürlüğü");
          break;
        case '26':
          widget.model.setBirimGotur("Yalvaç Teknik Bilimler Meslek Yüksekokulu Müdürlüğü");
          break;
        case '27':
          widget.model.setBirimGotur("Yenişarbademli Meslek Yüksekokulu Müdürlüğü");
          break;
        default:
          widget.model.setBirimGotur("Isparta Meslek Yüksekokulu Müdürlüğü");
      }
      //_statusBolum="Bölüm Seçiniz!";
    
    
    widget.model.setBolumGotur("Tüm Bölümler");
    
    widget.model.getDropDownBolumMenuItemsBirimden(widget.model.getBirimGetir, widget.model.getSecilenRadioGetir);
    //widget.model.setBolumGotur("Bölüm Seçiniz!");

  }

  void changedBolumDropDownItem(String selectedItem) {
    widget.model.setBolumGotur(selectedItem);
    debugPrint("SECİLEN BOLUM *********************---------------");
    debugPrint(selectedItem);
    
  }

  @override
  initState() {
    widget.model.fetchPersonellerDjango();
    _dropDowmMenuItems = _getDropDownMenuItems();
    //_dropDowmBolumMenuItems = widget.model.gelsinBolumItemler;
    _statusSel = _dropDowmMenuItems[0].value;
    //_secilenBolum = _dropDowmBolumMenuItems[0].value;
    super.initState();
  }


  Widget myBody() {
    try {
      return ScopedModelDescendant(
          builder: (BuildContext context, Widget child, MainModel model) {
           
        final List<Personel> filtrePersonelList =
            model.allPersoneller.where((p) {
          if (widget.model.getSecilenRadioGetir == 1) {
            return p.birim == widget.model.getBirimGetir && p.bolum == null;
          } 
          else if(model.getBolumGetir != "Bölüm Seçiniz!" && model.getBolumGetir != "Tüm Bölümler") {
            return p.birim == widget.model.getBirimGetir && p.bolum == model.getBolumGetir;
          }
          else {
            //_birimDegisti = false;         
            //debugPrint(_secilenBolum);   
            return p.birim == widget.model.getBirimGetir && p.bolum != null;
          }
        }).toList();    
        try {
          // widget.model.getDropDownBolumMenuItems(filtrePersonelBirimList);  
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
                        FadeInImage(
                          image: NetworkImage(
                              "http://isparta.edu.tr/foto.aspx?sicil_no=${filtrePersonelList[index].sicil}"),
                          height: 200.0,
                          fit: BoxFit.cover,
                          placeholder: AssetImage('assets/staff-default.png'),
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
                        )
                      ],
                    ),
                  ),
                ),
          );
        } catch (e) {
          print(e.toString());
        }
        
      });
    } catch (e) {
      print("HATA BUDUR----------------------------------------*********");
      print(e.toString());
    }
  }

  void changeItemType(
    _RadioGroup type,
  ) {
    
    widget.model.toogleAkademikIdari();
    print(widget.model.displayedAkamikIdari.toString());
    widget.model.setRadioGotur(widget.model.displayedAkamikIdari == false
        ? _RadioGroup.foo1
        : _RadioGroup.foo2);
    
  }

  void showDemoDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      child: child,
    );
  }

  void onChangedRadio(int value) {
    
    widget.model.setSecilenRadioGotur(value);
    print("RADIO DEGISTIRILDI: $value");
    
  }

  List<Widget> makeRadios() {
    List<Widget> list = new List<Widget>();

    list.add(Row(
      children: <Widget>[
        Radio(
            value: 0,
            groupValue: widget.model.getSecilenRadioGetir,
            onChanged: (int value) => onChangedRadio(value)),
        Text('Akademik')
      ],
    ));
    list.add(Row(
      children: <Widget>[
        Radio(
            value: 1,
            groupValue: widget.model.getSecilenRadioGetir,
            onChanged: (int value) => onChangedRadio(value)),
        Text('İdari')
      ],
    ));

    return list;
  }

  void _select(String choice) {
    if (choice == popMenu[0]) {
      debugPrint('Akademik secildi');
      
        widget.model.setSecilenRadioGotur(0);
      
    } else if (choice == popMenu[1]) {
      debugPrint('İdari seçildi');
      
        widget.model.setSecilenRadioGotur(1);
      
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
    return ScopedModelDescendant(
          builder: (BuildContext context, Widget child, MainModel model) {
    return Scaffold(
      drawer: DrawerCustom(widget.model),
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
            color: Colors.blue.shade200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
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
                widget.model.getBirimGetir != "Birim Seçiniz!"
                    ? SizedBox(
                        height: 60.0,
                        child: Wrap(
                          textDirection: TextDirection.rtl,
                          direction: Axis.horizontal,
                          children: <Widget>[
                            DropdownButton<String>(
                              iconSize: 0.0,
                              isDense: true,
                              hint: Text('Bölüm Seçiniz'),
                              value: model.getBolumGetir,
                              items: _birimDegisti == true ? model.gelsinBolumItemler : _getDropDownBolumIlkMenuItems(),
                              onChanged: changedBolumDropDownItem,
                            )
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          Expanded(
                  child: myBody(),
                )
        ],
      ),
    );
  });}
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
