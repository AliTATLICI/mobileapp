import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/subjects.dart';

import '../shared/global_config.dart';

import '../models/personel.dart';
import '../models/personel_arama.dart';
import '../models/student.dart';
import '../models/haber_duyuru.dart';
import '../models/kullanici.dart';
import '../models/auth.dart';
import '../models/eczane.dart';
import '../models/yemek.dart';
import '../models/kisayol.dart';

enum _RadioGroup { foo1, foo2 }

class ConnectedPersonellerModel extends Model {
  List<Personel> _personeller = [];
  List<PersonelArama> _personellerArama = [];
  List<Student> _students = [];
  List<HaberDuyuru> _haberler = [];
  List<HaberDuyuru> _duyurular = [];
  List<Eczane> _eczaneler = [];
  List<Yemek> _yemekler = [];
  List<KisaYol> _kisayollar = <KisaYol>[
    KisaYol(no: 0, baslik: "Profil", page: "profil", icon: Icons.perm_identity),
    KisaYol(no: 1, baslik: "ISUBÜ", page: "web_anasayfa", icon: Icons.home),
    KisaYol(no: 2, baslik: "Duyurular", page: "duyurular", icon: Icons.announcement),
    KisaYol(no: 3, baslik: "Haberler", page: "haberler", icon: Icons.info_outline),
    KisaYol(no: 4, baslik: "Yemekhane", page: "yemek", icon: Icons.restaurant_menu),
    KisaYol(no: 5, baslik: "Personel Arama", page: "personel-arama", icon: Icons.person_pin_circle),
    KisaYol(no: 6, baslik: "Öğrenci Arama", page: "ogrenci-arama", icon: Icons.school),
    KisaYol(no: 7, baslik: "Akademik Takvim", page: "akademik-takvim", icon: Icons.calendar_today),
    KisaYol(no: 8, baslik: "Eczane", page: "eczane", icon: Icons.explicit),
    KisaYol(no: 9, baslik: "Kısayol Ekle", page: "kisayol", icon: Icons.add_circle_outline)
  ];
  List<String> _kisayolId = ["2", "3", "4", "5", "6", "7", "8"];
  String _selPersonelId;
  String _selStudentId;
  String _selHaberId;
  String _selDuyuruId;
  Kullanici _authenticatedKullanici;
  bool _isYukleme = false;

  String _statusSel;
  String _secilenBirim = "Birim Seçiniz!";
  List<DropdownMenuItem<String>> _dropDowmBirimMenuItems = [];

  List<Personel> bolumFiltre = [];
  List<DropdownMenuItem<String>> _dropDowmBolumMenuItems = [];
  String _secilenBolum = "Bölüm Seçiniz!";

  List<Personel> abdFiltre = [];
  List<DropdownMenuItem<String>> _dropDowmABDMenuItems = [];
  String _secilenABD = "ABD Seçiniz!";

  _RadioGroup _itemType = _RadioGroup.foo1;
  int _selectedRadio = 0;
  
}

class PersonellerModel extends ConnectedPersonellerModel {
  bool _gosterFavorites = false;
  bool _gosterAkademikIdari = false;

  String get getBirimIDGetir{
    return _statusSel;
  }

  void setBirimIdGotur(gelenBirimID){
    _statusSel = gelenBirimID;
  }

  int get getSecilenRadioGetir{
    return _selectedRadio;
  }

  void setSecilenRadioGotur(gelenRadio){
    _selectedRadio = gelenRadio;
  }

  _RadioGroup get getRadioGetir{
    return _itemType;
  }

  void setRadioGotur(gelenRadio){
    _itemType = gelenRadio;
  }

  String get getBirimGetir{
    return _secilenBirim;
  }

  void setBirimGotur(gelenBirim){
    _secilenBirim = gelenBirim;
  }

  String get getBolumGetir{
    return _secilenBolum;
  }

  void setBolumGotur(gelenBolum){
    _secilenBolum = gelenBolum;
  }

  String get getABDGetir{
    return _secilenABD;
  }

  void setABDGotur(gelenABD){
    _secilenABD = gelenABD;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
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

    _dropDowmBirimMenuItems = items;
    notifyListeners();
  }

  

