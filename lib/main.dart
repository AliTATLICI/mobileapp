import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_course/pages/webview.dart';
import 'package:intl/intl.dart';
import 'package:map_view/map_view.dart';
// import 'package:flutter/rendering.dart';

import 'package:scoped_model/scoped_model.dart';

import './pages/auth/auth.dart';
import './pages/personel/personeller.dart';
import './pages/personel/personel_admin.dart';
import './pages/personel/personel.dart';
import './pages/haber_duyuru/haber_duyuru.dart';
import './pages/personel/personel_arama.dart';
import './pages/profil/profil.dart';


import './pages/haber_duyuru/haberler.dart';
import './pages/haber_duyuru/duyurular.dart';
import './scoped-models/main.dart';
import './models/personel.dart';
import './models/haber_duyuru.dart';
import './widgets/helpers/custom_route.dart';
import './shared/adaptive_theme.dart';
import './pages/ana_sayfa.dart';
import './pages/ubys.dart';
import './pages/yemekhane.dart';
import './pages/eczane.dart';
import './pages/eczane_map.dart';
import './pages/yemek_listesi.dart';
import './pages/yemek_listesi_aylik.dart';
import './pages/akademik_takvim.dart';

void main() {
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  MapView.setApiKey('AIzaSyCESLdlBDj2ptHMyXAYYGsr_Qm27xtcb1w');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();
  final _platformChannel = MethodChannel('flutter-course.com/battery');
  bool _isAuthenticated = false;
  List<String> _kisayolMenu =[];


  Future<Null> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await _platformChannel.invokeMethod('getBatteryLevel');
      batteryLevel = 'Batarya durumu : %$result';
    }
    catch (error) {
      batteryLevel = 'Batarya durumu bulunamadı';
      print(error);
    }
    print(batteryLevel);
    
  }

  @override
  void initState() {
    _model.otomatikAuthenticate();
    //_model.fetchPersonellerArama();
    _model.kullaniciSubject.listen((bool isAuthenticated) {
      setState(() {
        _isAuthenticated = isAuthenticated;
      });
    });
    _getBatteryLevel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        title: "ISUBÜ Mobil",
        //debugShowMaterialGrid: true,
        debugShowCheckedModeBanner: false,
        theme: getAdaptiveThemeData(context),
        //home: PersonellerSayfa(),
        routes: {
          '/': (BuildContext context) => AnaSayfa(_model),
          '/login': (BuildContext context) => AuthPage(),
          '/ubys': (BuildContext context) => UBYSSayfa(_model),
          '/personeller': (BuildContext context) => PersonellerSayfa(_model),
          '/admin': (BuildContext context) =>
              !_isAuthenticated ? AuthPage() : PersonelAdminSayfa(_model),
          '/haberler': (BuildContext context) => HaberlerSayfa(_model),
          '/duyurular': (BuildContext context) => DuyurularSayfa(_model),
          '/personel-arama': (BuildContext context) => PersonelAramaSayfasi(_model),
          '/yemekhane': (BuildContext context) => YemekhaneSayfasi(DateFormat("dd.MM.yyyy")
                                  .format(DateTime.now()), _model),
          '/yemek' : (BuildContext context) => YemekListesiSayfasi(_model),
          '/yemek-aylik' : (BuildContext context) => YemekListesiAylikSayfasi(_model),
           '/eczane': (BuildContext context) => EczaneSayfasi(_model),
           '/eczane2': (BuildContext context) => EczaneSayfasi2(),
           '/akademik-takvim': (BuildContext context) => AkademikTakvimSayfasi(_model),
           '/web_anasayfa': (BuildContext contex) => WebViewPage(),
           '/profil': (BuildContext contex) => ProfilSayfasi(_model),
        },
        onGenerateRoute: (RouteSettings settings) {
          /*
          if (!_isAuthenticated) {
            return MaterialPageRoute<bool>(
                builder: (BuildContext contex) => AuthPage());
          }
          */
          final List<String> pathElements = settings.name.split('/');
          if (pathElements[0] != '') {
            return null;
          }
          if (pathElements[1] == 'personel') {
            final String personelId = pathElements[2];
            final Personel personel =
                _model.allPersoneller.firstWhere((Personel personel) {
              return personel.id == personelId;
            });
            return MaterialPageRoute<bool>(
                builder: (BuildContext contex) => PersonelSayfa(personel));
          }
          if (pathElements[1] == 'haber') {
            final String haberId = pathElements[2];
            final HaberDuyuru haber =
                _model.allHaberler.firstWhere((HaberDuyuru haber) {
              return haber.id == haberId;
            });
            return CustomRoute<bool>(
                builder: (BuildContext contex) => HaberDuyuruSayfasi(haber, "Haber"));
          }
          if (pathElements[1] == 'duyuru') {
            final String duyuruId = pathElements[2];
            final HaberDuyuru duyuru =
                _model.allDuyurular.firstWhere((HaberDuyuru duyuru) {
              return duyuru.id == duyuruId;
            });
            return MaterialPageRoute<bool>(
                builder: (BuildContext contex) => HaberDuyuruSayfasi(duyuru, "Duyuru"));
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => AnaSayfa(_model));
        },
      ),
    );
  }
}
