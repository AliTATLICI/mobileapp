import 'package:flutter/material.dart';

class BolumTag extends StatelessWidget {
  final String bolum;

  BolumTag(this.bolum);

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey, width: 1.0),
                borderRadius: BorderRadius.circular(6.0)
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
                child: Text(bolum)));
    }
}