  List<DropdownMenuItem<String>> getDropDownBolumMenuItemsBirimden(String birim, int gelenRadio) {
    List<DropdownMenuItem<String>> items = new List();
    List<String> bolumler =[];
    final List<Personel> filtrePersonelBirimList =
            allPersoneller.where((p) {
          if (gelenRadio == 1) {
            return p.birim == birim && p.bolum == null;
          } 
          else {         
            //debugPrint(_secilenBolum);   
            return p.birim == birim && p.bolum != null;
          }
        }).toList(); 

    items.add(DropdownMenuItem(
      value: "Tüm Bölümler",
      child: Container(
        width: 350.0,
        child: Text("Tüm Bölümler", softWrap: true, style: TextStyle(fontWeight: FontWeight.bold),)),
    ));
    for(var i=0; i<filtrePersonelBirimList.length; i++){
      if(bolumler.indexOf(filtrePersonelBirimList[i].bolum) == -1){
        items.add(DropdownMenuItem(
      value: filtrePersonelBirimList[i].bolum,
      child: Container(
        width: 350.0,
        child: Text(filtrePersonelBirimList[i].bolum, softWrap: true,)),
    ));
    //debugPrint(personel[i].bolum.toString());
    bolumler.add(filtrePersonelBirimList[i].bolum);
      }      
    
    }
    _dropDowmBolumMenuItems = items;
    notifyListeners();
  }

  List<DropdownMenuItem<String>> getDropDownABDMenuItemsBolumden(String birim, String bolum, int gelenRadio) {
    List<DropdownMenuItem<String>> items = new List();
    List<String> bolumler =[];
    final List<Personel> filtrePersonelBirimList =
            allPersoneller.where((p) {
          if (gelenRadio == 1) {
            return p.birim == birim && p.bolum == null;
          } 
          else {         
            //debugPrint(_secilenBolum);   
            return p.birim == birim && p.bolum == bolum;
          }
        }).toList(); 

    items.add(DropdownMenuItem(
      value: "Tüm Programlar",
      child: Container(
        width: 350.0,
        child: Text("Tüm Programlar", softWrap: true, style: TextStyle(fontWeight: FontWeight.bold),)),
    ));
    for(var i=0; i<filtrePersonelBirimList.length; i++){
      if(bolumler.indexOf(filtrePersonelBirimList[i].abd) == -1){
        items.add(DropdownMenuItem(
      value: filtrePersonelBirimList[i].abd,
      child: Container(
        width: 350.0,
        child: Text(filtrePersonelBirimList[i].abd, softWrap: true,)),
    ));
    //debugPrint(personel[i].bolum.toString());
    bolumler.add(filtrePersonelBirimList[i].abd);
      }      
    
    }
    _dropDowmABDMenuItems = items;
    notifyListeners();
  }

  List<DropdownMenuItem<String>> get gelsinABDItemler{
    notifyListeners();
    return List.from(_dropDowmABDMenuItems);

  }

  List<DropdownMenuItem<String>> get gelsinBirimItemler{
    notifyListeners();
    return List.from(_dropDowmBirimMenuItems);

  }

  List<DropdownMenuItem<String>> get gelsinBolumItemler{
    notifyListeners();
    return List.from(_dropDowmBolumMenuItems);

  }

  List<Personel> get allPersoneller {
    return List.from(_personeller);
  }

  List<PersonelArama> get allPersonellerArama {
    return List.from(_personellerArama);
  }

  List<HaberDuyuru> get allHaberler {
    return List.from(_haberler);
  }

  List<HaberDuyuru> get allDuyurular {
    return List.from(_duyurular);
  }

  List<Eczane> get allEczaneler {
    return List.from(_eczaneler);
  }

  List<Yemek> get allYemekler {
    return List.from(_yemekler);
  }

  List<Personel> get displayedPersoneller {
    if (_gosterFavorites) {
      return _personeller
          .where((Personel personel) => personel.isFavorite)
          .toList();
    }
    return List.from(_personeller);
  }

  List<HaberDuyuru> get displayedHaberler {
    return List.from(_haberler);
  }

  List<HaberDuyuru> get displayedDuyurular {
    return List.from(_duyurular);
  }

  List<Eczane> get displayedEczaneler {
    return List.from(_eczaneler);
  }

  int get selectedPersonelIndex {
    return _personeller.indexWhere((Personel personel) {
      return personel.id == _selPersonelId;
    });
  }

  String get selectedPersonelId {
    return _selPersonelId;
  }

  Personel get selectedPersonel {
    if (selectedPersonelId == null) {
      return null;
    }
    return _personeller.firstWhere((Personel personel) {
      return personel.id == _selPersonelId;
    });
  }

