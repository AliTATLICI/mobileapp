import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../../scoped-models/main.dart';

class CikisYapListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Çıkış'),
          onTap: () {
            model.cikisYap();
            Navigator.pushReplacementNamed(context, '/');
          },
        );
      },
    );
  }
}
