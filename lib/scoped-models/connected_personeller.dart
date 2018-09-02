import 'dart:convert';
import 'dart:async';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/subjects.dart';

import '../models/personel.dart';
import '../models/kullanici.dart';
import '../models/auth.dart';

class ConnectedPersonellerModel extends Model {
  List<Personel> _personeller = [];
  String _selPersonelId;
  Kullanici _authenticatedKullanici;
  bool _isYukleme = false;
}

class PersonellerModel extends ConnectedPersonellerModel {
  bool _gosterFavorites = false;

  List<Personel> get allPersoneller {
    return List.from(_personeller);
  }

  List<Personel> get displayedPersoneller {
    if (_gosterFavorites) {
      return _personeller
          .where((Personel personel) => personel.isFavorite)
          .toList();
    }
    return List.from(_personeller);
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
            isFavorite: personelData['wishlistUsers'] == null ? false: (personelData['wishlistUsers'] as Map<String, dynamic>)
                .containsKey(_authenticatedKullanici.id));
        fetchedPersonelList.add(personel);
      });
      _personeller = onlyForUser ? fetchedPersonelList.where((Personel personel) {
        return personel.userId == _authenticatedKullanici.id;
      }).toList() : fetchedPersonelList;
      _isYukleme = false;
      notifyListeners();
      _selPersonelId = null;
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
      response = await http.post('https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyC9HZLbyM32OcWy1CCymy7vFyBkyIByQ4o',
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

  void otomatikAuthenticate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
    final String expiryTimeString = prefs.getString('expiryTime');
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
      final int tokenLifespan = parsedExpiryTime.difference(now).inSeconds;
      _authenticatedKullanici =
          Kullanici(id: userId, email: userEmail, token: token);
      _kullaniciSubject.add(true);
      ayarlaAuthTimeout(tokenLifespan);
      notifyListeners();
    }
  }

  void cikisYap() async {
    _authenticatedKullanici = null;
    _authTimer.cancel();
    _kullaniciSubject.add(false);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('userEmail');
    prefs.remove('userId');
  }

  void ayarlaAuthTimeout(int time) {
    _authTimer = Timer(Duration(seconds: time), cikisYap);
  }
}

class YardimciModel extends ConnectedPersonellerModel {
  bool get isYukleme {
    return _isYukleme;
  }
}