  bool get displayedFavoriteOnly {
    return _gosterFavorites;
  }

  bool get displayedAkamikIdari {
    return _gosterAkademikIdari;
  }

  Future<bool> eklePersonel(String adSoyad, String sicil, String eposta,
      String bolum, String cep) async {
    _isYukleme = true;
    notifyListeners();
    final Map<String, dynamic> personelData = {
      'adSoyad': adSoyad,
      'sicil': sicil,
      'eposta': eposta,
      'bolum': bolum,
      'cep': cep,
      'userEmail': _authenticatedKullanici.email,
      'userId': _authenticatedKullanici.id
    };
    try {
      final http.Response response = await http.post(
          'https://sdu-egitim-2018.firebaseio.com/personel.json?auth=${_authenticatedKullanici.token}',
          body: json.encode(personelData));

      if (response.statusCode != 200 && response.statusCode != 201) {
        _isYukleme = false;
        notifyListeners();
        return false;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      //print(responseData);
      final Personel newPersonel = Personel(
          id: responseData['name'],
          adSoyad: adSoyad,
          sicil: sicil,
          eposta: eposta,
          bolum: bolum,
          cep: cep,
          userEmail: _authenticatedKullanici.email,
          userId: _authenticatedKullanici.id);
      _personeller.add(newPersonel);
      _isYukleme = false;
      notifyListeners();
      return true;
    } catch (error) {
      _isYukleme = false;
      notifyListeners();
      return false;
    }
    // .catchError((error) {
    //   _isYukleme = false;
    //   notifyListeners();
    //   return false;
    // });
  }

  ///Bolum 11 Ders 162 hata düzeltmesi Maps uygulamasında düzeltilecek
  // void selectPersonel(String personelId) {
  //   selPersonelIndex = personelId;
  //   notifyListeners();
  // }

  Future<bool> guncellePersonel(
      String adSoyad, String sicil, String eposta, String bolum, String cep) {
    _isYukleme = true;
    notifyListeners();
    final Map<String, dynamic> updateData = {
      'adSoyad': adSoyad,
      'sicil': sicil,
      'eposta': eposta,
      'bolum': bolum,
      'cep': cep,
      'userEmail': selectedPersonel.userEmail,
      'userId': selectedPersonel.userId
    };
    return http
        .put(
            'https://sdu-egitim-2018.firebaseio.com/personel/${selectedPersonel.id}.json?auth=${_authenticatedKullanici.token}',
            body: json.encode(updateData))
        .then((http.Response response) {
      _isYukleme = false;
      final Personel uptatedPersonel = Personel(
          id: selectedPersonel.id,
          adSoyad: adSoyad,
          sicil: sicil,
          eposta: eposta,
          bolum: bolum,
          cep: cep,
          userEmail: selectedPersonel.userEmail,
          userId: selectedPersonel.userId);
      final int selectedPersonelIndex =
          _personeller.indexWhere((Personel personel) {
        return personel.id == _selPersonelId;
      });
      _personeller[selectedPersonelIndex] = uptatedPersonel;
      notifyListeners();
      return true;
    }).catchError((error) {
      _isYukleme = false;
      notifyListeners();
      return false;
    });
  }

  Future<bool> silPersonel() {
    _isYukleme = true;
    final deletedPersonelId = selectedPersonel.id;
    _personeller.removeAt(selectedPersonelIndex);
    _selPersonelId = null;
    notifyListeners();
    return http
        .delete(
            'https://sdu-egitim-2018.firebaseio.com/personel/${deletedPersonelId}.json?auth=${_authenticatedKullanici.token}')
        .then((http.Response response) {
      _isYukleme = false;
      notifyListeners();
      return true;
    }).catchError((error) {
      _isYukleme = false;
      notifyListeners();
      return false;
    });
  }

  Future<Null> fetchPersoneller({onlyForUser = false}) {
    _isYukleme = true;
    notifyListeners();
    return http
        .get(
            'https://sdu-egitim-2018.firebaseio.com/personel.json?auth=${_authenticatedKullanici.token}')
        .then<Null>((http.Response response) {
      print(json.decode(response.body));
      final List<Personel> fetchedPersonelList = [];
      final Map<String, dynamic> personelListData = json.decode(response.body);
      if (personelListData == null) {
        _isYukleme = false;
        notifyListeners();
        return;
      }
      personelListData.forEach((String personelId, dynamic personelData) {
        final Personel personel = Personel(
            id: personelId,
            adSoyad: personelData['adSoyad'],
            sicil: personelData['sicil'],
            eposta: personelData['eposta'],
            bolum: personelData['bolum'],
            cep: personelData['cep'],
            userEmail: personelData['userEmail'],
            userId: personelData['userId'],
            isFavorite: personelData['wishlistUsers'] == null
                ? false
                : (personelData['wishlistUsers'] as Map<String, dynamic>)
                    .containsKey(_authenticatedKullanici.id));
        fetchedPersonelList.add(personel);
      });
      _personeller = onlyForUser
          ? fetchedPersonelList.where((Personel personel) {
              return personel.userId == _authenticatedKullanici.id;
            }).toList()
          : fetchedPersonelList;
      _isYukleme = false;
      notifyListeners();
      _selPersonelId = null;
    }).catchError((error) {
      _isYukleme = false;
      notifyListeners();
      return;
    });
  }

  Future<Null> fetchPersonellerDjango({onlyForUser = false}) {
    print("fetchPersonelDJANGO metodun içine GİRDİ");
    _isYukleme = true;
    notifyListeners();
    return http
        .get(
      apiWebIp + '/pbs/personeller/',
    )
        .then<Null>((http.Response response) {
      //print(json.decode(response.body));
      final List<Personel> fetchedPersonelList = [];
      final Map<String, dynamic> personelListData =
          json.decode(utf8.decode(response.bodyBytes));
      if (personelListData == null) {
        _isYukleme = false;
        notifyListeners();
        return;
      }
      //print("PERSONELLISTDATA:" + personelListData["results"].toString());
      personelListData["results"].forEach((dynamic personelData) {
        //print("PERSONELDATA-FOREACH-----------------------" + personelData['adi_soyadi']);
        final Personel personel = Personel(
            id: personelData['sicil'],
            adSoyad: personelData['adi_soyadi'],
            sicil: personelData['sicil'],
            eposta: personelData['e_posta'],
            bolum: personelData['bolum'],
            cep: personelData['telefon'],
            birim: personelData['birim'],
            abd: personelData['ana_bilim_dali'],
            userEmail: personelData['sicil'],
            userId: personelData['sicil'],
            isFavorite: personelData['wishlistUsers'] == null
                ? false
                : (personelData['wishlistUsers'] as Map<String, dynamic>)
                    .containsKey(_authenticatedKullanici.id));
        //print("personelTOSTRING-" + personel.toString());
        fetchedPersonelList.add(personel);
      });
      _personeller = onlyForUser
          ? fetchedPersonelList.where((Personel personel) {
              return personel.userId == _authenticatedKullanici.id;
            }).toList()
          : fetchedPersonelList;
      //print("TUM PERSONELLER--------**********-------");
      //print(_personeller.length.toString());
      _isYukleme = false;
      notifyListeners();
      _selPersonelId = null;
    }).catchError((error) {
      _isYukleme = false;
      notifyListeners();
      return;
    });
  }

  Future<Null> fetchPersonellerArama({onlyForUser = false}) {
    print("fetchPersonelARAMA-DJANGO metodun içine GİRDİ");
    _isYukleme = true;
    notifyListeners();
    return http
        .get(apiWebIp + '/pbs/personeller/')
        .then<Null>((http.Response response) {
      //print(json.decode(response.body));
      final List<PersonelArama> fetchedPersonelList = [];
      final Map<String, dynamic> personelListData =
          json.decode(utf8.decode(response.bodyBytes));
      if (personelListData == null) {
        _isYukleme = false;
        notifyListeners();
        return;
      }
      //print("PERSONELLISTDATA:" + personelListData["results"].toString());
      personelListData["results"].forEach((dynamic personelData) {
        //print("PERSONELDATA-FOREACH-----------------------" + personelData['adi_soyadi']);
        final PersonelArama personel = PersonelArama(
            id: personelData['id'],
            adSoyad: personelData['adi_soyadi'],
            sicil: personelData['sicil']);
        //print("personelTOSTRING-" + personel.toString());
        fetchedPersonelList.add(personel);
      });
      _personellerArama = fetchedPersonelList;
      //print("TUM PERSONELLER SAYISI--------**********-------");
      //print(_personeller.length.toString());
      _isYukleme = false;
      notifyListeners();
      _selPersonelId = null;
    }).catchError((error) {
      _isYukleme = false;
      notifyListeners();
      return;
    });
  }

  Future<Null> fetchHaberlerDjango({onlyForUser = false}) {
    print("fetchHaberDJANGO metodun içine GİRDİ");
    _isYukleme = true;
    notifyListeners();
    return http
        .get(
      apiWebIp + '/haber/haberler/',
    )
        .then<Null>((http.Response response) {
      print(json.decode(response.body));
      final List<HaberDuyuru> fetchedHaberList = [];
      final Map<String, dynamic> haberListData =
          json.decode(utf8.decode(response.bodyBytes));
      if (haberListData == null) {
        _isYukleme = false;
        notifyListeners();
        return;
      }
      //print("HABERLISTDATA:" + haberListData["results"].toString());
      haberListData["results"].forEach((dynamic haberData) {
        //print("HABERDATA-FOREACH-----------------------" + haberData['id']);
        final HaberDuyuru haber = HaberDuyuru(
            id: haberData['id'].toString(),
            numarasi: haberData['numarasi'],
            baslik: haberData['baslik'],
            createdDate: haberData['created_date'],
            okunma: haberData['okunma'],
            icerik: haberData['icerik']);
        //print("haberTOSTRING-" + haber.toString());
        fetchedHaberList.add(haber);
      });
      _haberler = fetchedHaberList;
      _isYukleme = false;
      notifyListeners();
      _selHaberId = null;
    }).catchError((error) {
      _isYukleme = false;
      notifyListeners();
      return;
    });
  }

  Future<Null> fetchDuyurularDjango({onlyForUser = false}) {
    print("fetchDuyurularDJANGO metodun içine GİRDİ");
    _isYukleme = true;
    notifyListeners();
    return http
        .get(
      apiWebIp + '/haber/duyurular/',
    )
        .then<Null>((http.Response response) {
      print(json.decode(response.body));
      final List<HaberDuyuru> fetchedDuyuruList = [];
      final Map<String, dynamic> duyuruListData =
          json.decode(utf8.decode(response.bodyBytes));
      if (duyuruListData == null) {
        _isYukleme = false;
        notifyListeners();
        return;
      }
      print("HABERLISTDATA:" + duyuruListData["results"].toString());
      duyuruListData["results"].forEach((dynamic duyuruData) {
        //print("HABERDATA-FOREACH-----------------------" + haberData['id']);
        final HaberDuyuru duyuru = HaberDuyuru(
            id: duyuruData['id'].toString(),
            numarasi: duyuruData['numarasi'],
            baslik: duyuruData['baslik'],
            createdDate: duyuruData['created_date'],
            okunma: duyuruData['okunma'],
            icerik: duyuruData['icerik']);
        //print("haberTOSTRING-" + haber.toString());
        fetchedDuyuruList.add(duyuru);
      });
      _duyurular = fetchedDuyuruList;
      _isYukleme = false;
      notifyListeners();
      _selHaberId = null;
    }).catchError((error) {
      _isYukleme = false;
      notifyListeners();
      return;
    });
  }

  Future<Null> fetchEczaneler({onlyForUser = false}) {
    print("fetchEczane metodun içine girildi");
    _isYukleme = true;
    notifyListeners();
    return http
        .get(
      apiWebIp + '/haber/eczaneler/',
    )
        .then<Null>((http.Response response) {
      print(json.decode(response.body));
      final List<Eczane> fetchedEczaneList = [];
      final Map<String, dynamic> eczaneListData =
          json.decode(utf8.decode(response.bodyBytes));
      if (eczaneListData == null) {
        _isYukleme = false;
        notifyListeners();
        return;
      }
      //print("HABERLISTDATA:" + haberListData["results"].toString());
      eczaneListData["results"].forEach((dynamic eczaneData) {
        //print("HABERDATA-FOREACH-----------------------" + haberData['id']);
        final Eczane eczane = Eczane(
            adi: eczaneData['adi'],
            semt: eczaneData['semt'],
            telefon: eczaneData['telefon'],
            adres: eczaneData['adres']);
        //print("haberTOSTRING-" + haber.toString());
        fetchedEczaneList.add(eczane);
      });
      _eczaneler = fetchedEczaneList;
      print("***************---------------------__ECZANELER***********");
      print(_eczaneler);
      _isYukleme = false;
      notifyListeners();
      //_selHaberId = null;
    }).catchError((error) {
      _isYukleme = false;
      notifyListeners();
      return;
    });
  }

  Future<Null> fetchYemekler({onlyForUser = false}) {
    print("fetchYemeklerMetodu metodun içine girildi");
    _isYukleme = true;
    notifyListeners();
    return http
        .get(
      apiWebIp + '/haber/yemekler/',
    )
        .then<Null>((http.Response response) {
      print(json.decode(response.body));
      final List<Yemek> fetchedYemekList = [];
      final Map<String, dynamic> yemekListData =
          json.decode(utf8.decode(response.bodyBytes));
      if (yemekListData == null) {
        _isYukleme = false;
        notifyListeners();
        return;
      }
      yemekListData["results"].forEach((dynamic yemekData) {
        //print("HABERDATA-FOREACH-----------------------" + haberData['id']);
        final Yemek yemek = Yemek(
            tarih: yemekData['tarih'],
            gun: yemekData['gun'],
            menu: yemekData['menu'],
            kalori: yemekData['kalori']);
        //print("haberTOSTRING-" + haber.toString());
        fetchedYemekList.add(yemek);
      });
      _yemekler = fetchedYemekList;
      _isYukleme = false;
      notifyListeners();
      //_selHaberId = null;
    }).catchError((error) {
      _isYukleme = false;
      notifyListeners();
      return;
    });
  }

  void togglePersonelFavoriteStatus() async {
    final bool isCurrentlyFavorite = selectedPersonel.isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;
    final Personel guncellePersonel = Personel(
        id: selectedPersonel.id,
        adSoyad: selectedPersonel.adSoyad,
        sicil: selectedPersonel.sicil,
        eposta: selectedPersonel.eposta,
        bolum: selectedPersonel.bolum,
        cep: selectedPersonel.cep,
        userEmail: selectedPersonel.userEmail,
        userId: selectedPersonel.userId,
        isFavorite: newFavoriteStatus);
    _personeller[selectedPersonelIndex] = guncellePersonel;
    notifyListeners();
    http.Response response;
    if (newFavoriteStatus) {
      response = await http.put(
          'https://sdu-egitim-2018.firebaseio.com/personel/${selectedPersonel.id}/wishlistUsers/${_authenticatedKullanici.id}.json?auth=${_authenticatedKullanici.token}',
          body: json.encode(true));
    } else {
      response = await http.delete(
          'https://sdu-egitim-2018.firebaseio.com/personel/${selectedPersonel.id}/wishlistUsers/${_authenticatedKullanici.id}.json?auth=${_authenticatedKullanici.token}');
    }
    if (response.statusCode != 200 && response.statusCode != 201) {
      final Personel guncellePersonel = Personel(
          id: selectedPersonel.id,
          adSoyad: selectedPersonel.adSoyad,
          sicil: selectedPersonel.sicil,
          eposta: selectedPersonel.eposta,
          bolum: selectedPersonel.bolum,
          cep: selectedPersonel.cep,
          userEmail: selectedPersonel.userEmail,
          userId: selectedPersonel.userId,
          isFavorite: newFavoriteStatus);
      _personeller[selectedPersonelIndex] = guncellePersonel;
      notifyListeners();
    }
  }

  void selectPersonel(String personelId) {
    _selPersonelId = personelId;
    notifyListeners();
  }

  void toogleGoruntuMode() {
    _gosterFavorites = !_gosterFavorites;
    notifyListeners();
  }

  void toogleAkademikIdari() {
    _gosterAkademikIdari = !_gosterAkademikIdari;
    notifyListeners();
  }
}

class KullaniciModel extends ConnectedPersonellerModel {
  Timer _authTimer;
  PublishSubject<bool> _kullaniciSubject = PublishSubject();

