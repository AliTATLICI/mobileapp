import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

import 'package:scoped_model/scoped_model.dart';

import './pages/auth/auth.dart';
import './pages/personel/personeller.dart';
import './pages/personel/personel_admin.dart';
import './pages/personel/personel.dart';
import './scoped-models/main.dart';
import './models/personel.dart';

void main() {
  // debugPaintSizeEnabled = true;
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
  bool _isAuthenticated = false;

  @override
  void initState() {
    _model.otomatikAuthenticate();
    _model.kullaniciSubject.listen((bool isAuthenticated) {
      setState(() {
        _isAuthenticated = isAuthenticated;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        //debugShowMaterialGrid: true,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // brightness: Brightness.light,
          primarySwatch: Colors.blue,
          primaryColor: defaultTargetPlatform == TargetPlatform.iOS ? Colors.grey[50] : null,
          // accentColor: Colors.deepPurple,
          buttonColor: Colors.blueAccent,
          // textTheme: Theme.of(context).textTheme.apply(
          //   bodyColor: Colors.black,
          //   displayColor: Colors.red
          // ),
          // primaryTextTheme: Theme
          //   .of(context)
          //   .primaryTextTheme
          //   .apply(bodyColor: Colors.white)
        ),
        //home: PersonellerSayfa(),
        routes: {
          '/': (BuildContext context) =>
              !_isAuthenticated ? AuthPage() : PersonellerSayfa(_model),
          '/admin': (BuildContext context) =>
              !_isAuthenticated ? AuthPage() : PersonelAdminSayfa(_model),
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
