import 'package:flutter/material.dart';
import 'package:flutter_course/widgets/ui_elements/drop_down_personel_arama.dart';
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

  

  

  void changedDropDownItem(String selectedItem) {
    
    
      widget.model.setBirimIdGotur(selectedItem);
      _birimDegisti = true;
      
      print("SELECTED ITEM  :$selectedItem");
      switch (widget.model.getBirimIDGetir) {
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
    
    widget.model.setBolumGotur("Bölüm Seçiniz!");
    widget.model.setABDGotur("ABD Seçiniz!");
    
  
    //widget.model.setSecilenRadioGotur(0);
    if(widget.model.getSecilenRadioGetir == 0){
      widget.model.setBolumGotur("Tüm Bölümler");
      widget.model.setABDGotur("Tüm Programlar");
      widget.model.setSecilenRadioGotur(0);
      widget.model.getDropDownBolumMenuItemsBirimden(widget.model.getBirimGetir, widget.model.getSecilenRadioGetir);
    }
    else {
      widget.model.setSecilenRadioGotur(1);
      widget.model.getDropDownBolumMenuItemsBirimden(widget.model.getBirimGetir, widget.model.getSecilenRadioGetir);
    }
    //widget.model.setBolumGotur("Bölüm Seçiniz!");

  }

  void changedBolumDropDownItem(String selectedItem) {
    widget.model.setBolumGotur(selectedItem);
    debugPrint("SECİLEN BOLUM *********************---------------");
    debugPrint(selectedItem);

    widget.model.setABDGotur("Tüm Programlar");
    widget.model.getDropDownABDMenuItemsBolumden(widget.model.getBirimGetir, widget.model.getBolumGetir, widget.model.getSecilenRadioGetir);
    
    
  }

  void changedABDDropDownItem(String selectedItem) {
    widget.model.setABDGotur(selectedItem);
    debugPrint("SECİLEN BOLUM *********************---------------");
    debugPrint(selectedItem);
    
  }

  @override
  initState() {
    widget.model.fetchPersonellerDjango();
    //_dropDowmMenuItems = widget.model.gelsinBirimItemler;
    //_dropDowmBolumMenuItems = widget.model.gelsinBolumItemler;
    //widget.model.setBirimIdGotur(widget.model.gelsinBirimItemler[0].value);
    //_secilenBolum = _dropDowmBolumMenuItems[0].value;
    widget.model.getDropDownMenuItems();
    widget.model.setBirimGotur("Birim Seçiniz!");
    widget.model.setBolumGotur("Tüm Bölümler");
    widget.model.setABDGotur("Tüm Programlar");
    super.initState();
  }

  

  Widget myBody() {
    try {
      return ScopedModelDescendant(
          builder: (BuildContext context, Widget child, MainModel model) {
           
        final List<Personel> filtrePersonelList =
            model.allPersoneller.where((p) {
          if (widget.model.getSecilenRadioGetir == 1) {
            return p.birim == widget.model.getBirimGetir && p.abd  == null;
          } 
          else if(model.getABDGetir != "ABD Seçiniz!" && model.getABDGetir != "Tüm Programlar") {
            return p.birim == widget.model.getBirimGetir && p.bolum == model.getBolumGetir && p.abd == model.getABDGetir;
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



  

  void _select(String choice) {
    if (choice == popMenu[0]) {
      debugPrint('Akademik secildi');
      
        widget.model.setSecilenRadioGotur(0);
        widget.model.setBolumGotur("Tüm Bölümler");
        widget.model.setABDGotur("Tüm Programlar");
        //widget.model.setSecilenRadioGotur(0);
         widget.model.getDropDownBolumMenuItemsBirimden(widget.model.getBirimGetir, widget.model.getSecilenRadioGetir);
    
      
    } else if (choice == popMenu[1]) {
      debugPrint('İdari seçildi');
      
        widget.model.setSecilenRadioGotur(1);
        widget.model.setBolumGotur("Tüm Bölümler");
        widget.model.setABDGotur("Tüm Programlar");
        widget.model.getDropDownBolumMenuItemsBirimden(widget.model.getBirimGetir, widget.model.getSecilenRadioGetir);
    
      
      

    } else if (choice == popMenu[2]) {
      debugPrint('3. eleman secildi');
      
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
                        value: widget.model.getBirimIDGetir,
                        items: widget.model.gelsinBirimItemler,
                        onChanged: changedDropDownItem,
                      )
                    ],
                  ),
                ),
                widget.model.getBirimGetir != "Birim Seçiniz!" && widget.model.getSecilenRadioGetir !=1
                    ? SizedBox(
                        height: 50.0,
                        child: Wrap(
                          textDirection: TextDirection.rtl,
                          direction: Axis.horizontal,
                          children: <Widget>[
                            DropdownButton<String>(
                              iconSize: 0.0,
                              isDense: true,
                              hint: Text('Bölüm Seçiniz'),
                              value: model.getBolumGetir,
                              items: model.gelsinBolumItemler,
                              onChanged: changedBolumDropDownItem,
                            )
                          ],
                        ),
                      )
                    : Container(),
                widget.model.getBirimGetir != "Birim Seçiniz!" && widget.model.getBolumGetir != "Tüm Bölümler" && widget.model.getSecilenRadioGetir !=1
                    ? SizedBox(
                        height: 50.0,
                        child: Wrap(
                          textDirection: TextDirection.rtl,
                          direction: Axis.horizontal,
                          children: <Widget>[
                            DropdownButton<String>(
                              iconSize: 0.0,
                              isDense: true,
                              hint: Text('Bölüm Seçiniz'),
                              value: model.getABDGetir,
                              items: model.gelsinABDItemler,
                              onChanged: changedABDDropDownItem,
                            )
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          widget.model.getBirimGetir != "Birim Seçiniz!" ? Expanded(
                  child: myBody(),
                ) : Container(
                  color: Colors.white,
                  child: Center( 
                    child: SizedBox(
                      height: 200.0,
                      child: Padding(
                          padding:
                              EdgeInsets.only(top: 20.0, right: 8.0, left: 8.0),
                          child: Text(
                            "Personel aramak için yukarıdan birim seçebilirsiniz ya da arama kısmından isim veya soyisme göre arama yapabilirsiniz. \n Birim seçtikten sonra akademik ve idari kısmını sağ üst köşeden değiştirebilirsiniz. ",
                            style: TextStyle(fontSize: 16.0),
                            textAlign: TextAlign.center,
                          )),
                    ),
                  ),
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
          color: Colors.blue,
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
      icon: Icon(Icons.perm_contact_calendar),
      onPressed: () => Navigator.pushNamed<bool>(
          context, '/personel/' + suggestionList[index].id),
    );
  }
}