  Kullanici get kullanici {
    return _authenticatedKullanici;
  }

  PublishSubject<bool> get kullaniciSubject {
    return _kullaniciSubject;
  }

  Future<Map<String, dynamic>> kimlikdogrulama(String email, String password,
      [AuthMode mode = AuthMode.Login]) async {
    _isYukleme = true;
    notifyListeners();
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    http.Response response;
    if (mode == AuthMode.Login) {
      response = await http.post(
          'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyC9HZLbyM32OcWy1CCymy7vFyBkyIByQ4o',
          body: json.encode(authData),
          headers: {'Content-Type': 'application/json'});
    } else {
      response = await http.post(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AIzaSyC9HZLbyM32OcWy1CCymy7vFyBkyIByQ4o',
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'},
      );
    }

    final Map<String, dynamic> responseData = json.decode(response.body);
    bool hasError = true;
    String message = 'Bir şeyler yanlış!';
    //print('GELEN TIME BUDUR:' + responseData['expiresIn']);
    //print(responseData);
    if (responseData.containsKey('idToken')) {
      hasError = false;
      message = 'Authentication succeeded!';
      _authenticatedKullanici = Kullanici(
          id: responseData['localId'],
          email: email,
          token: responseData['idToken']);
      ayarlaAuthTimeout(int.parse(responseData['expiresIn']));
      _kullaniciSubject.add(true);
      final DateTime now = DateTime.now();
      final DateTime expiryTime =
          now.add(Duration(seconds: int.parse(responseData['expiresIn'])));
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', responseData['idToken']);
      prefs.setString('userEmail', email);
      prefs.setString('userId', responseData['localId']);
      prefs.setString('expiryTime', expiryTime.toIso8601String());
    } else if (responseData['error']['message'] == 'EMAIL_EXISTS') {
      message = 'Bu eposta kayıtlı! Başka bir eposta giriniz.';
    } else if (responseData['error']['message'] == 'EMAIL_NOT_FOUND') {
      message = 'Bu eposta kayıtlı değil!';
    } else if (responseData['error']['message'] == 'INVALID_PASSWORD') {
      message = 'Parola geçerli değil!';
    }
    print('YUKLEME FALSE YAPAMADI');
    _isYukleme = false;
    print('YUKLEME FALSE YAPTI!!!!!!!');
    notifyListeners();
    return {'success': !hasError, 'message': message};
  }

