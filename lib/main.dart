import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/rendering.dart';

import 'package:scoped_model/scoped_model.dart';

import './pages/auth/auth.dart';
import './pages/personel/personeller.dart';
import './pages/students/students.dart';
import './pages/personel/personel_admin.dart';
import './pages/personel/personel.dart';
import './pages/personel/haber.dart';
import './pages/personel/duyuru.dart';
import './pages/personel/personel_arama.dart';

import './pages/obs/obs_giris.dart';

import './pages/haber_duyuru/haberler.dart';
import './pages/haber_duyuru/duyurular.dart';
import './scoped-models/main.dart';
import './models/personel.dart';
import './models/haber.dart';
import './models/duyuru.dart';
import './widgets/helpers/custom_route.dart';
import './shared/adaptive_theme.dart';
import './pages/ana_sayfa.dart';
import './pages/yemekhane.dart';

void main() {
  //debugPaintSizeEnabled = true;
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
        title: "SDÜ UBYS Mobil",
        //debugShowMaterialGrid: true,
        debugShowCheckedModeBanner: false,
        theme: getAdaptiveThemeData(context),
        //home: PersonellerSayfa(),
        routes: {
          '/': (BuildContext context) =>
              AnaSayfa(_model),
          '/ogrenciler': (BuildContext context) =>
              !_isAuthenticated ? AuthPage() : StudentsPage(_model),
          '/admin': (BuildContext context) =>
              !_isAuthenticated ? AuthPage() : PersonelAdminSayfa(_model),
          '/haberler': (BuildContext context) => HaberlerSayfa(_model),
          '/duyurular': (BuildContext context) => DuyurularSayfa(_model),
          '/obs': (BuildContext context) => OBSGirisSayfasi(_model),
          '/personel-arama': (BuildContext context) => PersonelAramaSayfasi(_model),
          '/yemekhane': (BuildContext context) => YemekhaneSayfasi()
        },
        onGenerateRoute: (RouteSettings settings) {
          if (!_isAuthenticated) {
            return MaterialPageRoute<bool>(
                builder: (BuildContext contex) => AuthPage());
          }
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
                builder: (BuildContext contex) =>
                    !_isAuthenticated ? AuthPage() : PersonelSayfa(personel));
          }
          if (pathElements[1] == 'haber') {
            final String haberId = pathElements[2];
            final Haber haber =
                _model.allHaberler.firstWhere((Haber haber) {
              return haber.id == haberId;
            });
            return CustomRoute<bool>(
                builder: (BuildContext contex) => HaberSayfa(haber));
          }
          if (pathElements[1] == 'duyuru') {
            final String duyuruId = pathElements[2];
            final Duyuru duyuru =
                _model.allDuyurular.firstWhere((Duyuru duyuru) {
              return duyuru.id == duyuruId;
            });
            return MaterialPageRoute<bool>(
                builder: (BuildContext contex) => DuyuruSayfa(duyuru));
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => !_isAuthenticated ? AuthPage() : PersonellerSayfa(_model));
        },
      ),
    );
  }
}