  Future<Map<String, dynamic>> kimlikdogrulamaDjango(
      String username, String password,
      [AuthMode mode = AuthMode.Login]) async {
    _isYukleme = true;
    notifyListeners();
    final Map<String, dynamic> authData = {
      'username': username,
      'password': password,
      'returnSecureToken': true
    };
    http.Response response;
    if (mode == AuthMode.Login) {
      response = await http.post('${apiWebIp}/pbs/api/login',
          body: {'username': username, 'password': password},
          headers: {'Content-Type': 'application/x-www-form-urlencoded'});
    } else {}

    final Map<String, dynamic> responseData = json.decode(utf8.decode(response.bodyBytes));
    bool hasError = true;
    String message = 'Bir şeyler yanlış!';
    //print('GELEN TIME BUDUR:' + responseData['expiresIn']);
    print('GELEN RESPONSE DATA BUDUR' + responseData.toString());
    if (responseData.containsKey('token')) {
      hasError = false;
      message = 'Authentication succeeded!';
      _authenticatedKullanici = Kullanici(
          id: responseData['localId'].toString(),
          email: responseData['email'],
          token: responseData['token'],
          username: responseData['username'],
          firstName: responseData['first_name'],
          lastName: responseData['last_name']
          );
      ayarlaAuthTimeout(int.parse(responseData['expireIn']));
      _kullaniciSubject.add(true);
      final DateTime now = DateTime.now();
      final DateTime expiryTime =
          now.add(Duration(seconds: int.parse(responseData['expireIn'])));
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', responseData['token']);
      prefs.setString('userEmail', responseData['email'].toString());
      prefs.setString('userId', responseData['localId'].toString());
      prefs.setString('username', username);
      prefs.setString('firstname', responseData['first_name'].toString());
      prefs.setString('lastname', responseData['last_name'].toString());
      prefs.setString('expiryTime', expiryTime.toIso8601String());
    } else if (responseData['error'] == 'EMAIL_EXISTS') {
      message = 'Bu eposta kayıtlı! Başka bir eposta giriniz.';
    } else if (responseData['error'] == 'The user does not exist') {
      message = 'Bu eposta kayıtlı değil!';
    } else if (responseData['error'] == 'Incorrect password') {
      message = 'Parola geçerli değil!';
    }
    print('YUKLEME FALSE YAPAMADI');
    _isYukleme = false;
    print('YUKLEME FALSE YAPTI!!!!!!!');
    notifyListeners();
    return {'success': !hasError, 'message': message};
  }

  void otomatikAuthenticate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
    final String expiryTimeString = prefs.getString('expiryTime');
    //final KisaYol kisayollar = prefs.getStringList('kisayollar');
    //_kisayollar = kisayollar;
    if (token != null) {
      final DateTime now = DateTime.now();
      final parsedExpiryTime = DateTime.parse(expiryTimeString);
      if (parsedExpiryTime.isBefore(now)) {
        _authenticatedKullanici = null;
        notifyListeners();
        return;
      }
      final String userEmail = prefs.getString('userEmail');
      final String userId = prefs.getString('userId');
      final String username = prefs.getString('username');
      final String firstname = prefs.getString('firstname');
      final String lastname = prefs.getString('lastname');
      final int tokenLifespan = parsedExpiryTime.difference(now).inSeconds;
      _authenticatedKullanici =
          Kullanici(id: userId, email: userEmail, token: token, username: username, firstName: firstname, lastName: lastname);
      _kullaniciSubject.add(true);
      ayarlaAuthTimeout(tokenLifespan);
      notifyListeners();
    }
  }

  void cikisYap() async {
    _authenticatedKullanici = null;
    _authTimer.cancel();
    _kullaniciSubject.add(false);
    _selDuyuruId = null;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('userEmail');
    prefs.remove('userId');
    prefs.remove('username');
    prefs.remove('firstname');
    prefs.remove('lastname');

  }

  void ayarlaAuthTimeout(int time) {
    _authTimer = Timer(Duration(seconds: time), cikisYap);
  }
}

class YardimciModel extends ConnectedPersonellerModel {
  bool get isYukleme {
    return _isYukleme;
  }

  List<KisaYol> get allKisayollar {
    return List.from(_kisayollar);
  }

  List<String> get allKisayolId {
    return List.from(_kisayolId);
  }

  Future<Null> kisayolIdCek() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _kisayolId = prefs.getStringList('kalanKisayollar') == null ? _kisayolId : prefs.getStringList('kalanKisayollar');
  }

  Future<Null> kisayolEkle(int gelenId) async {
    List<String> anasayfaKisayol = ["0", "1", "9"];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> onbellekid = prefs.getStringList('kisayollar') == null ? anasayfaKisayol : prefs.getStringList('kisayollar');
    onbellekid.add(gelenId.toString());
    prefs.setStringList('kisayollar', onbellekid);
    _kisayolId.remove(gelenId.toString());
    prefs.setStringList('kalanKisayollar', _kisayolId);
    
    notifyListeners();
    //kisayolIdCek();
  }

  Future<Null> kisayolSil(int gelenId) async {
    List<String> anasayfaKisayol = ["0", "1", "9"];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> onbellekid = prefs.getStringList('kisayollar') == null ? anasayfaKisayol : prefs.getStringList('kisayollar');
    onbellekid.remove(gelenId.toString());
    prefs.setStringList('kisayollar', onbellekid);
    _kisayolId.add(gelenId.toString());
    prefs.setStringList('kalanKisayollar', _kisayolId);
    notifyListeners();
  }
}

class StudentModel extends ConnectedPersonellerModel {
  List<Student> get allStudents {
    return List.from(_students);
  }

  List<Student> get displayedStudents {
    return List.from(_students);
  }

  int get selectedStudentIndex {
    return _students.indexWhere((Student student) {
      return student.id == _selStudentId;
    });
  }

  String get selectedStudentId {
    return _selStudentId;
  }

  Student get selectedStudent {
    if (selectedStudentId == null) {
      return null;
    }
    return _students.firstWhere((Student student) {
      return student.id == _selStudentId;
    });
  }

  Future<Null> fetchStudents({onlyForUser = false}) {
    _isYukleme = true;
    notifyListeners();
    return http
        .get(
            'https://sdu-egitim-2018.firebaseio.com/students.json?auth=${_authenticatedKullanici.token}')
        .then<Null>((http.Response response) {
      print(json.decode(response.body));
      final List<Student> fetchedStudentList = [];
      final Map<String, dynamic> studentListData = json.decode(response.body);
      if (studentListData == null) {
        _isYukleme = false;
        notifyListeners();
        return;
      }
      print("JSON UZUNLUGU" + studentListData.length.toString());
      studentListData.forEach((String studentId, dynamic studentData) {
        final Student student = Student(
          id: studentId,
          name: studentData['name'],
          certificate: studentData['certificate'],
          phone: studentData['phone'],
          status: studentData['status'],
          statusDate: studentData['statusData'],
          situation: studentData['stuation'],
        );
        fetchedStudentList.add(student);
      });
      _students = fetchedStudentList;
      _isYukleme = false;
      notifyListeners();
      _selStudentId = null;
    }).catchError((error) {
      _isYukleme = false;
      notifyListeners();
      return;
    });
  }

  void selectStudent(String studentId) {
    _selStudentId = studentId;
    notifyListeners();
  }
}
